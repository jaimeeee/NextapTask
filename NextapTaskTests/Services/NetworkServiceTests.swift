//
//  NetworkServiceTests.swift
//  NextapTaskTests
//

import XCTest
import Nimble
@testable import NextapTask

class NetworkServiceTests: XCTestCase {
    
    private var bundle: Bundle!
    private var mockSession: MockSession!
    private var networkService: NetworkService!
    
    typealias StoriesResult = Result<StoriesResponse, NetworkServiceError>
    
    override func setUp() {
        bundle = Bundle(for: type(of: self))
        mockSession = MockSession()
        networkService = NetworkService(session: mockSession)
    }

    func testNetworkError() {
        // Given
        mockSession.mockResponse(data: nil, statusCode: 200, error: URLError(.networkConnectionLost))
        
        // When
        waitUntil { done in
            self.networkService.get(.userStories(userId: "1")) { (result: StoriesResult) in
                // Then
                switch result {
                case .failure(let error):
                    expect(error).to(matchError(NetworkServiceError.self))
                default: break
                }
                done()
            }
        }
    }
    
    func testServiceErrors() {
        // Given
        let scenarios: [(data: Data?, statusCode: Int, error: Error?, expectation: Error)] = [
            (data: nil, statusCode: 404, error: nil, expectation: NetworkServiceError.invalidResponse),
            (data: nil, statusCode: 200, error: nil, expectation: NetworkServiceError.invalidResponse),
            (data: Data(), statusCode: 200, error: nil, expectation: NetworkServiceError.decodeError)
        ]
        
        for scenario in scenarios {
            mockSession.mockResponse(data: scenario.data, statusCode: scenario.statusCode, error: scenario.error)
            
            // When
            waitUntil { done in
                self.networkService.get(.userStories(userId: "1")) { (result: StoriesResult) in
                    // Then
                    switch result {
                    case .failure(let error):
                        expect(error).to(matchError(scenario.expectation))
                    default: break
                    }
                    done()
                }
            }
        }
    }

}
