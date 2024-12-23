//
//  CoreDataError.swift
//  TechnicalTask-lvl1
//
//  Created by Alexander Pavlovets on 23.12.24.
//

import Foundation

enum CoreDataError: Error {
    case saveFail
    case loadFail
    case contextFail
    case deleteFail

    var errorDescription: String? {
        switch self {
        case .saveFail:
            return "Cannot save data"
        case .loadFail:
            return "Cannot load data"
        case .contextFail:
            return "Cannot create context"
        case .deleteFail:
            return "Cannot delete object"
        }
    }
}
