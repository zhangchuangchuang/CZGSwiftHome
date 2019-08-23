//
//  ZCHomeViewController.swift
//  CZGSwiftHome
//
//  Created by 张闯闯 on 2019/8/14.
//  Copyright © 2019 张闯闯. All rights reserved.
//

import UIKit

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
