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
    
    private var collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
    
    override func viewDidLoad() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(StoryCollectionViewCell.self,
                                forCellWithReuseIdentifier: StoryCollectionViewCell.reuseIdentifier)
        view.addSubview(collectionView)
        setupUI()
        presenter.viewDidLoad()
    }
    
    private func setupUI() {
        title = "Stories"
        view.backgroundColor = .systemBackground
    }
    
}

// MARK: - FeedListViewType
extension FeedListView: FeedListViewType {
    
    func updateList(with viewModel: FeedListViewModel) {
        self.viewModel = viewModel
        collectionView.reloadData()
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
        return UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 260, height: 260)
    }
    
}
