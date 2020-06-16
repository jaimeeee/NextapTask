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

extension StoryDetailPresenter: StoryDetailPresenterType {
    
    func viewDidLoad() {
        
    }
    
}
