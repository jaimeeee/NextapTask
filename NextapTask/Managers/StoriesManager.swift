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
    func fetchStory(with id: Identifier) throws -> Story
    
    /// Retrieves a single story before or after the provided `Identifier`.
    /// - Parameters:
    ///   - id: The `Identifier` of the `Story` to navigate from.
    ///   - position: The navigation's direction.
    func story(from id: Identifier, position: StoryPosition) -> Story?
}

// MARK: - StoriesManager
class StoriesManager {
    private typealias StoriesResult = Result<StoriesResponse, NetworkServiceError>
    
    private var stories: [Story] = []
    private let networkService: NetworkServiceType
    
    init(networkService: NetworkServiceType) {
        self.networkService = networkService
    }
}

// MARK: - StoriesManagerType
extension StoriesManager: StoriesManagerType {
    
    func fetchStories(for userId: Identifier, completion: @escaping (Result<[Story], Error>) -> Void) {
        networkService.get(.userStories(userId: userId)) { [weak self] (result: StoriesResult) in
            switch result {
            case .success(let storiesResponse):
                self?.stories = storiesResponse.data
                completion(.success(storiesResponse.data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func fetchStory(with id: Identifier) throws -> Story {
        guard let story = stories.filter({ $0.id == id }).first else {
            throw StoriesManagerError.storyNotFound
        }
        return story
    }
    
    func story(from id: Identifier, position: StoryPosition) -> Story? {
        guard let index = stories.firstIndex(where: { $0.id == id }) else {
            return nil
        }
        switch position {
        case .storyBefore:
            guard index - 1 >= 0 else { return nil }
            return stories[index - 1]
        case .storyAfter:
            guard index + 1 < stories.count else { return nil }
            return stories[index + 1]
        }
    }
}
