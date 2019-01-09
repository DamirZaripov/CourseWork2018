//
//  ToDoViewController.swift
//  CourseWork
//
//  Created by Damir Zaripov on 19/12/2018.
//  Copyright © 2018 Damir Zaripov. All rights reserved.
//

import UIKit

class ToDoViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var todo: [ToDo]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.registerNib()
    }
    
    func registerNib() {
        let nib = UINib(nibName: "ToDoTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "toDoCell")
    }
    
    func changeValueTodo(id: Int, oldValue: Bool, resultChange: @escaping (Bool) -> ()) {
        NetworkManager.shared.changeToDoValue(id: id, oldValue: oldValue) { (result) in
            resultChange(result)
        }
    }
    
}

extension ToDoViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}

extension ToDoViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todo.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "toDoCell", for: indexPath) as! ToDoTableViewCell
        cell.config(with: todo[indexPath.row])
        
        cell.onToDoButtonClicked = {
            self.changeValueTodo(id: self.todo[indexPath.row].id, oldValue: self.todo[indexPath.row].checked) { [weak self] (result) in
                if (result) {
                    cell.changeButtonImage()
                }
            }
        }
     
        return cell
    }
    
    
}
