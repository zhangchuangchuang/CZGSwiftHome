//
//  ZCDictionnary+ZCTool.swift
//  CZGSwiftHome
//
//  Created by 张闯闯 on 2020/3/13.
//  Copyright © 2020 张闯闯. All rights reserved.
//

import Foundation

extension NSDictionary{
    class func GetStringDict(dict:NSDictionary,key:Any) -> NSString{
        var str = ""
        if dict.isKind(of: NSDictionary.classForCoder()) || dict.isKind(of: NSMutableDictionary.classForCoder()) {
            str = dict.value(forKey: key)
            
        }
        
        
    }
}
