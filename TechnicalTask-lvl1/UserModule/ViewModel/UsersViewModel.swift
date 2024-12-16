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
    func getUsers()
    func numberOfRows() -> Int
    func getUserModels(at index: Int) -> UserModel
}

final class UsersViewModelImpl: UsersViewModel {
    // MARK: - Properties
    private let userRepository: UserRepository
    private var store: Set<AnyCancellable> = []

    var users: CurrentValueSubject<[UserModel], Error> = .init([])
    var errorMessage: PassthroughSubject<String?, Never> = .init()

    // MARK: - Initialization
    init(userRepository: UserRepository) {
        self.userRepository = userRepository
    }

    // MARK: - Methods
    func getUsers() {
       userRepository.fetchUsers()
            .sink { completed in
                switch completed {
                case .failure(let error):
                    self.errorMessage.send(error.errorDescription)
                case .finished: break
                }
            } receiveValue: { users in
                self.users.send(users)
            }.store(in: &store)
    }

    func numberOfRows() -> Int {
        users.value.count
    }

    func getUserModels(at index: Int) -> UserModel {
        users.value[index]
    }
}
