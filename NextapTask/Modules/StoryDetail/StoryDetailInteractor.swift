//
//  StoryDetailInteractor.swift
//  NextapTask
//

import Foundation

protocol StoryDetailInteractorType: class {
    var story: Story { get }
}

class StoryDetailInteractor {
    private let storiesManager: StoriesManagerType
    
    var story: Story
    
    init(storiesManager: StoriesManagerType, story: Story) {
        self.storiesManager = storiesManager
        self.story = story
    }
}

// MARK: - StoryDetailInteractorType
extension StoryDetailInteractor: StoryDetailInteractorType {
    
    
    
}
