//
//  UserDefaultsManager.swift
//  TODOApp-MVC-Demo
//
//  Created by Hossam on 10/28/20.
//  Copyright © 2020 IOS. All rights reserved.
//

import Foundation


class UserDefaultsManager {
    
    // MARK:- Singleton
    private static let sharedInstance = UserDefaultsManager()
    
    class func shared() -> UserDefaultsManager {
        return UserDefaultsManager.sharedInstance
    }
    
    // MARK:- Properties
    var token: String? {
        set {
            UserDefaults.standard.set(newValue, forKey: UserDefaultsKeys.token)
        }
        get {
            guard UserDefaults.standard.object(forKey: UserDefaultsKeys.token) != nil else {
                return nil
            }
            return UserDefaults.standard.string(forKey: UserDefaultsKeys.token)!
        }
    }
    
    var isLoggedIn: Bool {
        set{
            UserDefaults.standard.set(newValue, forKey: UserDefaultsKeys.isLoggedIn)
        }
        get{
            return UserDefaults.standard.bool(forKey: UserDefaultsKeys.isLoggedIn)
        }
    }
    
    var userId: String? {
        set {
            UserDefaults.standard.set(newValue, forKey: UserDefaultsKeys.userId)
        }
        get {
            guard UserDefaults.standard.object(forKey: UserDefaultsKeys.userId) != nil else {
                return nil
            }
            return UserDefaults.standard.string(forKey: UserDefaultsKeys.userId)!
        }
    }
    
    var taskId: String? {
        set {
            UserDefaults.standard.set(newValue, forKey: UserDefaultsKeys.taskId)
        }
        get {
            guard UserDefaults.standard.object(forKey: UserDefaultsKeys.taskId) != nil else {
                return nil
            }
            return UserDefaults.standard.string(forKey: UserDefaultsKeys.taskId)!
        }
    }
}

    

