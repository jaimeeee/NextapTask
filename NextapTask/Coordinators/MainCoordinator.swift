//
//  MainCoordinator.swift
//  NextapTask
//

import UIKit

protocol Coordinator: class {
    var navigationController: UINavigationController { get set }
    
    /// Executes the entry point of the coordinator.
    func start()
}

// MARK: - Coordinator
class MainCoordinator: Coordinator {
    var navigationController: UINavigationController
    var dependencies: AppDependenciesType
    
    init(navigationController: UINavigationController, dependencies: AppDependenciesType) {
        self.navigationController = navigationController
        self.dependencies = dependencies
    }
    
    func start() {
        setupNavigationController()
        
        let view = FeedListView()
        let interactor = FeedListInteractor(storiesManager: dependencies.storiesManager)
        let presenter = FeedListPresenter(interactor: interactor)
        presenter.delegate = self
        presenter.view = view
        view.presenter = presenter
        navigationController.pushViewController(view, animated: false)
    }
    
    private func setupNavigationController() {
        navigationController.navigationBar.prefersLargeTitles = true
    }
    
}

// MARK: - FeedListDelegate
extension MainCoordinator: FeedListDelegate {
    
    func displayStoryDetail(_ story: Story, transitioningDelegate: FeedListViewType?) {
        let view = StoryDetailView()
        view.modalPresentationStyle = .fullScreen
        let interactor = StoryDetailInteractor(storiesManager: dependencies.storiesManager, story: story)
        let presenter = StoryDetailPresenter(interactor: interactor)
        presenter.view = view
        view.presenter = presenter
        view.transitioningDelegate = transitioningDelegate
        navigationController.visibleViewController?.present(view, animated: true, completion: nil)
    }
    
}
