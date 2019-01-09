//
//  SelectedCourse.swift
//  CourseWork
//
//  Created by Damir Zaripov on 18/12/2018.
//  Copyright © 2018 Damir Zaripov. All rights reserved.
//

import Foundation

struct SelectedCourse {
    var semesterNumber: Int
    var blockNumber: Int
    
    init(semesterNumber: Int, blockNumber: Int) {
        self.semesterNumber = semesterNumber
        self.blockNumber = blockNumber
    }
}
