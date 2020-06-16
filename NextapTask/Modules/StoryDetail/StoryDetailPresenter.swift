//
//  StoryDetailPresenter.swift
//  NextapTask
//

import Foundation

protocol StoryDetailPresenterType: class {
    func viewDidLoad()
}

class StoryDetailPresenter {
    private let interactor: StoryDetailInteractorType
    
    weak var view: StoryDetailViewType?
    
    init(interactor: StoryDetailInteractorType) {
        self.interactor = interactor
    }
}

// MARK: - StoryDetailPresenterType
extension StoryDetailPresenter: StoryDetailPresenterType {
    
    func viewDidLoad() {
        let imageURL = interactor.story.coverSrc
        view?.displayStory(with: imageURL)
    }
    
}
