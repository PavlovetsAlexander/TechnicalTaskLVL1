//
//  APIError.swift
//  TechnicalTask-lvl1
//
//  Created by Alexander Pavlovets on 11.12.24.
//

import Foundation

enum APIError: Error {
    case invalidURL
    case invalidResponse
    case invalidData
    case decodedError
    case serverError(message: String)

    var errorDescription: String? {
        switch self {
        case .invalidResponse:
            return "Invalid response"
        case .invalidData:
            return "Invalid data"
        case .invalidURL:
            return "Invalid URL"
        case .decodedError:
            return "Decoding error"
        case .serverError(message: let message):
            return message
        }
    }
}
