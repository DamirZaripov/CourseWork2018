//
//  UIImageExtension.swift
//  CourseWork
//
//  Created by Damir Zaripov on 19/12/2018.
//  Copyright © 2018 Damir Zaripov. All rights reserved.
//

import UIKit

extension UIImage {
    
    func isEqualToImage(image: UIImage) -> Bool {
        let data1: NSData = self.pngData()! as NSData
        let data2: NSData = image.pngData()! as NSData
        return data1.isEqual(data2)
    }
}
