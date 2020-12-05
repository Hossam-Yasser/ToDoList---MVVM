//
//  SignUpVC.swift
//  TODOApp-MVC-Demo
//
//  Created by Hossam on 10/28/20.
//  Copyright © 2020 IOS. All rights reserved.
//

import UIKit

protocol signUpVCProtocol: class {
     func goToSignIn()
     func showLoader()
     func hideLoader()
     func showAlert(alertTitle: String, message: String, actionTitle: String)
    
}

class SignUpVC: UIViewController {
  
    @IBOutlet var signUpView: SignUpView!
    var viewModel: SignUpViewModel!
    
    
    // MARK:- Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        signUpView.setup()
    self.hideKeyboardWhenTappedAround()
    }

    // MARK:- Public Methods
    class func create() -> SignUpVC {
        let signUpVC: SignUpVC = UIViewController.create(storyboardName: Storyboards.authentication, identifier: ViewControllers.signUpVC)
        signUpVC.viewModel = SignUpViewModel(view: signUpVC)
        return signUpVC
    }

    // MARK:- Actions
    @IBAction func signUpBtnTapped(_ sender: UIButton) {
        viewModel.signUpUser(name: signUpView.nameTextField.text! , email: signUpView.emailTextField.text!, password: signUpView.passwordTextField.text!, age: signUpView.ageTextField.text!)
        
    }
}
    
    // Mark:- Extension
extension SignUpVC: signUpVCProtocol {
    
    func goToSignIn(){
        let signInVC = SignInVC.create()
        navigationController?.pushViewController(signInVC, animated: true)
        
    }
    
    func showLoader() {
        self.view.showLoading()
    }
    
    func hideLoader() {
        self.view.hideLoading()
    }
    
    func showAlert(alertTitle: String, message: String, actionTitle: String) {
        showAlertWithCancel(alertTitle: alertTitle, message: message, actionTitle: actionTitle)
        let alert = UIAlertController(title: alertTitle, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: actionTitle, style: .cancel, handler: nil))
        UIApplication.shared.keyWindow?.rootViewController?.present(alert, animated: true, completion: nil)
    }
    
    
    
    }







