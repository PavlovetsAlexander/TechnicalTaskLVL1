//
//  CoreDataUserManager.swift
//  TechnicalTask-lvl1
//
//  Created by Alexander Pavlovets on 23.12.24.
//

import Foundation
import CoreData
import Combine

protocol CoreDataManager {
    func saveUser(_ user: UserModel) -> AnyPublisher<Void, CoreDataError>
    func saveUsers(_ user: [UserModel]) -> AnyPublisher<Void, CoreDataError>
    func loadUsers(predicate: NSPredicate?) -> AnyPublisher<[UserEntity], CoreDataError>
    func delete(user: String) -> AnyPublisher<Void, CoreDataError>
}

final class CoreDataManagerImplementation: CoreDataManager {
    // MARK: - Properties
    private let coreDataConfigurator: CoreDataConfigurator
    private var primaryContext: NSManagedObjectContext { coreDataConfigurator.managedObjectContext }
    private lazy var childContext: NSManagedObjectContext = {
        let context = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        context.parent = primaryContext
        return context
    }()

    // MARK: - Initialization
    init(coreDataConfigurator: CoreDataConfigurator) {
        self.coreDataConfigurator = coreDataConfigurator
    }

    // MARK: - Methods
    func saveUser(_ user: UserModel) -> AnyPublisher<Void, CoreDataError> {
        Future { [weak self] promise in
            guard let self else {
                promise(.failure(CoreDataError.contextFail))
                return
            }

            self.childContext.perform {
                let object = UserEntity(context: self.childContext)
                object.name = user.name
                object.username = user.username
                object.email = user.email ?? ""

                do {
                    try self.childContext.save()
                    try self.primaryContext.save()
                    promise(.success(()))
                } catch {
                    promise(.failure(CoreDataError.saveFail))
                }
            }

        }.eraseToAnyPublisher()
    }

    func saveUsers(_ user: [UserModel]) -> AnyPublisher<Void, CoreDataError> {
        Future { [weak self] promise in
            guard let self else {
                promise(.failure(CoreDataError.contextFail))
                return
            }

            self.childContext.perform {
                do {
                    user.forEach {
                        let object = UserEntity(context: self.childContext)
                        object.name = $0.name
                        object.username = $0.username
                        object.email = $0.email ?? ""
                    }

                    try self.childContext.save()
                    try self.primaryContext.save()
                    promise(.success(()))
                } catch {
                    promise(.failure(CoreDataError.saveFail))
                }
            }

        }.eraseToAnyPublisher()
    }

    func loadUsers(predicate: NSPredicate?) -> AnyPublisher<[UserEntity], CoreDataError>{
        Future { [weak self] promise in
            guard let self else {
                promise(.failure(CoreDataError.contextFail))
                return
            }

            let fetchRequest = NSFetchRequest<UserEntity>(entityName: String(describing: UserEntity.self))
            fetchRequest.predicate = predicate

            do {
                let usersObject = try self.primaryContext.fetch(fetchRequest)
                promise(.success(usersObject))
            } catch {
                promise(.failure(CoreDataError.loadFail))
            }
        }.eraseToAnyPublisher()
    }

    func delete(user: String) -> AnyPublisher<Void, CoreDataError> {
        Future { [weak self] promise in
            guard let self else {
                promise(.failure(CoreDataError.deleteFail))
                return
            }

            self.childContext.perform{
                let predicate = NSPredicate(format: "name == %@", user)
                let fetchRequest = NSFetchRequest<UserEntity>(entityName: String(describing: UserEntity.self))
                fetchRequest.predicate = predicate

                do {
                    guard let userToDelete = try self.childContext.fetch(fetchRequest).first else {
                        promise(.failure(CoreDataError.deleteFail))
                        return
                    }

                    self.childContext.delete(userToDelete)

                    try self.childContext.save()
                    try self.primaryContext.save()
                } catch {
                    promise(.failure(.deleteFail))
                }
            }
        }.eraseToAnyPublisher()
    }
}
