//
//  StackView.swift
//  MainProject
//
//  Created by Даниил Димов on 06.11.2022.
//

import UIKit

extension UIStackView {
    convenience init(view: [UIView], axis: NSLayoutConstraint.Axis, spacing: Int) {
        self.init(arrangedSubviews: view)
        self.axis = axis
        self.spacing = CGFloat(spacing)
    }
}

