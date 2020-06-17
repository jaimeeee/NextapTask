//
//  StoryViewController.swift
//  NextapTask
//

import UIKit
import Kingfisher

protocol StoryViewControllerDelegate: class {
    /// Notifies the delegate that a story's `viewDidAppear()`.
    /// - Parameter id: The `Identifier` of the story.
    func storyDidAppear(with id: Identifier)
}

class StoryViewController: UIViewController {
    weak var delegate: StoryViewControllerDelegate?
    
    private var storyImageView = UIImageView()
    private var viewModel: StoryViewModel? {
        didSet {
            guard viewModel != nil else { return }
            storyImageView.kf.setImage(with: viewModel!.imageURL)
        }
    }
    
    // MARK: View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        storyImageView.contentMode = .scaleAspectFit
        storyImageView.clipsToBounds = true
        view.addSubview(storyImageView)
        setupUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        guard viewModel != nil else { return }
        delegate?.storyDidAppear(with: viewModel!.id)
    }
    
    private func setupUI() {
        storyImageView.constraint(to: view)
    }
    
    // MARK: Content
    
    func display(viewModel: StoryViewModel) {
        self.viewModel = viewModel
    }

}
