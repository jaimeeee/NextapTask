//
//  StoryViewController.swift
//  NextapTask
//

import UIKit
import Kingfisher

class StoryViewController: UIViewController {
    private var storyImageView = UIImageView()
    
    // MARK: View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        storyImageView.contentMode = .scaleAspectFit
        storyImageView.clipsToBounds = true
        view.addSubview(storyImageView)
        setupUI()
    }
    
    private func setupUI() {
        storyImageView.constraint(to: view)
    }
    
    // MARK: Content
    
    func displayImage(with url: URL) {
        storyImageView.kf.setImage(with: url)
    }

}
