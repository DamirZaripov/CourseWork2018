//
//  TransparentNavigationController.swift
//  CourseWork
//
//  Created by Damir Zaripov on 03/12/2018.
//  Copyright © 2018 Damir Zaripov. All rights reserved.
//

import UIKit

class TransparentNavigationController: UINavigationController {
    
    // - MARK: UINavigationController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationBar.titleTextAttributes = [
            .foregroundColor: UIColor.white,
            .font: UIFont.systemFont(ofSize: 17.0, weight: .regular)
        ]
        
        self.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationBar.shadowImage = UIImage()
        self.navigationBar.isTranslucent = true
        self.view.backgroundColor = .clear
        
        self.navigationBar.tintColor = UIColor.white
        self.navigationBar.barTintColor = UIColor(red: 0/255, green: 94/255, blue: 188/255, alpha: 1.0)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setNeedsStatusBarAppearanceUpdate()
    }
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return .lightContent
    }
}
