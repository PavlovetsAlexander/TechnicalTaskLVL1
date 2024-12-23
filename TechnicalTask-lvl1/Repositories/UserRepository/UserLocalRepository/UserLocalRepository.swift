//
//  UserLocalRepository.swift
//  TechnicalTask-lvl1
//
//  Created by Alexander Pavlovets on 23.12.24.
//

import Foundation
import Combine

protocol UserLocalRepository {
    func saveUsers(_ users: [UserModel]) -> AnyPublisher<Void, CoreDataError>
    func save(_ user: UserModel) -> AnyPublisher<Void, CoreDataError>
    func loadUsers() -> AnyPublisher<[UserModel], CoreDataError>
    func deleteUser(user: UserModel) ->  AnyPublisher<Void, CoreDataError>

}

final class UserLocalRepositoryImplementation: UserLocalRepository {
    // MARK: - Properties
    private var coreDataManager: CoreDataManager

    // MARK: - Initialization
    init(coreDataManager: CoreDataManager) {
        self.coreDataManager = coreDataManager
    }

    // MARK: - Methods
    func save(_ user: UserModel) -> AnyPublisher<Void, CoreDataError> {
        coreDataManager.saveUser(user)
              .mapError { $0 }
              .eraseToAnyPublisher()
    }

    func loadUsers() -> AnyPublisher<[UserModel], CoreDataError> {
        coreDataManager.loadUsers(predicate: nil)
            .map { $0.map { UserModel(from: $0) } }
            .eraseToAnyPublisher()
    }

    func deleteUser(user: UserModel) -> AnyPublisher<Void, CoreDataError> {
        coreDataManager.delete(user: user.name).eraseToAnyPublisher()
    }

    func saveUsers(_ users: [UserModel]) -> AnyPublisher<Void, CoreDataError> {
        coreDataManager.saveUsers(users).eraseToAnyPublisher()
    }
}
