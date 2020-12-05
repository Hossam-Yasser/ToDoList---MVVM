//
//  TodoListVC.swift
//  TODOApp-MVC-Demo
//
//  Created by Hossam on 10/28/20.
//  Copyright © 2020 IOS. All rights reserved.
//

import UIKit

protocol todoCelldelegate{
    func displayTaskDescription(description: String)
}

protocol  TodoListVCProtocol: class {
     func reloadDataWithoutScroll()
     func deleteTaskAlert(index: Int)
     func addTaskAlert()
     func showAlert(alertTitle: String, message: String, actionTitle: String)
     func showLoader()
     func hideLoader()
}




class TodoListVC: UIViewController {

// MARK:- Outlets
    @IBOutlet weak var tasksTableView: UITableView!
    
// MARK:- Properties
    var arr = [TaskData]()
    var viewModel: TodoListViewModelProtocol!

// MARK:- Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
       UserDefaultsManager.shared().isLoggedIn = true
       setNavbar()
        setableView()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.getUserTasks()
        self.tasksTableView.reloadDataWithoutScroll()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.getUserTasks()
        self.tasksTableView.reloadDataWithoutScroll()
    }

// MARK:- Public Methods
    class func create() -> TodoListVC {
        let todoListVC: TodoListVC = UIViewController.create(storyboardName: Storyboards.main, identifier: ViewControllers.todoListVC)
        todoListVC.viewModel = TodoListViewModel(view: todoListVC)
        return todoListVC
    }
    
    
    @objc private func tapLeftBtnTapped(){
        self.addTaskAlert()
        
    }
    
    @objc private func tapRightBtnTapped(){
        let profileVC = ProfileVC.create()
        navigationController?.pushViewController(profileVC, animated: true)
    }
}

// Mark:- Extension

extension TodoListVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.userTasksArrCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Cells.toDoListCell, for: indexPath) as? ToDoListCell else{
            return UITableViewCell()
        }
        viewModel.configure(cell: cell, for: indexPath.row)
        cell.deleteButtonTapped.tag = indexPath.row
        cell.deleteButtonTapped.addTarget(self, action: #selector(deleteTaskBtnTapped(_:)), for: .touchUpInside)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    @objc func deleteTaskBtnTapped(_ sender: UIButton){
        // use the tag of button as index
        deleteTaskAlert(index: sender.tag)
    }
}

// MARK:- Extension reload Tableview Without Scroll
extension UITableView {
    
    func reloadDataWithoutScroll() {
        let offset = contentOffset
        reloadData()
        layoutIfNeeded()
        setContentOffset(offset, animated: false)
    }
}

// MARK:- Extension Private Methods
extension TodoListVC{
    private func setableView(){
        tasksTableView.register(UINib(nibName: Cells.toDoListCell, bundle: nil), forCellReuseIdentifier: Cells.toDoListCell)
        tasksTableView.dataSource = self
        tasksTableView.delegate = self
        tasksTableView.tableFooterView = UIView(frame: .zero)
    }
    
    private func setNavbar(){
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Profile" , style: .plain, target: self, action:  #selector(tapRightBtn))
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "+", style: .plain, target: self, action: #selector(tapLeftBtn))
        self.navigationItem.rightBarButtonItem!.setTitleTextAttributes([
            NSAttributedString.Key.font: UIFont(name: "Georgia-Bold", size: 25.0)!,
            NSAttributedString.Key.foregroundColor: UIColor.white],for: .normal)
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white,
                              NSAttributedString.Key.font: UIFont(name: "Georgia-Bold", size: 20)!]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
    }
    
    @objc private func tapLeftBtn(){
        addTaskBtn()
    }
    
    @objc private func tapRightBtn(){
        goToProfileVC()
    }
    
    private func addTaskBtn(){
        addTaskAlert()
    }
    
    private func goToProfileVC() {
        AppStateManager.shared().profileToAuthState()
    }
}

extension TodoListVC: TodoListVCProtocol{
    func deleteTaskAlert(index: Int){
        viewModel.getTaskId(index: index)
        let deleteAlert = UIAlertController(title: "Sorry", message: "Are You Sure You Want To Delete This Task?", preferredStyle: .alert)
        deleteAlert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
        deleteAlert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { (action: UIAlertAction!) in
            self.viewModel.deleteTask()
        }))
        present(deleteAlert,animated: true, completion: nil )
    }
    
    func addTaskAlert(){
        let alertController = UIAlertController(title: "Add Task", message: "", preferredStyle: UIAlertController.Style.alert)
        alertController.addTextField { (textField : UITextField!) -> Void in
            textField.placeholder = "Task"
        }
        let saveAction = UIAlertAction(title: "Save", style: UIAlertAction.Style.default, handler: { alert -> Void in
            let taskTextField = alertController.textFields![0] as UITextField
            if let taskTF = taskTextField.text{
                self.viewModel.addTask(task: taskTF)
            }else{
                self.showAlert(alertTitle: "Error",message: "Please try again",actionTitle: "Dismiss")
            }
        })
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler:nil)
        
        alertController.addAction(saveAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
    }
    
    func reloadDataWithoutScroll() {
        tasksTableView.reloadData()
        tasksTableView.reloadDataWithoutScroll()
    }
    
    func showAlert(alertTitle: String, message: String, actionTitle: String) {
        ShowAlertsManager.showAlertWithCancel(alertTitle: alertTitle, message: message, actionTitle: actionTitle)
    }
    
    func showLoader() {
        self.view.showLoading()
    }
    
    func hideLoader() {
        self.view.hideLoading()
    }
    
}

