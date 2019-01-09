//
//  CourseSelectionViewController.swift
//  CourseWork
//
//  Created by Damir Zaripov on 18/12/2018.
//  Copyright © 2018 Damir Zaripov. All rights reserved.
//

import UIKit

class CourseSelectionViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!

    var selectiedCourses = [Int]()
    var blocks = [Block]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.registerNib()
        self.getBlocks()
    }
    
    func registerNib() {
        let nib = UINib(nibName: "ChoosingCourseTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "choosingCourse")
    }
    
    func getBlocks() {
        NetworkManager.shared.getBlocks { [weak self] (blocks) in
            
            self?.blocks = blocks
            
            self?.selectiedCourses.removeAll()
            
            for block in blocks {
                for course in block.courses {
                    if (course.selected) {
                        self?.selectiedCourses.append(course.id)
                    }
                }
            }
            
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
    
    func chooseCourse(id: Int) {
        NetworkManager.shared.chooseCourse(id: id) { [weak self] (result) in
            if (result) {
                self?.getBlocks()
            } else {
                let alert = AlertFactory.shared.createAlert(title: "Произошла ошибка на сервере", message: "Попробуйте выполнить запрос позже")
                self?.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    func cancelCourse(id: Int) {
        NetworkManager.shared.cancelCourse(id: id) { [weak self] (result) in
            if (result) {
                self?.getBlocks()
            } else {
                let alert = AlertFactory.shared.createAlert(title: "Произошла ошибка на сервере", message: "Попробуйте выполнить запрос позже")
                self?.present(alert, animated: true, completion: nil)
            }
        }
    }
    
}

extension CourseSelectionViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let cell = cell as! ChoosingCourseTableViewCell
        cell.courseImageViewTarget.sd_setImage(with: blocks[indexPath.section].courses[indexPath.row].imageURL)
        
        if selectiedCourses.contains(cell.courseId) {
            cell.courseSelectedViewTarget.backgroundColor = UIColor(red: 102, green: 255, blue: 102)
        } else {
            cell.courseSelectedViewTarget.backgroundColor = UIColor.white
        }
    }
    
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let cell = cell as! ChoosingCourseTableViewCell
        cell.courseImageViewTarget.sd_cancelCurrentImageLoad()
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel()
        label.text = blocks[section].name
        label.backgroundColor = UIColor(rgb: 0x005EBC)
        label.textColor = UIColor.white
        label.textAlignment = .center
        label.center = self.view.center
        label.center.y = self.view.center.y
        return label
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection: Int) -> CGFloat {
        return 45.0
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return blocks.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let id = blocks[indexPath.section].courses[indexPath.row].id
        if selectiedCourses.contains(id) {
            self.cancelCourse(id: id)
        } else {
            self.chooseCourse(id: id)
        }
    }
}

extension CourseSelectionViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return blocks[section].courses.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "choosingCourse", for: indexPath) as! ChoosingCourseTableViewCell
        
        cell.config(with: blocks[indexPath.section].courses[indexPath.row])
        
        cell.onInfoButtonClicked = {
        
            let spells = self.blocks[indexPath.section].courses[indexPath.row].spells
            
            var message = "Получаемые навыки: "
            for spell in spells {
                message = message + "\(spell.name)" + ","
            }
            
            message = String(message.dropLast(1))
  
            let alert = AlertFactory.shared.createAlert(title: self.blocks[indexPath.section].courses[indexPath.row].description, message: message)
            self.present(alert, animated: true, completion: nil)
        }
        
        return cell
    }
}

extension UIColor {
    
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(rgb: Int) {
        self.init(
            red: (rgb >> 16) & 0xFF,
            green: (rgb >> 8) & 0xFF,
            blue: rgb & 0xFF
        )
    }
}
