//
//  UserRoute.swift
//  TechnicalTask-lvl1
//
//  Created by Alexander Pavlovets on 15.12.24.
//

import Foundation
import Combine

struct UserRoute: APIRoutable {
    var url: String {
        Environment.baseURL
    }

    var path: String

    var method: HttpMethod

    var headers: [String : String]?

    var query: [String : Any]?

    var body: [String : Any]?

    static func getUsers() throws -> URLRequest {
        let userRoute = UserRoute(path: "/users", method: .get,
                                  headers: ["Content-Type": "application/json"],
                                  query: nil, body: nil)
        guard let request = try? URLRequest.build(with: userRoute) else { throw RequestError.invalidRequest }
        return request
    }
}
