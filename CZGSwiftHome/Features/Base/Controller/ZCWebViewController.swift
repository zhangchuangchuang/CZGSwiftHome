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
 

    var customWebView = WKWebView()
    var closeBut = UIButton()
    
    var url = String()
    lazy private var progressView : UIProgressView = {
        let progressView = UIProgressView.init(frame: CGRect(x: 0, y: 0, width: AppFrame.ScreenWidth, height: 2))
        progressView.progressTintColor = AppColor.themeRed
        progressView.trackTintColor = UIColor.clear
        self.view.addSubview(progressView)
        return progressView
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = RGB0X(hexValue: 0xf6f6f6)
        setUI()
        loadWeb(string: url)       
    }

    //MARK: ++++ WKScriptMessageHandler
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        DispatchQueue.global().async {
          
            
        }
    }
    override func backBarButtonItemAction() {
        if self.customWebView.canGoBack {
            self.customWebView.goBack()
        }else{
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    deinit {
        self.customWebView.removeObserver(self, forKeyPath: "estimatedProgress")
        self.customWebView.removeObserver(self, forKeyPath: "frame")
    }
}
//MARK:   -----界面相关   方法----
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
       
        
        self.customWebView.addObserver(self, forKeyPath: "estimatedProgress", options: [.new, .old], context: nil)
        
        self.customWebView.addObserver(self, forKeyPath: "frame", options: .new, context: nil)
        
    }
    //更新进度条位置
    func updateProgressViewToFrame(){
        var progressRect = CGRect()
        progressRect = self.progressView.frame
        progressRect.origin.y = (AppFrame.iPhoneX && (self.navigationController!.isNavigationBarHidden || (self.navigationController?.navigationBar.isHidden)!)) ? AppFrame.kStatusBarHeight : 0
        self.progressView.frame = progressRect
        
    }
    
    //加载web
    func loadWeb(string: String) -> Void {
        let new_url = string.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        let request = NSURLRequest(url: URL(string: new_url!)!, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 60)
        self.customWebView.load(request as URLRequest)
        
    }
    
    
    //添加关闭按钮
    func addNaviCloseButton() {
         removeNavIcloseBut()
        self.closeBut = UIButton(type: .custom)
        self.closeBut.frame = CGRect(x: 50, y:44, width: 10, height: 44)
        self.closeBut.setTitle("关闭", for: .normal)
        self.closeBut.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 20)
        self.closeBut.setTitleColor(RGB0X(hexValue: 0x556d80), for: .normal)
        self.closeBut.addTarget(self, action: #selector(closeButAction), for: .touchUpInside)
        self.navigationController?.navigationBar.addSubview(self.closeBut)
    }
    //每次加载钱 移除导航上的关闭按钮
    func removeNavIcloseBut(){
        self.closeBut.removeFromSuperview()
    }
    //按钮的点击事件
    @objc func closeButAction(){
        
        self.navigationController?.popViewController(animated: true)
    }
    
    
}

extension ZCWebViewController{
    //webview 进度条监听
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress" {
            if object as? WKWebView == self.customWebView{
                self.progressView.alpha = 1.0
                self.progressView.setProgress(Float(self.customWebView.estimatedProgress), animated: true)
                if self.customWebView.estimatedProgress >= 1.0{
                    UIView.animate(withDuration: 0.3, delay: 0.3, options: .curveEaseOut, animations: {
                        self.progressView.alpha = 0.0
                    }) { [weak self](finished : Bool) in
                        self?.progressView.setProgress(0.0, animated: false)
                    }
                }
            }else{
                super.observeValue(forKeyPath: keyPath, of: object, change: change, context: context)
            }
            
        }else if keyPath == "title"{
            if object as? WKWebView == self.customWebView{
                self.navigationController?.title = self.customWebView.title
            }else{
                super.observeValue(forKeyPath: keyPath, of: object, change: change, context: context)
            }
            
        }else if keyPath == "frame"{
            if object as? WKWebView == self.customWebView{
                self.updateProgressViewToFrame()
            }else{
                 super.observeValue(forKeyPath: keyPath, of: object, change: change, context: context)
            }
        }else{
             super.observeValue(forKeyPath: keyPath, of: object, change: change, context: context)
        }
        
    }
    //MARK: + + + + + WKNavigationDelegate + + + + ++
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        
    }
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        if webView.title!.count > 0 {
            self.navigationItem.title = webView.title
        }
    }
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        //加载失败
    }
    //在发送请求之前，界定是否跳转
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        print("web url:",navigationAction.request.url!.absoluteString)
        let url = navigationAction.request.url
        let scheme  = url?.scheme
        
        if scheme == "tel" {
            //防止ios 10 及其以后 拨打电话系统弹出窗延迟出现
            DispatchQueue.main.async {
                if #available(iOS 10.0, *){
                    UIApplication.shared.open(navigationAction.request.url!, options: [UIApplication.OpenExternalURLOptionsKey(rawValue: ""):""], completionHandler: { (tag) in})
                }else{
                     UIApplication.shared.openURL(navigationAction.request.url!)
                }
            }
            decisionHandler(WKNavigationActionPolicy.cancel)
//           resourceSpecifier
        }else{
            decisionHandler(WKNavigationActionPolicy.allow)
        }
    }
  
    
    
}
