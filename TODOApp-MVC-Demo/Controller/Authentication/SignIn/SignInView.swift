//
//  SignInView.swift
//  TODOApp-MVC-Demo
//
//  Created by Hossam on 11/23/20.
//  Copyright © 2020 IOS. All rights reserved.
//

import UIKit

class SignInView: UIView {

    //MARK:- Public Method
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var createAccountButton: UIButton!
    
    //MARK:- Public Method
    func setup() {
        setupbackGround()
        setupTextField(emailTextField, placeHolder: "Email", isSceure: false)
        setupTextField(passwordTextField, placeHolder: "Password", isSceure: true)
        setupLoginButton()
        setUpCreateAccountButton()
        setupUnderlineButton(loginButton, title: "Sign In")
    }

}

//MARK:- Private Method
extension SignInView {
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
        loginButton.backgroundColor = .darkGray
        loginButton.setTitle("Sign In", for: .normal)
        loginButton.layer.cornerRadius = loginButton.frame.height / 2
    }
    
    private func setUpCreateAccountButton (){
        createAccountButton.backgroundColor = .darkGray
        createAccountButton.setTitle("createAccount", for: .normal)
        createAccountButton.layer.cornerRadius = loginButton.frame.height / 2
        
    }
    
    private func setupUnderlineButton(_ button: UIButton, title: String) {
        button.layer.borderWidth = 0.0
        let attributedString = NSAttributedString(string: title,
        attributes:[NSAttributedString.Key.foregroundColor : UIColor.black,NSAttributedString.Key.underlineStyle:1.0])
        button.setAttributedTitle(attributedString, for: .normal)
    }
}
