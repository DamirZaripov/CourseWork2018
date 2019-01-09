//
//  CurrentCoursesViewController.swift
//  CourseWork
//
//  Created by Damir Zaripov on 30/11/2018.
//  Copyright © 2018 Damir Zaripov. All rights reserved.
//

import UIKit
import SDWebImage

class CurrentCoursesViewController: UIViewController {
    
    // MARK: - Instance Properties
    
    @IBOutlet fileprivate weak var tableView: UITableView!
    
    fileprivate var currentCourses = [Course]()
    
    fileprivate enum Constants {
        
        // MARK: - Type Properties
        
        static let currentCourseTableCellIdentifier = "currentCourse"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.registerNib()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        currentCourses.removeAll()
        self.getCurrentCourse()
    }
    
    func registerNib() {
        let nib = UINib(nibName: "CurrentCourseTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: Constants.currentCourseTableCellIdentifier)
    }
    
    func getCurrentCourse() {
        NetworkManager.shared.getBlocks { [weak self] (blocks) in
            
            blocks.forEach {
                self?.currentCourses.append(contentsOf: $0.courses.filter {
                    $0.selected
                })
            }
            
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "showToDo") {
            let todoVC = segue.destination as! ToDoViewController
            todoVC.todo = sender as? [ToDo]
        }
    }
    
}

// MARK: - UITableViewDelegate

extension CurrentCoursesViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let cell = cell as! CurrentCourseTableViewCell
        cell.subjectIconImageViewTarget.sd_setImage(with: currentCourses[indexPath.row].imageURL)
    }
    
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let cell = cell as! CurrentCourseTableViewCell
        cell.subjectIconImageViewTarget.sd_cancelCurrentImageLoad()
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "showToDo", sender: currentCourses[indexPath.row].todo)
    }
}

// MARK: - UITableViewDataSource

extension CurrentCoursesViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if currentCourses.count == 0 {
            let noDataLabel: UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: tableView.bounds.size.height))
            noDataLabel.text = "У вас еще не выбраны курсы, поэтому нет текущих курсов. Пройдите на экран 'Выборы курсов' и выберите курсы, чтобы начать!"
            noDataLabel.textColor = UIColor.white
            noDataLabel.numberOfLines = 0
            noDataLabel.font = UIFont(name: "Open Sans", size: 15)
            noDataLabel.textAlignment = .center
            tableView.backgroundView = noDataLabel
            tableView.separatorStyle = .none
        } else {
            tableView.backgroundView?.isHidden = true
        }
        
        return currentCourses.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.currentCourseTableCellIdentifier, for: indexPath) as! CurrentCourseTableViewCell
        cell.config(with: currentCourses[indexPath.row])
        
        return cell
    }
    
}
