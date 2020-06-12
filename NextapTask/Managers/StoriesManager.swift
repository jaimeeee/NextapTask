//
//  StoriesManager.swift
//  NextapTask
//

import Foundation

protocol StoriesManagerType: class {
    /// Fetches the Stories for the user with the provided `Identifier`.
    /// - Parameters:
    ///   - userId: The user's `Identifier`.
    ///   - completion: Callback with a `Result` object with a `[Story]` or an `Error` if it fails.
    func fetchStories(for userId: Identifier, completion: @escaping (Result<[Story], Error>) -> Void)
    
    /// Fetches a single story with the provided `Identifier`.
    /// - Parameters:
    ///   - id: The story's `Identifier`.
    ///   - completion: Callback with a `Result` object with a `Story` or an `Error` if it fails.
    func fetchStory(with id: Identifier, completion: @escaping (Result<Story, Error>) -> Void)
}

// MARK: - StoriesManager
class StoriesManager {
    private typealias StoriesResult = Result<StoriesResponse, NetworkServiceError>
    
    private var stories: [Identifier: Story] = [:]
    private let networkService: NetworkServiceType
    
    init(networkService: NetworkServiceType) {
        self.networkService = networkService
    }
}

// MARK: - StoriesManagerType
extension StoriesManager: StoriesManagerType {
    
    func fetchStories(for userId: Identifier, completion: @escaping (Result<[Story], Error>) -> Void) {
        networkService.get(.userStories(userId: userId)) { (result: StoriesResult) in
            switch result {
            case .success(let storiesResponse):
                storiesResponse.data.forEach { [weak self] in
                    self?.stories[$0.id] = $0
                }
                completion(.success(storiesResponse.data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func fetchStory(with id: Identifier, completion: @escaping (Result<Story, Error>) -> Void) {
        guard let story = stories[id] else {
            completion(.failure(StoriesManagerError.storyNotFound))
            return
        }
        completion(.success(story))
    }
}
