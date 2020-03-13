//
//  ZCUserViewController.swift
//  CZGSwiftHome
//
//  Created by 张闯闯 on 2019/8/14.
//  Copyright © 2019 张闯闯. All rights reserved.
//

import UIKit

class ZCUserViewController: ZCBaseViewController {

    override func viewWillAppear(_ animated: Bool) {
    
       super.viewWillAppear(animated)
       self.navigationController?.setNavigationBarHidden(true, animated: true)
      }
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.yellow
        // Do any additional setup after loading the view.
    }

    func setUI(){
        let imageView = UIImageView.init();
        
    }

}
