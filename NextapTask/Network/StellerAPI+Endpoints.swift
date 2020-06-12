//
//  StellerAPI+Endpoints.swift
//  NextapTask
//

import Foundation

extension StellerAPI {
    
    enum Endpoint {
        case userStories(userId: Identifier)
    }
    
}

extension StellerAPI.Endpoint {
    
    var path: String {
        switch self {
        case .userStories(let userId):
            return "/users/\(userId)/stories"
        }
    }
    
}
