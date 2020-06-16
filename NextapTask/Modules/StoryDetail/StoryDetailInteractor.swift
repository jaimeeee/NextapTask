//
//  StoryDetailInteractor.swift
//  NextapTask
//

import Foundation

protocol StoryDetailInteractorType: class {
    
}

class StoryDetailInteractor {
    private let storiesManager: StoriesManagerType
    
    var story: Story
    
    init(storiesManager: StoriesManagerType, story: Story) {
        self.storiesManager = storiesManager
        self.story = story
    }
}

extension StoryDetailInteractor: StoryDetailInteractorType {
    
    
    
}
