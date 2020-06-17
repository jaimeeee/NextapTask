//
//  StoryDetailPresenter.swift
//  NextapTask
//

import Foundation

enum StoryPosition {
    case storyBefore
    case storyAfter
}

protocol StoryDetailPresenterType: class {
    func storyDidAppear(with id: Identifier)
    func viewDidLoad()
    func viewModel(for position: StoryPosition) -> StoryViewModel?
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
    
    func storyDidAppear(with id: Identifier) {
        do {
            try interactor.movedToStory(with: id)
        } catch {
            DispatchQueue.main.async { [weak view] in
                view?.displayError(error)
            }
        }
    }
    
    func viewDidLoad() {
        view?.displayStory(with: StoryViewModel(id: interactor.currentStory.id,
                                                imageURL: interactor.currentStory.coverSrc,
                                                backgroundColor: interactor.currentStory.color,
                                                userName: interactor.currentStory.user.displayName,
                                                userImageURL: interactor.currentStory.user.avatarImageURL))
    }
    
    func viewModel(for position: StoryPosition) -> StoryViewModel? {
        guard let story = interactor.story(for: position) else { return nil }
        return StoryViewModel(id: story.id,
                              imageURL: story.coverSrc,
                              backgroundColor: story.color,
                              userName: story.user.displayName,
                              userImageURL: story.user.avatarImageURL)
    }
    
}
