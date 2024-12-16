//
//  UsersTableViewCell.swift
//  TechnicalTask-lvl1
//
//  Created by Alexander Pavlovets on 16.12.24.
//

import UIKit

final class UserTableViewCell: UITableViewCell, Reusable {
    // MARK: - GUI Properties

    // MARK: - Initialization
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupCell()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Methods
    private func setupCell() {

    }

    func configure(with model: UserModel) {
        print(">>> \(Self.self) \(#function) model: \(model)")
    }
}
