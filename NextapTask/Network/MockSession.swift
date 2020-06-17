//
//  MockSession.swift
//  NextapTask
//

import Foundation

class MockSessionDataTask: NetworkSessionDataTask {
    private let closure: () -> Void

    init(closure: @escaping () -> Void) {
        self.closure = closure
    }

    func resume() {
        closure()
    }
    
}

class MockSession: NetworkSession {
    private var data: Data?
    private var statusCode = 200
    private var error: Error?
    
    func dataTask(with url: URL, completion: @escaping NetworkSessionResponse) -> NetworkSessionDataTask {
        let data = self.data
        let response = HTTPURLResponse(url: url, statusCode: statusCode, httpVersion: nil, headerFields: nil)
        let error = self.error
        return MockSessionDataTask {
            completion(data, response, error)
        }
    }
    
    func mockResponse(data: Data?, statusCode: Int, error: Error?) {
        self.data = data
        self.statusCode = statusCode
        self.error = error
    }
    
    func loadJSONResponse(bundle: Bundle, named: String, statusCode: Int, error: Error?) {
        self.statusCode = statusCode
        self.error = error
        if let path = bundle.path(forResource: named, ofType: "json") {
            do {
                data = try Data(contentsOf: URL(fileURLWithPath: path))
            } catch {
                fatalError("Can't read JSON File")
            }
        } else {
            fatalError("Can't read JSON File")
        }
    }
    
}
