//
//  HomeTabViewController.swift
//  DevConfApp
//
//  Created by 鈴木友也 on 2019/11/30.
//  Copyright © 2019 tomoya.suzuki. All rights reserved.
//

import UIKit
import Swinject

final class HomeTabViewController: UITabBarController {
    var homeViewController: HomeViewController! = HomeViewController()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBar.isTranslucent = false
        tabBar.tintColor = .black
        
        setUpViewControllers()
    }
    
    private func setUpViewControllers() {
        
        var viewControllers = [UIViewController]()
        homeViewController.tabBarItem = UITabBarItem(tabBarSystemItem: UITabBarItem.SystemItem.mostRecent, tag: 1)
        viewControllers.append(UserProfileViewController())
        
        
        self.setViewControllers(viewControllers, animated: false)
        self.selectedIndex = 1
        self.selectedIndex = 0
    }
}
