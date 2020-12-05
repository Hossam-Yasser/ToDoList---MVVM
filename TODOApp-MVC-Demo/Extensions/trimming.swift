//
//  trimming.swift
//  TODOApp-MVC-Demo
//
//  Created by Hossam on 11/20/20.
//  Copyright © 2020 IOS. All rights reserved.
//

import Foundation

extension String {
    var trimmed: String{
        return self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
}
