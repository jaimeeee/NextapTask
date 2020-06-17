//
//  FeedListInteractorTests.swift
//  NextapTaskTests
//

import XCTest
import Nimble
@testable import NextapTask

class FeedListInteractorTests: XCTestCase {

    func testFetchStories() {
        // Given
        let bundle = Bundle(for: type(of: self))
        let mockSession = MockSession()
        mockSession.loadJSONResponse(bundle: bundle, named: "UserStories", statusCode: 200, error: nil)
        let networkService = NetworkService(session: mockSession)
        let storiesManager = StoriesManager(networkService: networkService)
        let interactor = FeedListInteractor(storiesManager: storiesManager)
        
        // When
        waitUntil { done in
            // Then
            interactor.fetchStories { result in
                switch result {
                case .success(let stories):
                    expect(stories).notTo(beEmpty())
                case .failure(let error):
                    fail(error.localizedDescription)
                }
                done()
            }
        }
    }

}
