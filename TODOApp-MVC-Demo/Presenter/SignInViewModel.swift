//
//  SignInVCViewModel.swift
//  TODOApp-MVC-Demo
//
//  Created by Hossam on 11/11/20.
//  Copyright © 2020 IOS. All rights reserved.
//

import Foundation

protocol SignInViewModelProtocol: class{
    func logInUser(email: String, password: String)
}

class SignInViewModel{
    private weak var view: SignInVCProtocol!

    init(view: SignInVCProtocol){
        self.view = view
        }
    
    private func DataValidation(userEmail: String, Password: String)-> Bool{
        if !Validator.shared().isEmptyEmail(email: userEmail){
            self.view.showAlert(alertTitle: "Alert", message: "Please Enter Email" , actionTitle: "Dismiss")
        }
        
        if !Validator.shared().isValidEmail(email: userEmail) {
            self.view.showAlert(alertTitle: "Alert", message: "Please Enter Valid Email", actionTitle: "Dismiss")
        }
        if !Validator.shared().isValidPassword(password: Password) {
            self.view.showAlert(alertTitle: "Alert", message: "Please Enter Valid Password", actionTitle: "Dismiss")
        }
        return true
   }

    private func signInWithEnteredData(email: String, password: String){
        self.view.showLoader()
        APIManager.login(email: email, password: password){ response in
            switch response{
            case .failure(let error):
                if error.localizedDescription == "The data couldn’t be read because it isn’t in the correct format." {
                    self.view.showAlert(alertTitle: "Error",message: "Incorrect Email and Password",actionTitle: "Dismiss")
                }else{
                    self.view.showAlert(alertTitle: "Error",message: "Please try again",actionTitle: "Dismiss")
                    print(error.localizedDescription)
                }
            case .success(let result):
                print(result.token)
                UserDefaultsManager.shared().token = result.token
                UserDefaultsManager.shared().userId = result.user.id
                self.view.goToTodoListVC()
            }
            self.view.hideLoader()
        }
    }
}

extension SignInViewModel: SignInViewModelProtocol{
    func logInUser(email: String, password: String){
        if DataValidation(userEmail: email, Password: password){
                signInWithEnteredData(email: email, password: password)
                
            }
        }
    }





