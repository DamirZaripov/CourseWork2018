//
//  ChoosingCourseTableViewCell.swift
//  CourseWork
//
//  Created by Damir Zaripov on 18/12/2018.
//  Copyright © 2018 Damir Zaripov. All rights reserved.
//

import UIKit

class ChoosingCourseTableViewCell: UITableViewCell {

    @IBOutlet fileprivate weak var courseImageView: UIImageView!
    @IBOutlet fileprivate weak var courseNameLabel: UILabel!
    @IBOutlet fileprivate weak var courseTeacherLabel: UILabel!
    @IBOutlet fileprivate weak var courseSelectedView: UIView!
    @IBOutlet fileprivate weak var infoButton: UIButton!
    var courseId: Int!
    
    var courseImageViewTarget: UIImageView {
        return self.courseImageView
    }
    
    var courseSelectedViewTarget: UIView {
        return self.courseSelectedView
    }
    
    var onInfoButtonClicked: (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func config(with course: Course) {
        self.courseNameLabel.text = course.name
        self.courseTeacherLabel.text = course.teacher
        self.courseId = course.id
    }
    
    @IBAction func onInfoButtonTouchUpInside(_ sender: Any) {
        self.onInfoButtonClicked?()
    }
}
