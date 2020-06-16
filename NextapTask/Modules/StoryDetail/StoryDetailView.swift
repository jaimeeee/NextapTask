//
//  StoryDetailView.swift
//  NextapTask
//

import UIKit

protocol StoryDetailViewType: class {
    func displayStory(with imageURL: URL)
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
    
    private func storyViewController(for imageURL: URL) -> StoryViewController {
        let viewController = StoryViewController()
        viewController.displayImage(with: imageURL)
        return viewController
    }
}

// MARK: - StoryDetailViewType
extension StoryDetailView: StoryDetailViewType {
    
    func displayStory(with imageURL: URL) {
        let viewController = storyViewController(for: imageURL)
        pageViewController.setViewControllers([viewController], direction: .forward, animated: false)
    }
    
}

// MARK: - UIPageViewControllerDataSource
extension StoryDetailView: UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerBefore viewController: UIViewController) -> UIViewController? {
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerAfter viewController: UIViewController) -> UIViewController? {
        return nil
    }
    
}
