//
//  UserModel.swift
//  TechnicalTask-lvl1
//
//  Created by Alexander Pavlovets on 23.12.24.
//

import Foundation
import CoreData

@objc(UserEntity)
public class UserEntity: NSManagedObject {
    @NSManaged public var name: String
    @NSManaged public var id: Int
    @NSManaged public var email: String
    @NSManaged public var username: String
}
