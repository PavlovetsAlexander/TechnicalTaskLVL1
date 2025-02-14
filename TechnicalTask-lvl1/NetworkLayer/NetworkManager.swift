//
//  NetworkManager.swift
//  TechnicalTask-lvl1
//
//  Created by Alexander Pavlovets on 11.12.24.
//
import Combine
import Foundation

protocol NetworkManager {
    func makeRequest<T: Decodable> (request: URLRequest) -> AnyPublisher<T, RequestError>
}

struct NetworkManagerImplementation: NetworkManager {
    // MARK: - Properties
    private let session: URLSession
    private let decoder = JSONDecoder()
    
    // MARK: - Initialization
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func makeRequest<T>(request: URLRequest) -> AnyPublisher<T, RequestError> where T : Decodable {
        return session.dataTaskPublisher(for: request)
            .tryMap { output in
                guard let httpResponse = output.response as? HTTPURLResponse else {
                    throw RequestError.invalidResponse
                }
                guard (200...299).contains(httpResponse.statusCode) else {
                    throw RequestError.serverError(message: "HTTP error with code: \(httpResponse.statusCode)")
                }
                return output.data
            }
            .decode(type: T.self, decoder: decoder)
            .mapError { error in
                return RequestError.connectionError(message: error.localizedDescription)
            }
            .eraseToAnyPublisher()
    }
}
