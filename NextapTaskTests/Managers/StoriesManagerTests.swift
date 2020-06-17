//
//  StoriesManagerTests.swift
//  NextapTaskTests
//

import XCTest
import Nimble
@testable import NextapTask

class StoriesManagerTests: XCTestCase {
    
    private let userId: Identifier = "76794126980351029"
    private var bundle: Bundle!
    private var mockSession: MockSession!
    private var networkService: NetworkService!
    private var storiesManager: StoriesManager!
    
    override func setUp() {
        bundle = Bundle(for: type(of: self))
        mockSession = MockSession()
        networkService = NetworkService(session: mockSession)
        storiesManager = StoriesManager(networkService: networkService)
        super.setUp()
    }
    
    override func tearDown() {
        bundle = nil
        mockSession = nil
        networkService = nil
        storiesManager = nil
        super.tearDown()
    }
    
    func testFetchStories() {
        // Given
        mockSession.loadJSONResponse(bundle: bundle, named: "UserStories", statusCode: 200, error: nil)
        
        // When
        storiesManager.fetchStories(for: userId) { result in
            // Then
            switch result {
            case .success(let stories):
                expect(stories).toNot(beEmpty())
            case .failure(let error):
                fail(error.localizedDescription)
            }
        }
    }
    
    func testFetchStoriesError() {
        // Given
        mockSession.loadJSONResponse(bundle: bundle, named: "UserStories", statusCode: 404, error: nil)
        
        // When
        waitUntil { done in
            self.storiesManager.fetchStories(for: "") { result in
                // Then
                switch result {
                case .failure(let error):
                    expect(error).toNot(beNil())
                    done()
                default:
                    fail()
                }
            }
        }
    }
    
    func testFetchStory() {
        // Given
        mockSession.loadJSONResponse(bundle: bundle, named: "UserStories", statusCode: 200, error: nil)
        let scenarios: [(storyId: Identifier, throwsError: Bool)] = [
            (storyId: "1639306299789281145", throwsError: false),
            (storyId: "", throwsError: true)
        ]
        
        // When
        storiesManager.fetchStories(for: userId) { _ in }
        
        // Then
        for scenario in scenarios {
            if scenario.throwsError {
                expect { try self.storiesManager.fetchStory(with: scenario.storyId) }
                    .toEventually(throwError(StoriesManagerError.storyNotFound))
            } else {
                expect { try self.storiesManager.fetchStory(with: scenario.storyId) }
                    .toEventuallyNot(throwError())
            }
        }
    }
    
    func testStoryWithDirection() {
        // Given
        mockSession.loadJSONResponse(bundle: bundle, named: "UserStories", statusCode: 200, error: nil)
        let scenarios: [(start: Identifier, position: StoryPosition, result: Identifier?)] = [
            (start: "1862741207650666391", position: .storyBefore, result: nil),
            (start: "1639306299789281145", position: .storyBefore, result: "1862741207650666391"),
            (start: "1639306299789281145", position: .storyAfter, result: "1593487551547574230"),
            (start: "294196141442991526", position: .storyAfter, result: nil),
            (start: "foo", position: .storyAfter, result: nil)
        ]
        
        // When
        waitUntil { done in
            self.storiesManager.fetchStories(for: self.userId) { result in
                switch result {
                case .success(let stories):
                    print(stories.map(\.id))
                case .failure(let error):
                    fail(error.localizedDescription)
                }
                done()
            }
        }
        
        // Then
        for scenario in scenarios {
            expect(self.storiesManager.story(from: scenario.start, position: scenario.position)?.id)
                .to(scenario.result == nil ? beNil() : equal(scenario.result))
        }
    }
    
}
