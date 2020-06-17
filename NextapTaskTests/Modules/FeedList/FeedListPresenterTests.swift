//
//  FeedListPresenterTests.swift
//  NextapTaskTests
//

import XCTest
import Nimble
@testable import NextapTask

class FeedListPresenterTests: XCTestCase {
    
    private var bundle: Bundle!
    private var mockSession: MockSession!
    private var networkService: NetworkService!
    private var storiesManager: StoriesManager!
    private var feedListInteractor: FeedListInteractor!
    private var presenter: FeedListPresenter!

    override func setUp() {
        bundle = Bundle(for: type(of: self))
        mockSession = MockSession()
        networkService = NetworkService(session: mockSession)
        storiesManager = StoriesManager(networkService: networkService)
        feedListInteractor = FeedListInteractor(storiesManager: storiesManager)
        presenter = FeedListPresenter(interactor: feedListInteractor)
        super.setUp()
    }
    
    override func tearDown() {
        mockSession = nil
        networkService = nil
        storiesManager = nil
        feedListInteractor = nil
        presenter = nil
        super.tearDown()
    }
    
    func testDidSelectStory() {
        // Given
        let user = User(id: "1", displayName: "Name", avatarImageURL: nil)
        let story = Story(id: "1", coverSrc: URL(string: "https://example.com")!, user: user)
        let delegate = MockFeedListDelegate()
        
        // When
        presenter.delegate = delegate
        presenter.didSelectStory(story)
        
        // Then
        expect(delegate.story).toNot(beNil())
    }

    func testViewDidLoadWithStories() {
        // Given
        mockSession.loadJSONResponse(bundle: bundle, named: "UserStories", statusCode: 200, error: nil)
        let view = MockFeedListView()
        
        // When
        presenter.view = view
        presenter.viewDidLoad()
        
        // Then
        expect(view.viewModel).toEventuallyNot(beNil())
    }

    func testViewDidLoadWithError() {
        // Given
        let view = MockFeedListView()
        
        // When
        presenter.view = view
        presenter.viewDidLoad()
        
        // Then
        expect(view.error).toEventuallyNot(beNil())
    }

}

// MARK: - MockFeedListDelegate
class MockFeedListDelegate: FeedListDelegate {
    var story: Story?
    
    func displayStoryDetail(_ story: Story) {
        self.story = story
    }
}

// MARK: - MockFeedListView
class MockFeedListView: FeedListViewType {
    var viewModel: FeedListViewModel?
    var error: Error?
    
    func updateList(with viewModel: FeedListViewModel) {
        self.viewModel = viewModel
    }
    
    func displayError(_ error: Error) {
        self.error = error
    }
}
