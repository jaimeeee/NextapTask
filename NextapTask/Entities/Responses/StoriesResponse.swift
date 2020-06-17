//
//  StoriesResponse.swift
//  NextapTask
//

import Foundation

typealias Identifier = String

struct StoriesResponse: Decodable {
    var data: [Story]
    var before: Identifier
    var after: Identifier
    
    enum CodingKeys: String, CodingKey {
        case data
        case cursor
        case before
        case after
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        data = try container.decode([Story].self, forKey: .data)
        let cursor = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .cursor)
        before = try cursor.decode(Identifier.self, forKey: .before)
        after = try cursor.decode(Identifier.self, forKey: .after)
    }
}
