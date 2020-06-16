//
//  StoryDetailView.swift
//  NextapTask
//

import UIKit

protocol StoryDetailViewType: class {
    
}

class StoryDetailView: UIViewController {
    var presenter: StoryDetailPresenterType!
    
    private let pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal)
    
    // MARK: View Lifecycle
    
    override func viewDidLoad() {
        pageViewController.dataSource = self
        addChild(pageViewController)
        view.addSubview(pageViewController.view)
        let testVC = UIViewController()
        testVC.view.backgroundColor = .systemBackground
        pageViewController.setViewControllers([testVC], direction: .forward, animated: false)
        pageViewController.didMove(toParent: self)
        presenter.viewDidLoad()
    }
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        pageViewController.view.backgroundColor = .systemBackground
        pageViewController.view.constraint(to: view)
    }
}

// MARK: - StoryDetailViewType
extension StoryDetailView: StoryDetailViewType {
    
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
