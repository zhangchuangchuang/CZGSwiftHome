//
//  UIImage+ZCTool.swift
//  CZGSwiftHome
//
//  Created by 张闯闯 on 2019/8/12.
//  Copyright © 2019 张闯闯. All rights reserved.
//

import Foundation
import UIKit

extension UIImage{
    class func createCustomImageWithColor(color:UIColor) -> UIImage{
        let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context!.setFillColor(color.cgColor)
        context!.fill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
}
