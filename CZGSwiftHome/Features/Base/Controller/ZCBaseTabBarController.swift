//
//  ZCBaseTabBarController.swift
//  CZGSwiftHome
//
//  Created by 张闯闯 on 2019/8/10.
//  Copyright © 2019 张闯闯. All rights reserved.
//

import UIKit

class ZCBaseTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.tabBar.barTintColor = UIColor.white
        self.tabBar.backgroundColor = UIColor.white
        self.tabBar.tintColor = UIColor.white
        
        
    /**去除tabbar上的一跳灰色线条**/
        let img = UIImage.createCustomImageWithColor(color: UIColor.clear)
        self.tabBar.backgroundImage = img
        self.tabBar.shadowImage = img
        
        /**添加一条 自定义细线**/
        let lineView = UIView(frame: CGRect(x: 0, y: (self.tabBarController?.tabBar.frame.size.height)!-0.5, width: UIScreen.main.bounds.size.width, height: 0.5))
        lineView.backgroundColor = RGB0X(hexValue: 0xdcdbdb)
        self.tabBar.addSubview(lineView)
    }
    func setTabBarImageWithTitleS(homeImageAry: NSArray, comtrollers: NSArray)  {
        let selectHpmeAry = NSMutableArray(array: homeImageAry)
        let vcArray = NSMutableArray()
        for viewController in comtrollers {
           let vc = viewController as! UIViewController
            let navi = ZCBaseNavigationController(rootViewController: vc)
            vcArray.add(navi)
        }
        self.viewControllers = vcArray as? [UIViewController]
        
        for (index,value) in selectHpmeAry.enumerated() {
            
            let Vc = value as! UIViewController
            Vc.tabBarItem = self.setTabBarItemWithImageName(imageName: selectHpmeAry[index] as! String, selectedImagename: selectHpmeAry[index] as! String, titleName: selectHpmeAry[index] as! String)
            
        }
    }


}
extension ZCBaseTabBarController{
    func setTabBarItemWithImageName(imageName:String, selectedImagename:String, titleName:String) -> UITabBarItem {
        let image = UIImage(named: imageName)?.withRenderingMode(.alwaysOriginal)
        let selectedImage = UIImage(named: selectedImagename)?.withRenderingMode(.alwaysOriginal)
        let tabBarItem = UITabBarItem(title: titleName, image: image, selectedImage: selectedImage)
//        let selectedDic = NSDictionary.dictionaryWithValues()
        tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: RGB0X(hexValue: 0x9b9a9a),NSAttributedString.Key.font:FONT(font: 11)], for: .normal)
        tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: RGB0X(hexValue: 0xff8c68),NSAttributedString.Key.font:FONT(font: 11)], for: .selected)
        //设置文字偏移量
        tabBarItem.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: -2)
        
        return tabBarItem
        
    }
    
    
    
}
