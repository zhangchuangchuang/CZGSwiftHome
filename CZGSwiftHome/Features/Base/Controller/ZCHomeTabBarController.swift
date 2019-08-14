//
//  ZCHomeTabBarController.swift
//  CZGSwiftHome
//
//  Created by 张闯闯 on 2019/8/13.
//  Copyright © 2019 张闯闯. All rights reserved.
//

import UIKit

class ZCHomeTabBarController: ZCBaseTabBarController,UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.delegate = self
        
        let homeImageAry : [Array<String>] = [
             ["btn_column_normal","btn_column_selected","视频"],
             ["btn_live_normal","btn_live_selected","喜爱"],
             ["btn_user_normal","btn_user_selected","商城"],
             ["btn_home_normal","btn_home_selected","个人中心"]
                                              ]
        self.setTabBarImageWithTitleS(homeImageAry: homeImageAry as NSArray, comtrollers: [ZCHomeViewController(),ZCDetailViewController(),ZCShopViewController(),ZCUserViewController()])
    }
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        return true
    }
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
