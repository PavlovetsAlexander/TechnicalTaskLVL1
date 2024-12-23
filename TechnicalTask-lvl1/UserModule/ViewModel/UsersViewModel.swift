//
//  UsersViewModel.swift
//  TechnicalTask-lvl1
//
//  Created by Alexander Pavlovets on 15.12.24.
//

import Foundation
import Combine

protocol UsersViewModel {
    var users: CurrentValueSubject<[UserModel], Error>  { get }
    var errorMessage: PassthroughSubject<String?, Never> { get }
    func loadUsers()
    func saveLocalUsers(user: UserModel)
    func numberOfRows() -> Int
    func getUserModels(at index: Int) -> UserModel
}

final class UsersViewModelImpl: UsersViewModel {
    // MARK: - Properties
    private let userRepositoryManager: UserRepositoryManager
    private var store: Set<AnyCancellable> = []

    var users: CurrentValueSubject<[UserModel], Error> = .init([])
    var errorMessage: PassthroughSubject<String?, Never> = .init()

    // MARK: - Initialization
    init(userRepositoryManager: UserRepositoryManager) {
        self.userRepositoryManager = userRepositoryManager
    }

    // MARK: - Methods
    func loadRemoteUsers() {
        userRepositoryManager.loadRemoteUsers()
            .sink {[weak errorMessage] completed in
                guard let errorMessage else { return }
                switch completed {
                case .failure(let error):
                    errorMessage.send(error.errorDescription)
                case .finished: break
                }
            } receiveValue: { users in
                self.users.send(users)
            }.store(in: &store)
    }

    func loadUsers() {
        let localUsersPublisher = userRepositoryManager.loadLocalUsers(predicate: nil)
            .catch { [weak self] error -> Empty<[UserModel], Never> in
                self?.errorMessage.send(error.errorDescription)
                return .init()
            }

        let remoteUsersPublisher = userRepositoryManager.loadRemoteUsers()
            .catch { [weak self] error -> Empty<[UserModel], Never> in
                self?.errorMessage.send(error.errorDescription)
                return .init()
            }

        Publishers.Merge(localUsersPublisher, remoteUsersPublisher)
            .collect()
            .map { loadedUsers in
                loadedUsers.flatMap { $0 }
            }
            .sink { [weak self] users in
                self?.users.send(users)
            }.store(in: &store)
    }

    func saveLocalUsers(user: UserModel) {
        userRepositoryManager.saveUser(user).sink { [weak errorMessage] completion in
            guard let errorMessage else { return }
            switch completion {
            case .failure(let error):
                errorMessage.send(error.errorDescription)
            case .finished: break
            }
        } receiveValue: { }.store(in: &store)
    }

    func numberOfRows() -> Int {
        users.value.count
    }

    func getUserModels(at index: Int) -> UserModel {
        users.value[index]
    }
}
