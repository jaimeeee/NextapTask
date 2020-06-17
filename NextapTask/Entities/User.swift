//
//  User.swift
//  NextapTask
//

import Foundation

struct User: Decodable {
    let id: Identifier
    let displayName: String
    let avatarImageURL: URL
    
    enum CodingKeys: String, CodingKey {
        case id
        case displayName = "display_name"
        case avatarImageURL = "avatar_image_url"
    }
}
