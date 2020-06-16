//
//  SceneDelegate.swift
//  NextapTask
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    var coordinator: MainCoordinator?
    var dependencies: AppDependencies?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        // Setup dependencies
        let networkService = NetworkService(dataTaskProvider: URLSession.shared)
        let storiesManager = StoriesManager(networkService: networkService)
        let dependencies = AppDependencies(storiesManager: storiesManager)
        self.dependencies = dependencies
        
        // Root view controller
        let navigationController = UINavigationController()
        coordinator = MainCoordinator(navigationController: navigationController, dependencies: dependencies)
        coordinator?.start()
        
        // Show window
        let window = UIWindow(windowScene: windowScene)
        window.rootViewController = navigationController
        self.window = window
        window.makeKeyAndVisible()
    }
    
}
