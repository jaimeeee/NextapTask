//
//  App.swift
//  NextapTask
//

import Foundation

class App {
    static let shared = App()
    
    lazy var networkService = NetworkService()
    lazy var storiesManager = StoriesManager(networkService: networkService)
    
    private init() { }
    
}
