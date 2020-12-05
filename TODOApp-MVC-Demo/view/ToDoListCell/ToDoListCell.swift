//
//  ToDoListCell.swift
//  TODOApp-MVC-Demo
//
//  Created by Hossam on 11/5/20.
//  Copyright © 2020 IOS. All rights reserved.
//

import UIKit

class ToDoListCell: UITableViewCell , todoCelldelegate {
    func displayTaskDescription(description: String) {
            taskLabel.text = description
    }
    
    
    // MARK:- Outlets
    @IBOutlet weak var taskLabel: UILabel!
    @IBOutlet weak var deleteButtonTapped: UIButton!
    
    // MARK:- Properties
    var taskData: TaskData?
    var userData: UserData?
    
    // MARK:- Lifecycle methods
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

    // MARK:- Public Methods
    func configure(task: TaskData){
        taskLabel.text = task.description
        self.taskData = task
    }
}
