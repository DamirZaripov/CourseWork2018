//
//  CurrentCourseTableViewCell.swift
//  CourseWork
//
//  Created by Damir Zaripov on 30/11/2018.
//  Copyright © 2018 Damir Zaripov. All rights reserved.
//

import UIKit

class CurrentCourseTableViewCell: UITableViewCell {

    @IBOutlet fileprivate weak var subjectNameLabel: UILabel!
    @IBOutlet fileprivate weak var numberOfSemestrLabel: UILabel!
    @IBOutlet fileprivate weak var numberOfBlockLabel: UILabel!
    @IBOutlet fileprivate weak var teacherNameLabel: UILabel!
    @IBOutlet fileprivate weak var percentageOfCompletionLabel: UILabel!
    @IBOutlet fileprivate weak var subjectIconImageView: UIImageView!
    @IBOutlet fileprivate weak var view: UIView!
    
    var subjectIconImageViewTarget: UIImageView {
        return self.subjectIconImageView
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.view.layer.cornerRadius = 10
    }
    
    func config(with course: Course) {
        self.subjectNameLabel.text = course.name
        self.numberOfSemestrLabel.text = "\(course.semestrNumber) семестр"
        self.numberOfBlockLabel.text = "\(course.blockNumber) блок"
        self.teacherNameLabel.text = course.teacher
        self.percentageOfCompletionLabel.text = "\(course.percents) %"
    }
    
}
