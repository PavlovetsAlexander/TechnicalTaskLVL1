//
//  UIView+Extension.swift
//  TechnicalTask-lvl1
//
//  Created by Alexander Pavlovets on 16.12.24.
//

import UIKit

extension UIView {
    func addSubviews(_ views: [UIView]) {
        views.forEach { self.addSubview($0) }
    }
}
