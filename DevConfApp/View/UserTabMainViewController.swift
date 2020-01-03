//
//  UserTabMainViewController.swift
//  DevConfApp
//
//  Created by 鈴木友也 on 2020/01/01.
//  Copyright © 2020 tomoya.suzuki. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class UserTabMainViewController: ButtonBarPagerTabStripViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        // set view controllers
        let viewControllers = [UserThreadViewController(), UserThreadViewController(), UserProfileViewController()]
        return viewControllers
    }
    
}
