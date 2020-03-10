//
//  ZCHomeViewController.swift
//  CZGSwiftHome
//
//  Created by 张闯闯 on 2019/8/14.
//  Copyright © 2019 张闯闯. All rights reserved.
//

import UIKit
import Masonry
class ZCHomeViewController: ZCBaseViewController {

    @IBOutlet var web_btn: UIButton!
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.red
        self.setUI()
    }
    
    func setUI(){
        let nameLabe = UILabel.init()
//        nameLabe.frame = CGRect(x: 0, y: 0, width: 40, height: 20)
        nameLabe.text = "我是第一个字"
        nameLabe.textColor = UIColor.yellow
        nameLabe.contentMode = .left
        nameLabe.textAlignment = .left
        nameLabe.backgroundColor = RGB(113, g: 250, b: 276)
        nameLabe.adjustsFontSizeToFitWidth = true   
        self.view.addSubview(nameLabe)
        
        nameLabe.mas_makeConstraints { (make) in
            make?.center.equalTo()(self.view)
            make?.width.mas_equalTo()(40)
            make?.height.mas_equalTo()(50)
        }
        
    }
    
    
    @IBAction func webButActionClick(_ sender: UIButton) {
        let VC = ZCWebViewController();
        VC.url = "https://www.baidu.com"
        VC.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(VC, animated: true)
        
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
