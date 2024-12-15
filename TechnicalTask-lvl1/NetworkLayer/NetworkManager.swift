//
//  NetworkManager.swift
//  TechnicalTask-lvl1
//
//  Created by Alexander Pavlovets on 11.12.24.
//
import Combine
import Foundation

protocol NetworkManager {
    func request<T: Decodable> (route: APIRoutable) -> AnyPublisher<T, APIError>
}

struct NetworkManagerImpl: NetworkManager {
    // MARK: - Properties
    private let session: URLSession
    private let urlBuilder: URLBuilder

    // MARK: - Initialization
    init(session: URLSession = .shared, urlBuilder: URLBuilder) {
        self.session = session
        self.urlBuilder = urlBuilder
    }

    //MARK: - Methods
    func request<T>(route: APIRoutable) -> AnyPublisher<T, APIError> where T : Decodable {
        do {
            let request = try urlBuilder.build(with: route)
            return session.dataTaskPublisher(for: request)
                .tryMap { output in
                    let httpResponse = output.response as? HTTPURLResponse
                    guard let httpResponse else {
                        throw APIError.serverError(message: "code \(String(describing: httpResponse?.statusCode))")
                    }
                    return output.data
                }
                .decode(type: T.self, decoder: JSONDecoder())
                .mapError { error in
                    return APIError.serverError(message: error.localizedDescription)
                }
                .eraseToAnyPublisher()
        } catch {
            return Fail(error: APIError.invalidResponse).eraseToAnyPublisher()
        }
    }
}
