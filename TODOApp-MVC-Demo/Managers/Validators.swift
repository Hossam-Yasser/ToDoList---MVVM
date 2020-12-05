//
//  Validators.swift
//  TODOApp-MVC-Demo
//
//  Created by Hossam on 11/22/20.
//  Copyright © 2020 IOS. All rights reserved.
//

import Foundation

class Validator{
    private static let sharedInstance = Validator()
    class func shared() -> Validator {
        return Validator.sharedInstance
}
    
         func isEmptyEmail(email: String?) -> Bool {
        guard let email = email?.trimmed, !email.isEmpty else{
            return false
        }
        return true
      }
        func isValidEmail(email: String?)-> Bool{
          
            guard RegexValidationManager.isValidEmail(email: email) else{
                return false
            }
            return true
        }
         func isValidPassword(password: String?)-> Bool{
            guard let password = password, !password.isEmpty else{
                return false
            }
            guard RegexValidationManager.isValidPassword(password: password) else{
                return false
            }
            return true
        }
         func isValidAge(age: String?)-> Bool{
            guard let age = age, !age.isEmpty else{
                return false
            }
            return true
        }
         func isValidName(name: String?)-> Bool{
            guard let name = name, !name.isEmpty else{
                return false
            }
            return true
        }
    }

