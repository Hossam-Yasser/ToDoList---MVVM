//
//  LoginResponse.swift
//  TODOApp-MVC-Demo
//
//  Created by Hossam on 10/28/20.
//  Copyright © 2020 IOS. All rights reserved.
//


import Foundation

struct LoginResponse: Codable {
    let token: String
    let user: UserData
    enum CodingKeys: String, CodingKey {
        case token, user
    }
}
