//
//  TaskData.swift
//  TODOApp-MVC-Demo
//
//  Created by Hossam on 10/31/20.
//  Copyright © 2020 IOS. All rights reserved.
//

import Foundation

struct TaskData: Decodable{
    var id: String!
    var description: String!

enum CodingKeys: String, CodingKey {
    case description
    case id = "_id"
}
}
