//
//  UserRepository.swift
//  TechnicalTask-lvl1
//
//  Created by Alexander Pavlovets on 15.12.24.
//

import Foundation
import Combine

protocol UserLocalRepository {
    func fetchUsers() -> AnyPublisher<[UserModel], RequestError>
}

struct UserLocalRepositoryImplementation: UserLocalRepository {
    // MARK: - Properties
    private var networkManager: NetworkManager

    // MARK: - Initialization
    init(networkManager: NetworkManager) {
        self.networkManager = networkManager
    }
    
    func fetchUsers() -> AnyPublisher<[UserModel], RequestError> {
        do {
            let request = try UserRoute.getUsers()
            return networkManager.makeRequest(request: request)
        } catch {
            return Fail(error: RequestError.invalidRequest(message: error.localizedDescription))
                .eraseToAnyPublisher()
        }
    }
}
