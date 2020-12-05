//
//  SignUpView.swift
//  TODOApp-MVC-Demo
//
//  Created by Hossam on 11/23/20.
//  Copyright © 2020 IOS. All rights reserved.
//

import UIKit

class SignUpView: UIView {

    //MARK:- Outlets
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    
    
    //MARK:- Public Method
    func setup() {
        setupbackGround()
        setupTextField(nameTextField, placeHolder: "Name", isSceure: false)
        setupTextField(emailTextField, placeHolder: "Email", isSceure: false)
        setupTextField(passwordTextField, placeHolder: "Password", isSceure: true)
        setupTextField(ageTextField, placeHolder: "Age", isSceure: false)
        setupLoginButton()
        setupUnderlineButton(signUpButton, title: "Sign Up")
    }
}

   //MARK:- Private Method
extension SignUpView {
    private func setupbackGround() {
        backgroundColor = .black
    }
    
    private func setupTextField(_ textField: UITextField, placeHolder: String,
                        isSceure: Bool) {
        textField.backgroundColor = .white
        textField.placeholder = placeHolder
        textField.font = UIFont(name: emailTextField.font!.fontName,
                                size: 20)
        textField.isSecureTextEntry = isSceure
    }
    
    private func setupLoginButton() {
        signUpButton.backgroundColor = .darkGray
        signUpButton.setTitle("Sign Up", for: .normal)
        signUpButton.layer.cornerRadius = signUpButton.frame.height / 2
    }
    
    private func setupUnderlineButton(_ button: UIButton, title: String) {
        button.layer.borderWidth = 0.0
        let attributedString = NSAttributedString(string: title,
                                                  attributes:[NSAttributedString.Key.foregroundColor : UIColor.black,NSAttributedString.Key.underlineStyle:1.0])
        button.setAttributedTitle(attributedString, for: .normal)
    }
}
    
