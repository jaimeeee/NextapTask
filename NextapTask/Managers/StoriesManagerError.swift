//
//  StoriesManagerError.swift
//  NextapTask
//

import Foundation

enum StoriesManagerError: Error {
    case storyNotFound
}

extension StoriesManagerError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .storyNotFound:
            return "The story couldn't be found 😞"
        }
    }
}
