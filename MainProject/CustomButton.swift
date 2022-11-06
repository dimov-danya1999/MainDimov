//
//  CustomButton.swift
//  MainProject
//
//  Created by Даниил Димов on 06.11.2022.
//

import UIKit

enum CustomButtonState {
    case sumButton 
    case randomButton
    case helloButton

    var title: String {
            switch self {
            case .sumButton :
                return "Посчитать сумму"
            case .randomButton:
                return "Cыграть в игру"
            case .helloButton:
                return "Ввести текст"
            }
        }

    var textColor: UIColor {
        switch self {
        default:
            return .darkGray
        }
    }

    var backgroudColor: UIColor {
        switch self {
        default:
            return .blue
        }
    }

    var borderColor: CGColor {
        switch self {
        default:
            return UIColor.green.cgColor
        }
    }

    var borderWidth: CGFloat {
        switch self {
        default:
            return 1
        }
    }
}

final class CustomButton: UIButton {
    private var type: CustomButtonState = .helloButton
    private var isActive: Bool = false

    init() {
        super.init(frame: .zero)
    }

    required init?(coder: NSCoder) {
        fatalError()
    }

    func configure(type: CustomButtonState) {
        self.type = type
        setTitle(type.title, for: .normal)
        layer.cornerRadius = 25
        backgroundColor = type.backgroudColor
        layer.borderColor = type.borderColor
        layer.borderWidth = type.borderWidth
        titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        updateState(isActive: isActive)
        self.addTarget(self, action: #selector(tap), for: .touchUpInside)
    }

    @objc private func tap() {
        UIView.animate(withDuration: 0.1, delay: 0.1, options: .curveEaseIn) {
            self.alpha = 0.7
        } completion: { _ in
            self.alpha = 1
        }
    }

    func updateState(isActive: Bool) {
        self.isActive = isActive
        isEnabled = isActive
        switch type {
        default:
            backgroundColor = isActive ? .blue : .blue
        }
    }
}

