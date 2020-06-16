//
//  AppDependencies.swift
//  NextapTask
//

import Foundation

protocol AppDependenciesType {
    var storiesManager: StoriesManagerType { get set }
}

class AppDependencies: AppDependenciesType {
    var storiesManager: StoriesManagerType
    
    init(storiesManager: StoriesManagerType) {
        self.storiesManager = storiesManager
    }
}
