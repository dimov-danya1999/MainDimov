//
//  FIOModel.swift
//  MainProject
//
//  Created by Даниил Димов on 04.11.2022.
//

import Foundation

struct UserModel {
    var family: String?
    var name: String?
    var father: String?
    
    init(family: String? = nil, name: String? = nil, father: String? = nil) {
        self.family = family
        self.name = name
        self.father = father
    }
}
