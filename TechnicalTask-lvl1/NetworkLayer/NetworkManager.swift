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

    func request<T>(route: APIRoutable,
                    completion: @escaping (Result<T, any Error>) -> Void) where T : Decodable {
        
    }

    private func decodeData() {

    }
}
