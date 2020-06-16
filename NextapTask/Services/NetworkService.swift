//
//  NetworkService.swift
//  NextapTask
//

import Foundation

enum NetworkServiceError: Error {
    case decodeError
    case invalidURL
    case invalidResponse
    case networkError(_ error: Error)
}

extension NetworkServiceError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .decodeError:
            return "The server sent something, but is not easy to understand it 😟"
        case .invalidURL:
            return "The request's URL is invalid 🤨"
        case .invalidResponse:
            return "The server's response was definitely not what we were expecting 😕"
        case .networkError:
            return "There was a network error 😶"
        }
    }
}

protocol NetworkServiceType: class {
    
    /// Creates a GET request for the selected endpoint.
    /// - Parameters:
    ///   - endpoint: `StellerAPI.Endpoint`
    ///   - completion: A `Result` including either a `Decodable` object or a `NetworkServiceError` if it fails.
    func get<T: Decodable>(_ endpoint: StellerAPI.Endpoint,
                           completion: @escaping (Result<T, NetworkServiceError>) -> Void)
}

class NetworkService: NetworkServiceType {
    
    private lazy var urlSession = URLSession.shared
    private let dataTaskProvider: DataTaskProvidable
    
    init(dataTaskProvider: DataTaskProvidable) {
        self.dataTaskProvider = dataTaskProvider
    }
    
    func get<T: Decodable>(_ endpoint: StellerAPI.Endpoint,
                           completion: @escaping (Result<T, NetworkServiceError>) -> Void) {
        print("📡 GET: \(endpoint)")
        guard let requestURL = URL(string: StellerAPI.baseURL + endpoint.path) else {
            completion(.failure(.invalidURL))
            return
        }
        
        dataTaskProvider.dataTask(with: URLRequest(url: requestURL)) { data, response, error in
            guard error == nil else {
                completion(.failure(.networkError(error!)))
                return
            }
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode, (200...299).contains(statusCode) else {
                completion(.failure(.invalidResponse))
                return
            }
            guard let requestData = data else {
                completion(.failure(.invalidResponse))
                return
            }
            do {
                let response = try JSONDecoder().decode(T.self, from: requestData)
                completion(.success(response))
            } catch {
                completion(.failure(.decodeError))
            }
        }.resume()
    }
    
}
