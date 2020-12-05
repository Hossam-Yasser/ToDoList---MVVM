//
//  SignInVC.swift
//  TODOApp-MVC-Demo
//
//  Created by Hossam on 10/28/20.
//  Copyright © 2020 IOS. All rights reserved.
//



import UIKit

//1-
protocol AuthNavigationDelegate: class {
    func showMAinState()
}


protocol SignInVCProtocol: class {
    
    func showAlert(alertTitle: String, message: String, actionTitle: String)
    func hideLoader()
    func showLoader()
    func goToTodoListVC()
}


class SignInVC: UIViewController {
  
    // MARK:- Properties
    @IBOutlet var signInView: SignInView!
    var viewModel: SignInViewModel!
    
    //2-
    weak var delegate: AuthNavigationDelegate?


   
    // MARK:- Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
    signInView.setup()
    UserDefaultsManager.shared().isLoggedIn = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
// MARK:- Public Methods
    class func create() -> SignInVC {
        let signInVC: SignInVC = UIViewController.create(storyboardName: Storyboards.authentication, identifier: ViewControllers.signInVC)
    signInVC.viewModel = SignInViewModel(view: signInVC)
        return signInVC
    }

    @IBAction func loginBtnTapped(_ sender: Any) {
        viewModel.logInUser(email: signInView.emailTextField.text! , password: signInView.passwordTextField.text!)
    }
    
    @IBAction func createAccountBtnTapped(_ sender: Any) {
        let signUpVC = SignUpVC.create()
        navigationController?.pushViewController(signUpVC, animated: true)
         }
    
    
    func showAlert(alertTitle: String, message: String, actionTitle: String) {
        showAlertWithCancel(alertTitle: alertTitle, message: message, actionTitle: actionTitle)
        let alert = UIAlertController(title: alertTitle, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: actionTitle, style: .cancel, handler: nil))
        UIApplication.shared.keyWindow?.rootViewController?.present(alert, animated: true, completion: nil)
    }
    
}

// Mark:- Extension
extension SignInVC : SignInVCProtocol {
    
    func showLoader() {
        self.view.showLoading()
    }
    
    
    func hideLoader() {
        self.view.hideLoading()
    }
    
    func goToTodoListVC(){
        // 3-
        self.delegate?.showMAinState()
        
    }
    
}

