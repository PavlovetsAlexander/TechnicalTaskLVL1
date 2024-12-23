//
//  UserModel.swift
//  TechnicalTask-lvl1
//
//  Created by Alexander Pavlovets on 15.12.24.
//

import Foundation

struct UserModel: Codable {
    let id: Int
    let name: String
    let username: String
    let email: String?

    init(name: String, username: String, email: String?, id: Int) {
        self.name = name
        self.username = username
        self.email = email
        self.id = id
    }

    init(from user: UserEntity) {
         self.name = user.name
         self.username = user.username
         self.email = user.email
         self.id = user.id
     }
}
