//
//  AlertFactory.swift
//  CourseWork
//
//  Created by Damir Zaripov on 03/12/2018.
//  Copyright © 2018 Damir Zaripov. All rights reserved.
//

import UIKit

class AlertFactory {
    
    static let shared = AlertFactory()
    
    init(){}
    
    func createAlert(title: String, message: String) -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        return alert
    }
}
