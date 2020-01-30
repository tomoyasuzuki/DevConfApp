//
//  TopTabViewController.swift
//  DevConfApp
//
//  Created by 鈴木友也 on 2020/01/30.
//  Copyright © 2020 tomoya.suzuki. All rights reserved.
//

import UIKit

class TopTabViewController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var views: [UIViewController] = []
        
        let chat = ChatListViewController()
        chat.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "SpeechBubbleIcon_24_white"), tag: 0)
        let prof = UserProfileViewController()
        prof.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "home_icon_24"), tag: 1)
        
        views.append(chat)
        views.append(prof)
        
        self.setViewControllers(views, animated: true)
        self.selectedIndex = 0
    }
}
