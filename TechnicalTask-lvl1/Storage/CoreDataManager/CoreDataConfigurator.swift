//
//  CoreDataConfigurator.swift
//  TechnicalTask-lvl1
//
//  Created by Alexander Pavlovets on 23.12.24.
//

import CoreData

protocol CoreDataConfigurator: AnyObject {
    var persistentContainer: NSPersistentContainer { get }
    var managedObjectContext: NSManagedObjectContext { get }
}

final class CoreDataConfiguratorImplementation: CoreDataConfigurator {
    // MARK: - Properties
    private let dataModelName: String

    private(set) lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: dataModelName)
        container.loadPersistentStores { _, error in
            guard let error else { return }
            fatalError("Can not load persistent stores")
        }
        return container
    }()

    private(set) lazy var managedObjectContext: NSManagedObjectContext = {
        return persistentContainer.viewContext
    }()

    // MARK: - Initialization
    init(with dataModelName: String) {
        self.dataModelName = dataModelName
    }
}
