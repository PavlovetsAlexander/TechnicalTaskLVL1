//
//  UserRepository.swift
//  TechnicalTask-lvl1
//
//  Created by Alexander Pavlovets on 15.12.24.
//

import Foundation
import Combine

protocol UserRepository {
    func fetchUsers() -> AnyPublisher<[UserModel], APIError>
}

struct UserRepositoryImpl: UserRepository {
    // MARK: - Properties
    private var networkManager: NetworkManager

    // MARK: - Initialization
    init(networkManager: NetworkManager) {
        self.networkManager = networkManager
    }

    func fetchUsers() -> AnyPublisher<[UserModel], APIError> {
        let route = UserRoute.getUsers()
        return networkManager.request(route: route).eraseToAnyPublisher()
    }
}
