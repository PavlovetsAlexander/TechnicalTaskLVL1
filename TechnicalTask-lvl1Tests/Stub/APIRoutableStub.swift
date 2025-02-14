//
//  APIRoutableStub.swift
//  TechnicalTask-lvl1Tests
//
//  Created by Alexander Pavlovets on 16.12.24.
//

import Foundation
@testable import TechnicalTask_lvl1

struct APIRouteStub: APIRoutable {
    var url: String
    var path: String
    var method: HttpMethod
    var headers: [String: String]?
    var query: [String: Any]?
    var body: [String: Any]?

    // MARK: - Initialization
    init(
        url: String = "http://127.0.0.1/",
        path: String = "/stubEndpoint",
        method: HttpMethod = .get,
        headers: [String: String]? = nil,
        query: [String: Any]? = nil,
        body: [String: Any]? = nil
    ) {
        self.url = url
        self.path = path
        self.method = method
        self.headers = headers
        self.query = query
        self.body = body
    }
}
