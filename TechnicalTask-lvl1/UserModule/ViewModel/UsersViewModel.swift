//
//  UsersViewModel.swift
//  TechnicalTask-lvl1
//
//  Created by Alexander Pavlovets on 15.12.24.
//

import Foundation
import Combine

protocol UsersViewModel {
    var users: AnyPublisher<[UserModel], Error>  { get }
    var errorMessage: AnyPublisher<String?, Never> { get }
    func getUsers()
    func numberOfRows() -> Int
    func getUserModels(at indexPath: IndexPath) -> UserModel?
}

final class UsersViewModelImplementation: UsersViewModel {
    // MARK: - Properties
    private let userRepository: UserLocalRepository
    private var store: Set<AnyCancellable> = []

    private var usersSubject: CurrentValueSubject<[UserModel], Error> = .init([])
    private var errorMessageSubject: PassthroughSubject<String?, Never> = .init()

    var users: AnyPublisher<[UserModel], Error> {
        usersSubject.eraseToAnyPublisher()
    }

    var errorMessage: AnyPublisher<String?, Never> {
        errorMessageSubject.eraseToAnyPublisher()
    }

    // MARK: - Initialization
    init(userRepository: UserLocalRepository) {
        self.userRepository = userRepository
    }

    // MARK: - Methods
    func getUsers() {
        userRepository.fetchUsers()
            .sink { [weak self] completed in
                switch completed {
                case .failure(let error):
                    self?.errorMessageSubject.send(error.localizedDescription)
                case .finished:
                    break
                }
            } receiveValue: { [weak self] users in
                self?.usersSubject.send(users)
            }
            .store(in: &store)
    }

    func numberOfRows() -> Int {
        usersSubject.value.count
    }

    func getUserModels(at indexPath: IndexPath) -> UserModel? {
        usersSubject.value[indexPath.row]
    }
}
