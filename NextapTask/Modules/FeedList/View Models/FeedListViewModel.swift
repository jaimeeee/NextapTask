//
//  FeedListViewModel.swift
//  NextapTask
//

import Foundation

struct FeedListViewModel {
    let stories: [Story]
    
    var numberOfStories: Int {
        return stories.count
    }
    
}
