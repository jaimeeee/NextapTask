//
//  MockURLProtocol.swift
//  NextapTask
//

import Foundation

class MockURLProtocol: URLProtocol {
    
    static var mockURLs: [URL?: Data] = [:]
    
    override class func canInit(with request: URLRequest) -> Bool {
        return true
    }
    
    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }
    
    override func startLoading() {
        defer {
            client?.urlProtocolDidFinishLoading(self)
        }
        guard let url = request.url, let data = MockURLProtocol.mockURLs[url] else { return }
        client?.urlProtocol(self, didLoad: data)
    }
    
    override func stopLoading() {
        
    }
    
}
