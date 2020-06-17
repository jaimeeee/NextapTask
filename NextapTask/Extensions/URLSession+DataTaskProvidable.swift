//
//  URLSession+NetworkSession.swift
//  NextapTask
//

import Foundation

// MARK: - NetworkSessionDataTask
extension URLSessionDataTask: NetworkSessionDataTask { }

// MARK: - NetworkSession
extension URLSession: NetworkSession {
    
    func dataTask(with url: URL, completion: @escaping NetworkSessionResponse) -> NetworkSessionDataTask {
        return dataTask(with: url, completionHandler: completion) as NetworkSessionDataTask
    }
    
}
