//
//  RequestManager.swift
//  CourseWork
//
//  Created by Damir Zaripov on 04/12/2018.
//  Copyright © 2018 Damir Zaripov. All rights reserved.
//

import UIKit 

class RequestManager {
    
    static let instance = RequestManager()

    init() {}
    
    var token: String?
    var login: String?
}
