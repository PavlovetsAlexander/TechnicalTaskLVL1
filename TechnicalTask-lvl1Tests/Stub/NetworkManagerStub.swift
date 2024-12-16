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
    private var mockResponse: AnyPublisher<Data, APIError>

    // MARK: - Initialization
    init(mockResponse: AnyPublisher<Data, APIError>) {
        self.mockResponse = mockResponse
    }

    // MARK: - Methods
    func request<T>(route: APIRoutable) -> AnyPublisher<T, APIError> where T: Decodable {
        return mockResponse
            .tryMap { data in
                guard let decodedResponse = try? JSONDecoder().decode(T.self, from: data) else {
                    throw APIError.decodedError(message: "decoding error")
                }
                return decodedResponse
            }
            .mapError { error in
                return APIError.connectionError(message: error.localizedDescription)
            }
            .eraseToAnyPublisher()
    }
}
