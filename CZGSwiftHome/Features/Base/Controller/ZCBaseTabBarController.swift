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
        self.selectedIndex = 0
        
    /**去除tabbar上的一跳灰色线条**/
        let img = UIImage.createCustomImageWithColor(color: UIColor.clear)
        self.tabBar.backgroundImage = img
        self.tabBar.shadowImage = img
        
        /**添加一条 自定义细线**/
        let lineView = UIView(frame: CGRect(x: 0, y:0, width: UIScreen.main.bounds.size.width, height: 0.5))
        lineView.backgroundColor = RGB0X(hexValue: 0xdcdbdb)
        self.tabBar.addSubview(lineView)
    }
    func setTabBarImageWithTitleS(homeImageAry: NSArray, comtrollers: NSArray)  {
        var selectHpmeAry = [Any]()
        selectHpmeAry = homeImageAry as! [Any]
        
        var vcArray = [Any]()
        var vc : UIViewController?
        for viewController in comtrollers {
            vc = viewController as? UIViewController
            let navi = ZCBaseNavigationController.init(rootViewController: vc!)
           vcArray.append(navi)
            
        }
        self.viewControllers = vcArray as? [UIViewController]
        
        for index in 0..<selectHpmeAry.count {
            
            let Vc = self.viewControllers![index]
            let arr = selectHpmeAry[index] as? Array<Any>
            Vc.tabBarItem = self.setTabBarItemWithImageName(imageName: arr?[0] as! String, selectedImagename: arr?[1] as! String, titleName: arr?[2] as! String)
            
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
