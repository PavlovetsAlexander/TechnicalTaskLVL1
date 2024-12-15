//
//  NetworkManager.swift
//  TechnicalTask-lvl1
//
//  Created by Alexander Pavlovets on 11.12.24.
//

import Foundation

protocol NetworkManager {
    func request<T: Decodable> (route: APIRoutable,
                                completion: @escaping (Result<T, Error>) -> Void)
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
    func request<T>(route: APIRoutable,
                    completion: @escaping (Result<T, any Error>) -> Void) where T : Decodable {
        do {
            let request = try urlBuilder.build(with: route)
            let task = session.dataTask(with: request) { data, response, error in
                if let error = error {
                    completion(.failure(APIError.serverError(message: error.localizedDescription)))
                    return
                }

                guard let data else {
                    completion(.failure(APIError.serverError(message: "No data received")))
                    return
                }

                do {
                    let decodedResponse = try JSONDecoder().decode(T.self, from: data)
                    completion(.success(decodedResponse))
                } catch {
                    completion(.failure(APIError.decodedError))
                }
            }
            task.resume()
        } catch {
            completion(.failure(APIError.invalidResponse))
        }
    }
}
