//
//  DemoViewController.swift
//  DevConfApp
//
//  Created by 鈴木友也 on 2020/01/02.
//  Copyright © 2020 tomoya.suzuki. All rights reserved.
//

import UIKit

class DemoViewController: UIViewController {
    var pView = IntroduceView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(pView)
        
        pView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
