//
//  UserRoute.swift
//  TechnicalTask-lvl1
//
//  Created by Alexander Pavlovets on 15.12.24.
//

import Foundation

struct UserRoute: APIRoutable {
    var url: URL {
        URL(string: Environment.baseURL)!
    }

    var path: String

    var method: HttpMethod

    var headers: [String : String]?

    var query: [String : Any]?

    var body: [String : Any]?

    static func getUsers() -> UserRoute{
        UserRoute(path: "/users",
                  method: .get,
                  headers: ["Content-Type": "application/json"],
                  query: nil,
                  body: nil)
    }
}
