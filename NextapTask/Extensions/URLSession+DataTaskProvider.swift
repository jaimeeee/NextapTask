//
//  URLSession+DataTaskProvider.swift
//  NextapTask
//

import Foundation

// MARK: - DataTaskResumable
extension URLSessionDataTask: DataTaskResumable { }

// MARK: - DataTaskProvidable
extension URLSession: DataTaskProvidable {
    
    func dataTask(with request: URLRequest,
                  completion: @escaping (Data?, URLResponse?, Error?) -> Void) -> DataTaskResumable {
        return dataTask(with: request, completionHandler: completion) as DataTaskResumable
    }
    
}
