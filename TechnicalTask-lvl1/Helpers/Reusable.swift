//
//  Reusable.swift
//  TechnicalTask-lvl1
//
//  Created by Alexander Pavlovets on 16.12.24.
//

public protocol Reusable {
    static var reuseIdentifier: String { get }
}

public extension Reusable {
    static var reuseIdentifier: String { String(describing: self.self) }
}
