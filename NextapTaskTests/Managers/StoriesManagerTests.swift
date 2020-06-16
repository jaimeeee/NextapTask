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
        var story: Story?
        
        // When
        storiesManager.fetchStories(for: userId) { _ in
            storiesManager.fetchStory(with: "1639306299789281145") { result in
                switch result {
                case .success(let response):
                    story = response
                case .failure(let error):
                    fail(error.localizedDescription)
                }
            }
        }
        
        // Then
        expect(story).toEventuallyNot(beNil(), timeout: 3)
    }
    
    func testStoryNotFoundError() {
        // Given
        let storiesManager = StoriesManager(networkService: networkService)
        var storyError: Error?
        
        // When
        storiesManager.fetchStory(with: "1") { result in
            switch result {
            case .failure(let error):
                storyError = error
            default:
                break
            }
        }
        
        // Then
        expect(storyError).toEventually(matchError(StoriesManagerError.storyNotFound))
    }

}
