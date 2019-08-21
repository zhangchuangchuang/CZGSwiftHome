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
        //默认背景色为白色
        setCustomNaviBackgroundColor(color: UIColor.white)
        setCustomNaviTitleColor(color: AppColor.black)
        self.navigationBar.isTranslucent = false
        self.edgesForExtendedLayout = UIRectEdge.init(rawValue: 0)
        self.customNavigationBackBarButtonItem(image: SetImage(string: "def_naviBack")! )
        
        
    }
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        guard #available(iOS 11.0, *) else {
            viewController.automaticallyAdjustsScrollViewInsets = false
            return
        }
        super.pushViewController(viewController, animated: true)
    }

    override func popViewController(animated: Bool) -> UIViewController? {
      deleteWindowSubviews()
      return super .popViewController(animated: true)
    }
    
    override func popToRootViewController(animated: Bool) -> [UIViewController]? {
        deleteWindowSubviews()
        return super.popToRootViewController(animated: true)
    }
    override func popToViewController(_ viewController: UIViewController, animated: Bool) -> [UIViewController]? {
        deleteWindowSubviews()
        return super.popToViewController(viewController, animated: true)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
    
}



//MAKR: ---UINavigationController 类扩展
extension ZCBaseNavigationController{
    
    private func deleteWindowSubviews() {//移除window上子视图
//        let win : UIWindow? = UIApplication.shared.keyWindow
//        for view in win!.subviews {
//            view.removeFromSuperview()
//        }
    }
    /** 设置导航栏背景色通过图片 **/
    func setCustomNaviBackgroundImageFormImage(image:UIImage){
        self.navigationController?.navigationBar.isTranslucent = false//不透明
        self.navigationController?.navigationBar.setBackgroundImage(image, for: .default)
    }
    /** 设置导航栏背景色通过颜色 **/
    func setCustomNaviBackgroundColor(color:UIColor){
        self.navigationController?.navigationBar.isTranslucent = false//不透明
        self.navigationController?.navigationBar.tintColor = color
    }
    /** 设置导航栏标题颜色 **/
    func setCustomNaviTitleColor(color: UIColor){
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont.italicSystemFont(ofSize: 12),NSAttributedString.Key.foregroundColor:color]
    }
    
    
}
//MARK: --自定义 导航栏上的控件按钮
extension ZCBaseNavigationController{
    func customNavigationBackBarButtonItem(image: UIImage) {
        for view  in self.navigationBar.subviews {
            if(view.isKind(of: UIBarButtonItem.self)){
               view.removeFromSuperview()
            }
        }
        let imgBack = image.withRenderingMode(.alwaysOriginal)
        
        /**替换系统蓝色箭头**/
        let customImage = UIImage.createCustomImageWithColor(color: UIColor.orange)
//        let backItem = UIBarButtonItem()
        self.navigationBar.backIndicatorImage = customImage
        self.navigationBar.backIndicatorTransitionMaskImage = customImage
//        self.navigationItem.backBarButtonItem = backItem
        
        /**修改返回按钮文字位置**/
        UIBarButtonItem.appearance()
            .setBackButtonTitlePositionAdjustment(UIOffset(horizontal: -2000, vertical: 0), for: .default)
//
        let leftButton = UIBarButtonItem(image:UIImage.init(named: "btn_column_selected")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal), style: .plain, target: self, action:#selector(backBarButtonItemAction))
//        self.navigationBar.backIndicatorImage = imgBack
//        self.navigationBar.backIndicatorTransitionMaskImage = imgBack
        self.navigationItem.leftBarButtonItem = leftButton
        
    }
    
    /**返回按钮事件（子类可重写）**/
    @objc func backBarButtonItemAction(){
        self.navigationController?.popViewController(animated: true)
    }
    
    //设置右侧操作按钮
    func setHandleButton(frame: CGRect,image:UIImage?, title:String, target:UIViewController?,action: Selector?) -> UIButton {
        let handleButton = UIButton(type: .custom)
        handleButton.frame = frame
        handleButton.setImage(image, for: .normal)
        handleButton.setTitle(title, for: .normal)
        handleButton.addTarget(target, action:action!, for: .touchUpInside)
        handleButton.titleLabel?.font = FONT(font: 14)
        handleButton.backgroundColor = UIColor.clear
        handleButton.setTitleColor(AppColor.black, for: .normal)
        handleButton.contentHorizontalAlignment = .right
        let barBut = [UIBarButtonItem(customView: handleButton)]
        target?.navigationItem.setRightBarButtonItems(barBut, animated: true)
        return handleButton
    }

}

//MARK:--导航栏返回手势问题
extension ZCBaseNavigationController:UIGestureRecognizerDelegate{
     func setIsUnGestureReturnController(isUnGestureReturnController: Bool) {
      self.interactivePopGestureRecognizer?.isEnabled = !isUnGestureReturnController
    }
}
