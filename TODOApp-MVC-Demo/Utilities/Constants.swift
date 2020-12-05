//
//  Constant.swift
//  TODOApp-MVC-Demo
//
//  Created by Hossam on 10/28/20.
//  Copyright © 2020 IOS. All rights reserved.
//

import Foundation

// Storyboards
struct Storyboards {
    static let authentication = "Authentication"
    static let main = "Main"
}

// View Controllers
struct ViewControllers {
    static let signUpVC = "SignUpVC"
    static let signInVC = "SignInVC"
    static let todoListVC = "TodoListVC"
    static let profileVC = "ProfileVC"
}

// Urls
struct URLs {
    static let base = "https://api-nodejs-todolist.herokuapp.com"
    static let register =  "/user/register"
    static let login = "/user/login"
    static let todos = "/task"
    static let userData = "/user/me"
    static let logout = base + "/user/logout"
   // static let update = "/user/me"
    static let uploadUserImage = "/user/me/avatar"
    static let getImage = "/user/5ddccbec6b55da001759722c/avatar"
    static let uploadImage = base + "/user/me/avatar"
}

// Header Keys
struct HeaderKeys {
    static let contentType = "Content-Type"
    static let Authorization = "Authorization"
}

// Parameters Keys
struct ParameterKeys {
    static let name = "name"
    static let email = "email"
    static let password = "password"
    static let age = "age"
    static let task = "task"
    static let description = "description"
    static let avatar = "avatar"
}

// UserDefaultsKeys
struct UserDefaultsKeys {
    static let token = "UDKToken"
    static let isLoggedIn = "IsLoggedIn"
    static let userId = "userId"
     static let taskId = "taskId"
}

// Cells
struct Cells {
    static let toDoListCell = "ToDoListCell"
}
