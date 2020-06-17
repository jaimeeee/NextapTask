//
//  StoryDetailView.swift
//  NextapTask
//

import UIKit

protocol StoryDetailViewType: ErrorDisplayable {
    func displayStory(with viewModel: StoryViewModel)
}

class StoryDetailView: UIViewController {
    var presenter: StoryDetailPresenterType!
    
    private let pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal)
    
    // MARK: View Lifecycle
    
    override func viewDidLoad() {
        pageViewController.dataSource = self
        addChild(pageViewController)
        view.addSubview(pageViewController.view)
        pageViewController.didMove(toParent: self)
        presenter.viewDidLoad()
        setupUI()
    }
    
    // MARK: UI
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        pageViewController.view.constraint(to: view)
    }
    
    // MARK: Story
    
    private func storyViewController(with viewModel: StoryViewModel) -> StoryViewController {
        let viewController = StoryViewController()
        viewController.display(viewModel: viewModel)
        return viewController
    }
}

// MARK: - StoryDetailViewType
extension StoryDetailView: StoryDetailViewType {
    
    func displayStory(with viewModel: StoryViewModel) {
        let viewController = storyViewController(with: viewModel)
        pageViewController.setViewControllers([viewController], direction: .forward, animated: false)
    }
    
}

// MARK: - UIPageViewControllerDataSource
extension StoryDetailView: UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewModel = presenter.viewModel(for: .storyBefore) else { return nil }
        let viewController = storyViewController(with: viewModel)
        viewController.delegate = self
        return viewController
    }
    
    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewModel = presenter.viewModel(for: .storyAfter) else { return nil }
        let viewController = storyViewController(with: viewModel)
        viewController.delegate = self
        return viewController
    }
    
}

// MARK: - StoryViewControllerDelegate
extension StoryDetailView: StoryViewControllerDelegate {
    
    func storyDidAppear(with id: Identifier) {
        presenter.storyDidAppear(with: id)
    }
    
}
