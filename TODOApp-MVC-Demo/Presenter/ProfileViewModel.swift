//
//  ProfileViewModel.swift
//  TODOApp-MVC-Demo
//
//  Created by Hossam on 12/3/20.
//  Copyright © 2020 IOS. All rights reserved.
//

import Foundation
import  UIKit


protocol ProfileViewModelProtocol: class{
    func getUserData()
    func getUserImage()
    func logOut()
    func uploadUserImage(image: UIImage)
    func updateUserData(age: Int)
}

class profileViewModel{
    
    private var userData: UserData?
    private weak var view: ProfileVCProtocol!
    init(view: ProfileVCProtocol){
        self.view = view
    }
    
    
    private func setUserData(){
        view.setUserData(userData: userData!)
        // userNameInitials()
    }
    
    private func userNameInitials(){
        if let stringInput = userData?.name {
            let initials = stringInput.components(separatedBy: " ").reduce("") { ($0 == "" ? "" : "\($0.first!)") + "\($1.first!)" }
            view.userNameWithNoImage(nameInitials: initials)
        }else{
            view.userNameWithNoImage(nameInitials: "")
        }
    }
}


extension profileViewModel: ProfileViewModelProtocol{
    func getUserData(){
        self.view.showLoader()
        APIManager.getUserData{ (response) in
            switch response{
            case .failure(let error):
                print(error.localizedDescription)
            case .success(let result):
                self.userData = result
                
                print(result)
                self.setUserData()
            }
            DispatchQueue.main.async {
                self.getUserImage()
                self.userNameInitials()
                self.view.hideLoader()
            }
            
        }
    }
    
    func getUserImage(){
        view.showLoader()
        APIManager.getUserImageAPIRouter{ (image, error) in
            guard  error == nil else{
                print(error!.localizedDescription)
                return
            }
            guard  image != nil else{
                print("No Image")
                self.view.hideLoader()
                return
            }
            DispatchQueue.main.async {
                self.view.setUserImage(image: image!)
                self.view.hideLoader()
            }
        }
    }
    
    func logOut(){
        view.showLoader()
        APIManager.LogOut{ (response) in
            switch response{
            case .failure(let error):
                print(error.localizedDescription)
            case .success(let result):
                print(result)
                print("Log Out Completed")
            }
            DispatchQueue.main.async {
                self.view.hideLoader()
                UserDefaultsManager.shared().token?.removeAll()
                UserDefaultsManager.shared().isLoggedIn = false
                self.view.goToSignIn()
            }
        }
    }
    
    func uploadUserImage(image: UIImage){
        view.showLoader()
        APIManager.uploadUserImage(userImage: image){ error in
            if error != nil {
                self.view.showAlert(alertTitle: "Error",message: "Please try again",actionTitle: "Dismiss")
            } else {
                print("Uploading photo is Completed")
            }
            DispatchQueue.main.async {
                self.getUserImage()
                self.view.hideLoader()
            }
            
        }
    }
    func updateUserData(age: Int){
        view.showLoader()
        APIManager.updateData(age: age){ response in
            switch response{
            case .failure(let error):
                print(error.localizedDescription)
            case .success(let result):
                print(result)
                
            }
            DispatchQueue.main.async {
                self.getUserData()
                self.view.hideLoader()
            }
        }
    }
}
