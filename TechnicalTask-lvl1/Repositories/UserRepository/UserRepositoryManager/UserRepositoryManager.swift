//
//  UserRepositoryManager.swift
//  TechnicalTask-lvl1
//
//  Created by Alexander Pavlovets on 23.12.24.
//

import Foundation
import Combine

protocol UserRepositoryManager {
    func loadRemoteUsers() -> AnyPublisher<[UserModel], APIError>
    func loadLocalUsers(predicate: NSPredicate?) -> AnyPublisher<[UserModel], CoreDataError>
    func saveUser(_ user: UserModel) -> AnyPublisher<Void, CoreDataError>
    func saveUsers(_ users: [UserModel]) -> AnyPublisher<Void, CoreDataError>
    func delete(for user: UserModel) -> AnyPublisher<Void, CoreDataError>
}

final class UserRepositoryManagerImplementation: UserRepositoryManager {
    // MARK: - Properties
    private var localUserRepository: UserLocalRepository
    private var remoteUserRepository: UserRepository

    // MARK: - Initialization
    init(localUserRepository: UserLocalRepository, remoteUserRepository: UserRepository) {
        self.localUserRepository = localUserRepository
        self.remoteUserRepository = remoteUserRepository
    }

    // MARK: - Methods
    func delete(for userModel: UserModel) -> AnyPublisher<Void, CoreDataError> {
        localUserRepository.deleteUser(user: userModel).eraseToAnyPublisher()
    }

    func saveUser(_ user: UserModel) -> AnyPublisher<Void, CoreDataError> {
        localUserRepository.save(user).eraseToAnyPublisher()
    }

    func loadRemoteUsers() -> AnyPublisher<[UserModel], APIError> {
        remoteUserRepository.fetchUsers().eraseToAnyPublisher()
    }

    func loadLocalUsers(predicate: NSPredicate?) -> AnyPublisher<[UserModel], CoreDataError> {
        localUserRepository.loadUsers().eraseToAnyPublisher()
    }

    func saveUsers(_ users: [UserModel]) -> AnyPublisher<Void, CoreDataError> {
        localUserRepository.saveUsers(users).eraseToAnyPublisher()
    }
}
