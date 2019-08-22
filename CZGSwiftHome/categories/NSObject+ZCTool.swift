//
//  NSObject+ZCTool.swift
//  CZGSwiftHome
//
//  Created by 张闯闯 on 2019/8/22.
//  Copyright © 2019 张闯闯. All rights reserved.
//

import UIKit
protocol SelfAware: NSObjectProtocol {
    static func awake()
}
class NSObject_ZCTool: NSObject {

    /**
     * 实现方法交换
     * \param object 需要交换类的class对象
     * \param targetSel 需交换方法
     * \param toSel 交换成方法
     */
   static func changeMethodsWithObject(object: AnyClass,targetSel:Selector,toSel: Selector) -> Void {
        //确保DispatchQueue函数值执行一次
        DispatchQueue.once(token: "Method Swizzling") {
            let subStrMethod = class_getInstanceMethod(object, targetSel)
            let ny_subStrMenthod = class_getInstanceMethod(object, toSel)
        //判断原有类中是否有要替换方法的实现
            let didAddMethod: Bool = class_addMethod(object, targetSel, method_getImplementation(ny_subStrMenthod!), method_getTypeEncoding(ny_subStrMenthod!))
        //如果 class_addMethod 返回 yes,说明当前类中没有要替换方法的实现,所以需要在父类中查找,这时候就用到 method_getImplemetation 去获取 class_getInstanceMethod 里面的方法实现,然后再进行 class_replaceMethod 来实现 Swizzing
            if didAddMethod {
                class_replaceMethod(object, toSel, method_getImplementation(subStrMethod!), method_getTypeEncoding(subStrMethod!))
            }else{
                method_exchangeImplementations(subStrMethod!, ny_subStrMenthod!)
            }
        }
    
    }
    
}






//给DispatchQueue添加扩展实现  DispatchQueue.zone
extension DispatchQueue{
    private static var _onceTracker = [String]()
    public class func once(token: String,block:()->Void){
        objc_sync_enter(self)
        defer { objc_sync_exit(self) }
        if _onceTracker.contains(token) {
            return
        }
        _onceTracker.append(token)
        block()
    }
    func async(block: @escaping ()->()) {
        self.async(execute: block)
    }
    
    func after(time: DispatchTime, block: @escaping ()->()) {
        self.asyncAfter(deadline: time, execute: block)
    }
}

class NothingToSeeHere {
    static func harmlessFunction() {
        let typeCount = Int(objc_getClassList(nil, 0))
        let types = UnsafeMutablePointer<AnyClass>.allocate(capacity: typeCount)
        let autoreleasingTypes = AutoreleasingUnsafeMutablePointer<AnyClass>(types)
        objc_getClassList(autoreleasingTypes, Int32(typeCount))
        for index in 0 ..< typeCount {
            (types[index] as? SelfAware.Type)?.awake()
        }
        types.deallocate()
    }
}
extension UIApplication {
    private static let runOnce: Void = {
        NothingToSeeHere.harmlessFunction()
    }()
    override open var next: UIResponder? {
        UIApplication.runOnce
        return super.next
    }
}
