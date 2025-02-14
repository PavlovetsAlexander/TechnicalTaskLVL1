//
//  NetworkManagerStub.swift
//  TechnicalTask-lvl1Tests
//
//  Created by Alexander Pavlovets on 16.12.24.
//

import Foundation
import Combine
@testable import TechnicalTask_lvl1

final class NetworkManagerStub: NetworkManager {
    private var mockResponse: AnyPublisher<Data, RequestError>

    // MARK: - Initialization
    init(mockResponse: AnyPublisher<Data, RequestError>) {
        self.mockResponse = mockResponse
    }

    // MARK: - Methods
    func makeRequest<T>(request: URLRequest) -> AnyPublisher<T, TechnicalTask_lvl1.RequestError> where T : Decodable {
        return mockResponse
            .tryMap { data in
                guard let decodedResponse = try? JSONDecoder().decode(T.self, from: data) else {
                    throw RequestError.decodedError(message: "decoding error")
                }
                return decodedResponse
            }
            .mapError { error in
                return RequestError.connectionError(message: error.localizedDescription)
            }
            .eraseToAnyPublisher()
    }
}
