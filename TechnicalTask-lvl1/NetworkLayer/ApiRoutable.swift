//
//  ApiRoutable.swift
//  TechnicalTask-lvl1
//
//  Created by Alexander Pavlovets on 11.12.24.
//

import Foundation

enum HttpMethod: String {
    case post = "POST"
    case get = "GET"
    case delete = "DELETE"
}

protocol APIRoutable {
    var url: URL { get }
    var path: String { get }
    var method: HttpMethod { get }
    var headers: [String: String]? { get }
    var query: [String: Any]? { get }
    var body: [String: Any]? { get }
}
