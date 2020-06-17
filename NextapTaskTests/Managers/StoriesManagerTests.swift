//
//  StoriesManagerTests.swift
//  NextapTaskTests
//

import XCTest
import Nimble
@testable import NextapTask

class StoriesManagerTests: XCTestCase {
    
    private let userId: Identifier = "76794126980351029"
    private let networkService = NetworkService(dataTaskProvider: URLSession.shared)
    
    func testFetchStories() {
        // Given
        let storiesManager = StoriesManager(networkService: networkService)
        let scenarios: [(userId: String, throwsError: Bool)] = [
            (userId: userId, throwsError: false),
            (userId: "", throwsError: true)
        ]
        
        // When
        for scenario in scenarios {
            storiesManager.fetchStories(for: scenario.userId) { result in
                // Then
                switch result {
                case .success(let stories):
                    if !scenario.throwsError {
                        expect(stories).toNot(beEmpty())
                    } else {
                        fail()
                    }
                case .failure(let error):
                    if scenario.throwsError {
                        expect(error).to(matchError(NetworkServiceError.self))
                    } else {
                        fail(error.localizedDescription)
                    }
                }
            }
        }
    }
    
    func testFetchStoriesError() {
        // Given
        let storiesManager = StoriesManager(networkService: networkService)
        
        // When
        waitUntil(timeout: 3) { done in
            storiesManager.fetchStories(for: "") { result in
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
        let storiesManager = StoriesManager(networkService: networkService)
        let scenarios: [(storyId: Identifier, throwsError: Bool)] = [
            (storyId: "1639306299789281145", throwsError: false),
            (storyId: "", throwsError: true)
        ]
        
        // When
        storiesManager.fetchStories(for: userId) { _ in }
        
        // Then
        for scenario in scenarios {
            if scenario.throwsError {
                expect { try storiesManager.fetchStory(with: scenario.storyId) }
                    .toEventually(throwError(StoriesManagerError.storyNotFound))
            } else {
                expect { try storiesManager.fetchStory(with: scenario.storyId) }
                    .toEventuallyNot(throwError())
            }
        }
    }
    
    func testStoryWithDirection() {
        // Given
        let storiesManager = StoriesManager(networkService: networkService)
        let scenarios: [(start: Identifier, position: StoryPosition, result: Identifier?)] = [
            (start: "1639306299789281145", position: .storyBefore, result: nil),
            (start: "1593487551547574230", position: .storyBefore, result: "1639306299789281145"),
            (start: "1639306299789281145", position: .storyAfter, result: "1593487551547574230"),
            (start: "280364359924844106", position: .storyAfter, result: nil),
            (start: "foo", position: .storyAfter, result: nil)
        ]
        
        // When
        waitUntil(timeout: 3.0) { [weak self] done in
            guard let userId = self?.userId else {
                fail()
                return
            }
            storiesManager.fetchStories(for: userId) { result in
                switch result {
                case .success:
                    done()
                case .failure(let error):
                    fail(error.localizedDescription)
                }
            }
        }
        
        // Then
        for scenario in scenarios {
            expect(storiesManager.story(from: scenario.start, position: scenario.position)?.id)
                .to(scenario.result == nil ? beNil() : equal(scenario.result))
        }
    }
    
}
