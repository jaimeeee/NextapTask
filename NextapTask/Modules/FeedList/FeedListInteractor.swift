//
//  FeedInteractor.swift
//  NextapTask
//

import Foundation

protocol FeedListInteractorType: class {
    func fetchStories(completion: @escaping (Result<[Story], Error>) -> Void)
}

class FeedListInteractor {
    private let storiesManager: StoriesManagerType
    private let userId: Identifier = "76794126980351029"
    
    init(storiesManager: StoriesManagerType) {
        self.storiesManager = storiesManager
    }
}

// MARK: - FeedListInteractorType
extension FeedListInteractor: FeedListInteractorType {
    
    func fetchStories(completion: @escaping (Result<[Story], Error>) -> Void) {
        storiesManager.fetchStories(for: userId) { completion($0) }
    }
    
}
