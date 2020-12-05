//
//  AppStateManager.swift
//  TODOApp-MVC-Demo
//
//  Created by Hossam on 12/2/20.
//  Copyright © 2020 IOS. All rights reserved.
//

import Foundation
import UIKit

protocol AppStateManagerProtocol {
    func start(appDelegate: AppDelegateProtocol)
}

class AppStateManager {

    //MARK:- AppState Enum
    enum AppState {
        case none
        case auth
        case main
        case profile
        
    }
    
    //MARK:- Properties
    var appDelegate: AppDelegateProtocol!
    var mainWindow: UIWindow? {
        return self.appDelegate?.getMainWindow()
    }
    
    var state: AppState = .none {
        willSet(newState) {
            switch newState {
            case .auth:
                goToAuthentication()
            case .main:
                goToMain()
            default:
                return
                
               }
            }
        }

    private static let sharedInstance = AppStateManager()
    
    class func shared() -> AppStateManager {
        return AppStateManager.sharedInstance
    }


    func profileToAuthState() {
        let profileVC = ProfileVC.create()
        profileVC.delegate = self
        let navigationController = UINavigationController(rootViewController: profileVC)
        self.mainWindow?.rootViewController = navigationController
    }


func goToMain() {
    let todoListVC = TodoListVC.create()
    let navigationController = UINavigationController(rootViewController: todoListVC)
    UINavigationBar.appearance().tintColor = .white
    UINavigationBar.appearance().barTintColor = .darkGray
    self.mainWindow?.rootViewController = navigationController
}

func goToAuthentication() {
    let signInVC = SignInVC.create()
    signInVC.delegate = self
    let navigationController = UINavigationController(rootViewController: signInVC)
    UINavigationBar.appearance().tintColor = .white
    UINavigationBar.appearance().barTintColor = .darkGray
    self.mainWindow?.rootViewController = navigationController
}
}

extension AppStateManager : AppStateManagerProtocol {
    func start(appDelegate: AppDelegateProtocol) {
        self.appDelegate = appDelegate
        
        let isLoggedIn = UserDefaultsManager.shared().isLoggedIn
        if isLoggedIn == true{
            if UserDefaultsManager.shared().token != nil{
                self.state = .main
            }
        }else{
            self.state = .auth
        }
    }
}

extension AppStateManager: AuthNavigationDelegate {
    func showMAinState() {
        self.state = .main
    }
}

extension AppStateManager: MainNavigationDelegate{
    func showAuthState() {
        self.state = .auth
    }
    
}
