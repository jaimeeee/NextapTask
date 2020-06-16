//
//  FeedListView.swift
//  NextapTask
//

import UIKit

protocol FeedListViewType: ErrorDisplayable {
    func updateList(with viewModel: FeedListViewModel)
}

class FeedListView: UIViewController {
    var presenter: FeedListPresenterType!
    private var viewModel: FeedListViewModel?
    
    private var collectionView: UICollectionView?
    
    private enum UIProperties {
        static let spacing: CGFloat = 12
    }
    
    // MARK: View Lifecycle
    
    override func viewDidLoad() {
        // CollectionView
        let collectionViewFlowLayout = UICollectionViewFlowLayout()
        collectionViewFlowLayout.minimumInteritemSpacing = UIProperties.spacing
        collectionViewFlowLayout.minimumLineSpacing = UIProperties.spacing * 2
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewFlowLayout)
        collectionView!.dataSource = self
        collectionView!.delegate = self
        collectionView!.register(StoryCollectionViewCell.self,
                                forCellWithReuseIdentifier: StoryCollectionViewCell.reuseIdentifier)
        view.addSubview(collectionView!)
        
        setupUI()
        presenter.viewDidLoad()
    }
    
    private func setupUI() {
        title = "Stories"
        
        if collectionView != nil {
            collectionView!.backgroundColor = .systemBackground
            collectionView!.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                collectionView!.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                collectionView!.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                collectionView!.topAnchor.constraint(equalTo: view.topAnchor),
                collectionView!.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
        }
    }
    
}

// MARK: - FeedListViewType
extension FeedListView: FeedListViewType {
    
    func updateList(with viewModel: FeedListViewModel) {
        self.viewModel = viewModel
        collectionView?.reloadData()
    }
    
}

// MARK: - UICollectionViewDataSource
extension FeedListView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.numberOfStories ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: StoryCollectionViewCell.reuseIdentifier, for: indexPath) as? StoryCollectionViewCell else {
            assertionFailure("⚠️ Error: Cell does not conform with StoryCollectionViewCell")
            return UICollectionViewCell()
        }
        guard let story = viewModel?.stories[indexPath.row] else {
            fatalError("⚠️ Error: [Story] index out of bounds")
        }
        cell.setupCell(with: story)
        return cell
    }
    
}

// MARK: - UICollectionViewDelegateFlowLayout
extension FeedListView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard viewModel != nil else { return }
        presenter.didSelectStory(viewModel!.stories[indexPath.row])
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: UIProperties.spacing,
                            left: UIProperties.spacing,
                            bottom: UIProperties.spacing,
                            right: UIProperties.spacing)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = (view.frame.width - (UIProperties.spacing * 3)) / 2
        let cellHeight = StoryCollectionViewCell.calculatedHeight(for: cellWidth)
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
}
