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
    var storiesManager: StoriesManagerType
    
    init(navigationController: UINavigationController, storiesManager: StoriesManagerType) {
        self.navigationController = navigationController
        self.storiesManager = storiesManager
    }
    
    func start() {
        let view = FeedListView()
        let interactor = FeedListInteractor(storiesManager: storiesManager)
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
        let view = StoryDetailView()
        let interactor = StoryDetailInteractor(storiesManager: storiesManager, story: story)
        let presenter = StoryDetailPresenter(interactor: interactor)
        presenter.view = view
        view.presenter = presenter
        navigationController.pushViewController(view, animated: true)
    }
    
}
