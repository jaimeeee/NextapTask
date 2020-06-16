//
//  DataTaskProvider.swift
//  NextapTask
//

import Foundation

protocol DataTaskResumable {
    func resume()
}

protocol DataTaskProvidable {
    func dataTask(with request: URLRequest,
                  completion: @escaping (Data?, URLResponse?, Error?) -> Void) -> DataTaskResumable
}
