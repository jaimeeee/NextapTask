//
//  StoryDetailInteractorTests.swift
//  NextapTaskTests
//

import XCTest
import Nimble
@testable import NextapTask

class StoryDetailInteractorTests: XCTestCase {
    
    private let userId: Identifier = "76794126980351029"
    private var bundle: Bundle!
    private var mockSession: MockSession!
    private var networkService: NetworkService!
    private var storiesManager: StoriesManager!
    private var interactor: StoryDetailInteractor!
    
    override func setUp() {
        bundle = Bundle(for: type(of: self))
        mockSession = MockSession()
        mockSession.loadJSONResponse(bundle: bundle, named: "UserStories", statusCode: 200, error: nil)
        networkService = NetworkService(session: mockSession)
        storiesManager = StoriesManager(networkService: networkService)
        let user = User(id: "1", displayName: "Name", avatarImageURL: URL(string: "https://example.com/")!)
        let story = Story(id: "1862741207650666391", coverSrc: URL(string: "https://example.com/")!, user: user)
        interactor = StoryDetailInteractor(storiesManager: storiesManager, story: story)
        super.setUp()
    }
    
    override func tearDown() {
        bundle = nil
        mockSession = nil
        networkService = nil
        storiesManager = nil
        interactor = nil
        super.tearDown()
    }
    
    func testMovedToStory() {// When
        storiesManager.fetchStories(for: "76794126980351029") { _ in }
        
        // Then
        expect { try self.interactor.movedToStory(with: "1639306299789281145") }.toEventuallyNot(throwError())
    }
    
    func testStoryForPosition() {
        // When
        storiesManager.fetchStories(for: "76794126980351029") { _ in }
        
        // Then
        expect(self.interactor.story(for: .storyAfter)).toEventuallyNot(beNil())
        expect(self.interactor.story(for: .storyBefore)).toEventually(beNil())
    }

}
