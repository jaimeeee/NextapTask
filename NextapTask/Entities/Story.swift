//
//  Story.swift
//  NextapTask
//

import Foundation

struct Story: Decodable {
    let id: Identifier
    let coverSrc: URL
    let color: String?
    let user: User
    
    enum CodingKeys: String, CodingKey {
        case id
        case coverSrc = "cover_src"
        case color = "cover_bg"
        case user
    }
}

extension Story {
    
    init(id: Identifier, coverSrc: URL, user: User) {
        self.id = id
        self.coverSrc = coverSrc
        self.color = nil
        self.user = user
    }
    
}
