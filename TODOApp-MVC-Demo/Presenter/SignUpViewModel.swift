//
//  SignUpVCViewModel.swift
//  TODOApp-MVC-Demo
//
//  Created by Hossam on 11/13/20.
//  Copyright © 2020 IOS. All rights reserved.
//

import Foundation

protocol SignUpViewModelProtocol: class {
    
}

class SignUpViewModel{
    private weak var view: SignUpVC!
    
    init(view: SignUpVC){
        self.view = view
    }
    
    private func DataValidation( name: String, userEmail: String, Password: String, age: String)-> Bool{
        
        guard Validator.shared().isEmptyEmail(email: userEmail) else {
            self.view.showAlert(alertTitle: "Alert", message: "Please Enter Email", actionTitle: "Dismiss")
            return false
        }
        
        guard Validator.shared().isValidEmail(email: userEmail) else {
            self.view.showAlert(alertTitle: "Alert", message: "Please Enter Valid Email", actionTitle: "Dismiss")
            return false
        }
        guard Validator.shared().isValidPassword(password: Password) else {
            self.view.showAlert(alertTitle: "Alert", message: "Please Enter Password", actionTitle: "Dismiss")
            return false
        }
        guard Validator.shared().isValidName(name: name) else {
            self.view.showAlert(alertTitle: "Alert", message: "Please Enter Name", actionTitle: "Dismiss")
            return false
        }
        guard Validator.shared().isValidAge(age: age) else {
            self.view.showAlert(alertTitle: "Alert", message: "Please Enter Age", actionTitle: "Dismiss")
            return false
        }
        return true
    }

    private func signUpWithEnteredData(name: String, email: String, password: String, age: Int) {
         view.showLoader()
      let body = userRegister(name: name, email: email, password: password, age: Int(age))
        APIManager.register(body: body){ (response) in
            switch response {
            case .failure (let error):
                print(error.localizedDescription)
            case .success(let result):
                print(result)
            }
           // self.delegate.successfullySignedUp()
            self.view.goToSignIn()
            self.view.hideLoader()
        }
    }
}
    
    extension SignUpViewModel: SignUpViewModelProtocol{    func signUpUser(name: String , email: String, password: String , age: String){
        if DataValidation(name: name, userEmail: email, Password: password, age: age ){
                signUpWithEnteredData(name: name, email: email, password: password, age: Int(age)!)
            
          }
       }
    }



