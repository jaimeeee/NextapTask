//
//  StoryDetailPresenterTests.swift
//  NextapTaskTests
//
//  Created by Jaime Zaragoza on 17/06/2020.
//  Copyright © 2020 Jaimeeee. All rights reserved.
//

import XCTest
import Nimble
@testable import NextapTask

class StoryDetailPresenterTests: XCTestCase {
    
    private let userId: Identifier = "76794126980351029"
    private var bundle: Bundle!
    private var mockSession: MockSession!
    private var networkService: NetworkService!
    private var storiesManager: StoriesManager!
    private var storyDetailInteractor: StoryDetailInteractor!
    private var presenter: StoryDetailPresenter!

    override func setUp() {
        bundle = Bundle(for: type(of: self))
        mockSession = MockSession()
        mockSession.loadJSONResponse(bundle: bundle, named: "UserStories", statusCode: 200, error: nil)
        networkService = NetworkService(session: mockSession)
        storiesManager = StoriesManager(networkService: networkService)
        let user = User(id: "1", displayName: "Name", avatarImageURL: nil)
        let story = Story(id: "1862741207650666391", coverSrc: URL(string: "https://example.com")!, user: user)
        storyDetailInteractor = StoryDetailInteractor(storiesManager: storiesManager, story: story)
        presenter = StoryDetailPresenter(interactor: storyDetailInteractor)
        super.setUp()
    }
    
    override func tearDown() {
        mockSession = nil
        networkService = nil
        storiesManager = nil
        storyDetailInteractor = nil
        presenter = nil
        super.tearDown()
    }
    
    func testStoryDidAppear() {
        // Given
        let view = MockStoryDetailView()
        
        // When
        presenter.view = view
        presenter.storyDidAppear(with: "0")
        
        // Then
        expect(view.error).toEventuallyNot(beNil())
    }
    
    func testViewDidLoad() {
        // Given
        let view = MockStoryDetailView()
        
        // When
        presenter.view = view
        presenter.viewDidLoad()
        
        // Then
        expect(view.viewModel).toNot(beNil())
    }
    
    func testViewModelForPosition() {
        // When
        storiesManager.fetchStories(for: userId) { _ in }
        
        // Then
        expect(self.presenter.viewModel(for: .storyBefore)).to(beNil())
        expect(self.presenter.viewModel(for: .storyAfter)).toNot(beNil())
        
    }

}

// MARK: - MockStoryDetailView
class MockStoryDetailView: StoryDetailViewType {
    var viewModel: StoryViewModel?
    var error: Error?
    
    func displayStory(with viewModel: StoryViewModel) {
        self.viewModel = viewModel
    }
    
    func displayError(_ error: Error) {
        self.error = error
    }
}
