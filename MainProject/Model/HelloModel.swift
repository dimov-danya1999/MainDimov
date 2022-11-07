//
//  HelloModel.swift
//  MainProject
//
//  Created by Даниил Димов on 04.11.2022.
//

import Foundation

struct HelloModel {
    var text: String?
    
    init(text: String? = nil) {
        self.text = text
    }
    
    // backgroundColor = isActive ? .mustard : .inactiveButtonGray
    func textHello(_ text: String?) -> String {
        text == "leohl" ? "hello" : "leohl"
    }
}
