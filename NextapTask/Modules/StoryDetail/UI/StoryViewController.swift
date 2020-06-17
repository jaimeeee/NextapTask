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
    
    private var navigationBar = UINavigationBar()
    private var userImageView = UIImageView()
    private var userLabel = UILabel()
    private var gradientView = UIView()
    private var gradientDrawn = false
    private var storyImageView = UIImageView()
    private var viewModel: StoryViewModel? {
        didSet {
            reloadView()
        }
    }
    
    private enum UIProperties {
        static let tintColor: UIColor = .white
        static let closeImage = UIImage(systemName: "xmark")
        static let userImageSize = CGSize(width: 32, height: 32)
        static let userLabelFontSize: CGFloat = 14
        static let navigationBarPadding: CGFloat = 12
        static let itemsSpacing: CGFloat = 6
        
        static let gradientStartColor = UIColor.black.withAlphaComponent(0.4).cgColor
        static let gradientEndColor = UIColor.black.withAlphaComponent(0).cgColor
    }
    
    // MARK: View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(storyImageView)
        view.addSubview(gradientView)
        view.addSubview(navigationBar)
        navigationBar.addSubview(userImageView)
        navigationBar.addSubview(userLabel)
        
        setupConstraints()
        setupUI()
        setupNavigationBar()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        guard viewModel != nil else { return }
        delegate?.storyDidAppear(with: viewModel!.id)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        guard !gradientDrawn else { return }
        addGradient()
    }
    
    // MARK: UI
    
    private func setupNavigationBar() {
        let closeButton = UIBarButtonItem(image: UIProperties.closeImage,
                                          style: .done,
                                          target: self,
                                          action: #selector(closeView))
        let navigationItem = UINavigationItem()
        navigationItem.rightBarButtonItem = closeButton
        navigationBar.pushItem(navigationItem, animated: false)
    }
    
    private func setupUI() {
        view.backgroundColor = .black
        
        storyImageView.contentMode = .scaleAspectFit
        storyImageView.clipsToBounds = true
        
        userImageView.layer.cornerRadius = UIProperties.userImageSize.width / 2
        userImageView.layer.masksToBounds = true
        
        userLabel.font = UIFont.boldSystemFont(ofSize: UIProperties.userLabelFontSize)
        userLabel.textColor = UIProperties.tintColor
        
        navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationBar.shadowImage = UIImage()
        navigationBar.tintColor = .white
    }
    
    private func setupConstraints() {
        storyImageView.constraint(to: view)
        
        userImageView.translatesAutoresizingMaskIntoConstraints = false
        userLabel.translatesAutoresizingMaskIntoConstraints = false
        navigationBar.translatesAutoresizingMaskIntoConstraints = false
        gradientView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            navigationBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            navigationBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            navigationBar.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            
            userImageView.widthAnchor.constraint(equalToConstant: UIProperties.userImageSize.width),
            userImageView.heightAnchor.constraint(equalToConstant: UIProperties.userImageSize.height),
            userImageView.leadingAnchor.constraint(equalTo: navigationBar.leadingAnchor,
                                                   constant: UIProperties.navigationBarPadding),
            userImageView.centerYAnchor.constraint(equalTo: navigationBar.centerYAnchor),
            
            userLabel.leadingAnchor.constraint(equalTo: userImageView.trailingAnchor,
                                               constant: UIProperties.itemsSpacing),
            userLabel.centerYAnchor.constraint(equalTo: navigationBar.centerYAnchor),
            
            gradientView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            gradientView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            gradientView.topAnchor.constraint(equalTo: view.topAnchor),
            gradientView.bottomAnchor.constraint(equalTo: navigationBar.bottomAnchor)
        ])
    }
    
    private func addGradient() {
        gradientDrawn.toggle()
        let gradient = CAGradientLayer()
        gradient.frame = gradientView.bounds
        gradient.colors = [UIProperties.gradientStartColor, UIProperties.gradientEndColor]
        gradientView.layer.insertSublayer(gradient, at: 0)
    }
    
    // MARK: Content
    
    func display(viewModel: StoryViewModel) {
        self.viewModel = viewModel
    }
    
    private func reloadView() {
        guard viewModel != nil else { return }
        userLabel.text = viewModel!.userName
        userImageView.kf.setImage(with: viewModel!.userImageURL)
        storyImageView.kf.setImage(with: viewModel!.imageURL)
        
        if let backgroundColor = viewModel?.backgroundColor, let color = UIColor(hex: backgroundColor) {
            view.backgroundColor = color
        } else {
            view.backgroundColor = .black
        }
        
    }
    
    // MARK: Selectors
    
    @objc func closeView() {
        dismiss(animated: true, completion: nil)
    }

}
