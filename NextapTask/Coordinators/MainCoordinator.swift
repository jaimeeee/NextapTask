//
//  MainCoordinator.swift
//  NextapTask
//

import UIKit

protocol Coordinator: class {
    var navigationController: UINavigationController { get set }
    
    func start()
}

// MARK: - Coordinator
class MainCoordinator: Coordinator {
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let view = FeedListView()
        let interactor = FeedListInteractor(storiesManager: App.shared.storiesManager)
        let presenter = FeedListPresenter(interactor: interactor)
        presenter.delegate = self
        presenter.view = view
        view.presenter = presenter
        navigationController.pushViewController(view, animated: false)
    }
    
}

// MARK: - FeedListDelegate
extension MainCoordinator: FeedListDelegate {
    
    func displayStoryDetail(_ story: Story) {
        
    }
    
}
