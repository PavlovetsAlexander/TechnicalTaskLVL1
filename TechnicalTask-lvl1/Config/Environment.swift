//
//  Environment.swift
//  TechnicalTask-lvl1
//
//  Created by Alexander Pavlovets on 11.12.24.
//

import Foundation

struct Environment {
    // MARK: - Constants
    private enum EnvironmentVariable: String {
        case baseURL = "BASE_URL"
    }

    // MARK: - Properties
    static let baseURL = stringKey(for: .baseURL)

    // MARK: - Methods
    private static let infoDictionary: [String: Any] = Bundle.main.infoDictionary ?? [:]

    private static func stringKey(for key: EnvironmentVariable) -> String {
        guard let value = infoDictionary[key.rawValue] as? String else { return "" }
        return value
    }
}
