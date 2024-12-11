//
//  URLBuilder.swift
//  TechnicalTask-lvl1
//
//  Created by Alexander Pavlovets on 11.12.24.
//

import Foundation

protocol URLBuilder {
    func build(with route: APIRoutable) throws -> URLRequest
}

struct URLBuilderImp: URLBuilder {
    func build(with route: APIRoutable) throws -> URLRequest {
        let baseUrl = route.url.absoluteString

        guard var urlComponents = URLComponents(string: baseUrl) else { throw APIError.invalidURL}
        urlComponents.path = route.path

        if let queryParams = route.query {
            urlComponents.queryItems = queryParams.map { key, value in
                URLQueryItem(name: key, value: "\(value)")
            }
        }

        guard let url = urlComponents.url else {
            throw APIError.invalidURL
        }

        var request = URLRequest(url: url)
        request.httpMethod = route.method.rawValue

        if let headers = route.headers {
            headers.forEach {
                request.setValue($0.key, forHTTPHeaderField: $0.value)
            }
        }

        return request
    }
}
