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
    let phone: String?
    let website: String?
    let address: Address?
}

struct Address: Codable {
    let street: String?
    let suite: String?
    let city: String
    let zipcode: String?
}
