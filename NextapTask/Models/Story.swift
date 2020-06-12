//
//  Story.swift
//  NextapTask
//

import Foundation

struct Story: Decodable {
    let id: Identifier
    let coverSrc: URL
    let user: User
    
    enum CodingKeys: String, CodingKey {
        case id
        case coverSrc = "cover_src"
        case user
    }
}
