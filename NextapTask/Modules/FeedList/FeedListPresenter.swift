//
//  FeedListPresenter.swift
//  NextapTask
//

import Foundation

protocol FeedListPresenterType: class {
    var delegate: FeedListDelegate? { get set }
    func viewDidLoad()
    func didSelectStory(_ story: Story)
}

protocol FeedListDelegate: class {
    func displayStoryDetail(_ story: Story, transitioningDelegate: FeedListViewType?)
}

class FeedListPresenter {
    private let interactor: FeedListInteractorType
    
    weak var delegate: FeedListDelegate?
    weak var view: FeedListViewType?
    
    init(interactor: FeedListInteractorType) {
        self.interactor = interactor
    }
}

// MARK: - FeedListPresenterType
extension FeedListPresenter: FeedListPresenterType {
    
    func viewDidLoad() {
        interactor.fetchStories { [unowned view] result in
            switch result {
            case .success(let stories):
                DispatchQueue.main.async {
                    view?.updateList(with: FeedListViewModel(stories: stories))
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    view?.displayError(error)
                }
            }
        }
    }
    
    func didSelectStory(_ story: Story) {
        delegate?.displayStoryDetail(story, transitioningDelegate: view)
    }
    
}
