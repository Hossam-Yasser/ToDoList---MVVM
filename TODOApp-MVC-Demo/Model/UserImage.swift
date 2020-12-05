//
//  UserImage.swift
//  TODOApp-MVC-Demo
//
//  Created by Hossam on 11/6/20.
//  Copyright © 2020 IOS. All rights reserved.
//

import Foundation
import UIKit

struct UserImage: Codable{
    var avatar: Data!
}

struct CodableImage: Codable{
    var imageData: Data?
    
    static func setImage(image: UIImage) -> Data? {
        let data = image.jpegData(compressionQuality: 0.2)
        return data
    }
    
    static func getImage(imageData: Data?)-> UIImage?{
        guard let Data = imageData else {
            return nil
        }
        let image = UIImage(data: Data)
        return image
    }
}
