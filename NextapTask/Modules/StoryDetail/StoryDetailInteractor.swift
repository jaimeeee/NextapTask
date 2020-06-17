//
//  StoryDetailInteractor.swift
//  NextapTask
//

import Foundation

protocol StoryDetailInteractorType: class {
    var currentStory: Story { get }
    func movedToStory(with id: Identifier) throws
    func story(for position: StoryPosition) -> Story?
}

class StoryDetailInteractor {
    private let storiesManager: StoriesManagerType
    
    var currentStory: Story
    
    init(storiesManager: StoriesManagerType, story: Story) {
        self.storiesManager = storiesManager
        self.currentStory = story
    }
}

// MARK: - StoryDetailInteractorType
extension StoryDetailInteractor: StoryDetailInteractorType {
    
    func movedToStory(with id: Identifier) throws {
        let story = try storiesManager.fetchStory(with: id)
        self.currentStory = story
    }
    
    func story(for position: StoryPosition) -> Story? {
        guard let story = storiesManager.story(from: self.currentStory.id, position: position) else { return nil}
        self.currentStory = story
        return story
    }
    
}
