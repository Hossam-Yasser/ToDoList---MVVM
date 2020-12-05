//
//  UIView+Loading.swift
//  TODOApp-MVC-Demo
//
//  Created by Hossam on 11/7/20.
//  Copyright © 2020 IOS. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    private func setupActivityIndicator() -> UIActivityIndicatorView {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.frame = self.bounds
        activityIndicator.center = self.center
        activityIndicator.style = .gray
        activityIndicator.tag = 333
        return activityIndicator
    }
    
    func showLoading() {
        let activityIndicator = setupActivityIndicator()
        activityIndicator.startAnimating()
        self.addSubview(activityIndicator)
    }
    
    func hideLoading() {
        if let activityIndicator = viewWithTag(333){
            activityIndicator.removeFromSuperview()
        }
    }
    
}
