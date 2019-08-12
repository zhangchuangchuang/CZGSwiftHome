//
//  ZCBaseNavigationController.swift
//  CZGSwiftHome
//
//  Created by 张闯闯 on 2019/8/10.
//  Copyright © 2019 张闯闯. All rights reserved.
//

import UIKit

class ZCBaseNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //Scrollview 及 Scrollview子类的头部适配问题
        if #available(iOS 11.0, *){
            UIScrollView.ContentInsetAdjustmentBehavior(rawValue: 3)
        }
        
        
        //设置导航栏下方细线
        self.navigationBar.shadowImage = UIImage.createCustomImageWithColor(color: AppColor.navigationLineColors)
        self.interactivePopGestureRecognizer?.delegate = self
        //默认是打开右滑手势
        setIsUnGestureReturnController(isUnGestureReturnController: false)
        
    }
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        guard #available(iOS 11.0, *) else {
            viewController.automaticallyAdjustsScrollViewInsets = false
            return
        }
        viewController.hidesBottomBarWhenPushed = true
        super.pushViewController(viewController, animated: true)
    }

    override func popViewController(animated: Bool) -> UIViewController? {
      deleteWindowSubviews()
      return super .popViewController(animated: true)
    }
    
}



//MAKR: ---UINavigationController 类扩展
extension ZCBaseNavigationController{
    
    private func deleteWindowSubviews() {//移除window上子视图
        let win : UIWindow? = UIApplication.shared.keyWindow
        for view in win!.subviews {
            view.removeFromSuperview()
        }
    }
    
}
//MARK:--导航栏返回手势问题
extension ZCBaseNavigationController:UIGestureRecognizerDelegate{
     func setIsUnGestureReturnController(isUnGestureReturnController: Bool) {
      self.interactivePopGestureRecognizer?.isEnabled = !isUnGestureReturnController
    }
}
