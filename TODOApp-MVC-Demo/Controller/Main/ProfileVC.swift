//
//  ProfileVC.swift
//  TODOApp-MVC-Demo
//
//  Created by Hossam on 10/31/20.
//  Copyright © 2020 IOS. All rights reserved.
//

import UIKit
import SDWebImage


protocol MainNavigationDelegate: class {
    func showAuthState()
}

protocol ProfileVCProtocol: class{
     func setUserData(userData: UserData!)
    func setUserImage(image: UIImage)
    func userNameWithNoImage(nameInitials: String)
    func showLoader()
    func hideLoader()
    func updateUserDataAlert()
    func showAlert(alertTitle: String, message: String, actionTitle: String)
    func goToSignIn()
    
}

class ProfileVC: UITableViewController {

   // MARK:- Outlets
    
    @IBOutlet weak var nameShortcutLabel: UILabel!
    @IBOutlet weak var userProfileImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    
    // MARK:- Properties
    
    var userData: UserData?
    let imagepicker = UIImagePickerController()
    var viewModel: ProfileViewModelProtocol!
    weak var delegate: MainNavigationDelegate?

    // MARK:- Lifecycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagepicker.delegate = self
        self.tableView.reloadData()
        tableView.tableFooterView = UIView(frame: .zero)
        setNavBar()
        viewModel.getUserData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.getUserImage()
        self.tableView.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    class func create() -> ProfileVC {
        let profileVC : ProfileVC = UIViewController.create(storyboardName: Storyboards.main, identifier: ViewControllers.profileVC)
        profileVC.viewModel = profileViewModel(view: profileVC.self)
        return profileVC
    }
    
    // MARK:- Actions
    @IBAction func logOutBtnTapped(_ sender: UIButton) {
     viewModel.logOut()
     UserDefaultsManager.shared().token?.removeAll()
        // self.delegate?.showAuthState()
        //goToSignIn()
        
    }
 
    @IBAction func updateProfileData(_ sender: UIButton) {
        updateUserDataAlert()
        tableView.reloadData()
}
}

// MARK :- Extensions
extension ProfileVC: UIImagePickerControllerDelegate , UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
            viewModel.uploadUserImage(image: pickedImage)
            
        }
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}

extension ProfileVC: ProfileVCProtocol {
   
    func showAlert(alertTitle: String, message: String, actionTitle: String) {
        ShowAlertsManager.showAlertWithCancel(alertTitle: alertTitle, message: message, actionTitle: actionTitle)
    }
   
    func updateUserDataAlert(){
        let alertController = UIAlertController(title: "Update Age", message: "", preferredStyle: UIAlertController.Style.alert)
        alertController.addTextField { (textField : UITextField!) -> Void in
            textField.placeholder = "New Age"
        }
        let saveAction = UIAlertAction(title: "Save", style: UIAlertAction.Style.default, handler: { alert -> Void in
            let taskTextField = alertController.textFields![0] as UITextField
            if let taskTF = Int(taskTextField.text ?? ""){
                self.viewModel.updateUserData(age: taskTF)
            }else{
                self.showAlert(alertTitle: "Error",message: "Please try again",actionTitle: "Dismiss")
            }
        })
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler:nil)
        
        alertController.addAction(saveAction)
        alertController.addAction(cancelAction)
        present(alertController,animated:  true, completion: nil)
    }

   func goToSignIn() {
    self.delegate?.showAuthState()

   }
    
    @objc private func tapRightBtnTapped(){
        imagepicker.allowsEditing = true
        imagepicker.sourceType = .photoLibrary
        present(imagepicker, animated: true, completion: nil)
    }
    private func setNavBar() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Upload Image", style: .plain, target: self, action: #selector(tapRightBtnTapped))
    }
    
    
    
    func setUserData(userData: UserData!){
        nameLabel.text = userData?.name
        emailLabel.text = userData?.email
        ageLabel.text = "\( userData?.age ?? 0)"
    }

    func setUserImage(image: UIImage) {
       userProfileImage.image = image
    }
    
    func userNameWithNoImage(nameInitials: String) {
        nameShortcutLabel.text = nameInitials
    }
    
    func showLoader() {
        self.view.showLoading()
    }
    
    func hideLoader() {
        self.view.hideLoading()
    }
}
