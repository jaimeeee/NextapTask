//
//  URLSession+DataTaskProvidable.swift
//  NextapTask
//

import Foundation

// MARK: - DataTaskResumable
extension URLSessionDataTask: DataTaskResumable { }

// MARK: - DataTaskProvidable
extension URLSession: DataTaskProvidable {
    
    func dataTask(with url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> Void) -> DataTaskResumable {
        return dataTask(with: url, completionHandler: completion) as DataTaskResumable
    }
    
}
