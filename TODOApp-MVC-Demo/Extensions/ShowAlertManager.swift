//
//  ShowAlert.swift
//  TODOApp-MVC-Demo
//
//  Created by Hossam on 11/12/20.
//  Copyright © 2020 IOS. All rights reserved.
//

import UIKit

class ShowAlertsManager{
    
    class func showAlertWithCancel(alertTitle: String,message: String,actionTitle: String){
        let alert = UIAlertController(title: alertTitle, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: actionTitle, style: .cancel, handler: nil))
        UIApplication.shared.keyWindow?.rootViewController?.present(alert, animated: true, completion: nil)
        //present(alert,animated: true)
    }
}
