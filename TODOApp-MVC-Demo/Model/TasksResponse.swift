//
//  TasksResponse.swift
//  TODOApp-MVC-Demo
//
//  Created by Hossam on 10/31/20.
//  Copyright © 2020 IOS. All rights reserved.
//

import Foundation

struct TasksResponse: Decodable {
    var count: Int
    var data: [TaskData]
}
