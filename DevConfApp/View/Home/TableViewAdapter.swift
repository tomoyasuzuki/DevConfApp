//
//  TableViewAdapter.swift
//  DevConfApp
//
//  Created by 鈴木友也 on 2019/12/29.
//  Copyright © 2019 tomoya.suzuki. All rights reserved.
//

import UIKit

class TableViewAdapter: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var tags: [TagModel] = []
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tags.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SUGGEST", for: indexPath)
        
        if !tags.isEmpty {
            cell.textLabel?.text = tags[indexPath.row].title
        }
        return cell
    }
}
