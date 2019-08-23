//
//  UIView+ZCTool.swift
//  CZGSwiftHome
//
//  Created by 张闯闯 on 2019/8/12.
//  Copyright © 2019 张闯闯. All rights reserved.
//

import Foundation
import UIKit


extension UIView{
    var  additionalData: AnyObject{
        set{
             let key: UnsafeRawPointer! = UnsafeRawPointer.init(bitPattern: "additionlData".hashValue)
            objc_setAssociatedObject(self, key, newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC)
        }
        get{
              let key: UnsafeRawPointer! = UnsafeRawPointer.init(bitPattern: "additionlData".hashValue)
            return objc_getAssociatedObject(self, key) as AnyObject 
        }
    }
    
    
}
