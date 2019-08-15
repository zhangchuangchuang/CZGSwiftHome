//
//  ZCWebViewController.swift
//  CZGSwiftHome
//
//  Created by 张闯闯 on 2019/8/10.
//  Copyright © 2019 张闯闯. All rights reserved.
//

import UIKit
import WebKit
import JavaScriptCore

class ZCWebViewController: ZCBaseViewController,WKNavigationDelegate,WKUIDelegate,WKScriptMessageHandler {
 

    let progressView = UIProgressView()
    var customWebView = WKWebView()
    
    
    let url = String()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = RGB0X(hexValue: 0xf6f6f6)
      
    }
    
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        <#code#>
    }
    
    
    
    
}

extension ZCWebViewController{
    func setUI() {
        let configuration = WKWebViewConfiguration()
        configuration.userContentController = WKUserContentController()
        self.customWebView = WKWebView.init(frame: CGRect(x: 0, y: 0, width:AppFrame.ScreenWidth , height: AppFrame.ScreenHeight-AppFrame.kNavigationBarHeight-AppFrame.kStatusBarHeight-AppFrame.k_5_8_BOTTOM), configuration: configuration)
        
        self.customWebView.uiDelegate = self
        self.customWebView.navigationDelegate = self
        self.customWebView.backgroundColor = UIColor.clear
        self.customWebView.isOpaque = false//使网页透明
        self.customWebView.scrollView.showsVerticalScrollIndicator = false//隐藏滚动条
        self.view.addSubview(self.customWebView)
        
        if #available(iOS 11.0, *){
            self.customWebView.scrollView.contentInsetAdjustmentBehavior = .never
        }
        
//        let <#name#> = <#value#>
        
        
        
        
    }
   
    
}
