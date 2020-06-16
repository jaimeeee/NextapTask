//
//  DataTaskProvidable.swift
//  NextapTask
//

import Foundation

protocol DataTaskResumable {
    /// Resumes the task, if it is suspended.
    func resume()
}

protocol DataTaskProvidable {
    /// Creates a task that retrieves the contents of the specified URL, then calls a handler upon completion.
    /// - Parameters:
    ///   - url: The `URL` to be retrieved.
    ///   - completion: The completion handler to call when the load request is complete.
    func dataTask(with url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> Void) -> DataTaskResumable
}
