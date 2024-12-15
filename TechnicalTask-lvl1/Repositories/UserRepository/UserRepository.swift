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

struct userRepositoryImp: UserRepository {
    // MARK: - Properties
    private var networkManager: NetworkManager
    private var userRoute: UserRoute = .getUsers()

    // MARK: - Initialization
    init(networkManager: NetworkManager) {
        self.networkManager = networkManager
    }

    func fetchUsers() -> AnyPublisher<[UserModel], APIError> {
        networkManager.request(route: userRoute).eraseToAnyPublisher()
    }
}
