//
//  URLRequest+Extension.swift
//  TechnicalTask-lvl1
//
//  Created by Alexander Pavlovets on 30.12.24.
//

import Foundation
extension URLRequest {
    static func build(with route: APIRoutable) throws -> URLRequest {
        guard let url = URL(string: route.url + route.path) else {
            throw RequestError.invalidURL
        }

        var request = URLRequest(url: url)
        request.httpMethod = route.method.rawValue

        if let headers = route.headers {
            headers.forEach { request.setValue($0.value, forHTTPHeaderField: $0.key) }
        }

        if let queryParams = route.query {
            var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false)
            urlComponents?.queryItems = queryParams.map { URLQueryItem(name: $0.key, value: "\($0.value)") }
            request.url = urlComponents?.url
        }

        if let body = route.body {
            request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: [])
        }

        return request
    }
}
