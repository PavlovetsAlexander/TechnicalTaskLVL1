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
    case invalidRequest(message: String)
    case decodedError(message: String)
    case serverError(message: String)
    case connectionError(message: String)

    var errorDescription: String? {
        switch self {
        case .invalidResponse:
            return "Invalid response"
        case .invalidData:
            return "Invalid data"
        case .invalidURL:
            return "Invalid URL"
        case .decodedError(message: let message):
            return message
        case .serverError(message: let message):
            return message
        case .connectionError(message: let message):
            return message
        case .invalidRequest(message: let message):
            return message
        }
    }
}
