//
//  UsersTableViewCell.swift
//  TechnicalTask-lvl1
//
//  Created by Alexander Pavlovets on 16.12.24.
//

import UIKit

final class UserTableViewCell: UITableViewCell, Reusable {
    // MARK: - Constants
    private enum Constants {
        static let cornerRadius = 20.0
        static let borderWidth = 1.0
        static let edgeInsets = UIEdgeInsets(top: 12.0, left: 12.0,
                                             bottom: 12.0, right: 12.0)

    }

    // MARK: - GUI Properties
    private lazy var nameLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 22.0)
        return label
    }()

    private lazy var emailLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 18.0)
        return label
    }()

    private lazy var containerView: UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = Constants.cornerRadius
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.borderWidth = Constants.borderWidth
        return view
    }()

    // MARK: - Initialization
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
    }

    required init?(coder: NSCoder) { nil }

    // MARK: - Methods
    private func setupCell() {
        contentView.addSubview(containerView)
        containerView.addSubviews([
            nameLabel,
            emailLabel
        ])

        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constants.edgeInsets.top),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.edgeInsets.left),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constants.edgeInsets.right),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Constants.edgeInsets.bottom)
        ])

        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: Constants.edgeInsets.top),
            nameLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: Constants.edgeInsets.left),
            emailLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: Constants.edgeInsets.top),
            emailLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: Constants.edgeInsets.left),
            emailLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -Constants.edgeInsets.bottom)
        ])

    }

    func configure(with model: UserModel) {
        nameLabel.text = model.name
        emailLabel.text = model.email
    }
}
