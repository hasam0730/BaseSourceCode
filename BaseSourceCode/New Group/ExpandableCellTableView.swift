//
//  ExpandableCellTableView.swift
//  ExpandCellTableView
//
//  Created by hieu nguyen on 7/5/18.
//  Copyright © 2018 hieu nguyen. All rights reserved.
//

import Foundation
import UIKit

protocol LoadMoreDataSourceDelegate: class {
	func cellForRow(at indexPath: IndexPath, with data: AnyObject, tableview: UITableView) -> UITableViewCell?
}

class ExpandableCellDatasource: NSObject, UITableViewDataSource {
    var dataGroup: [AnyObject]?
	var delegate: LoadMoreDataSourceDelegate?
	
    override init() {
        self.dataGroup = [AnyObject]()
    }
    
    init(data: [AnyObject]) {
        self.dataGroup = data
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataGroup!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = delegate?.cellForRow(at: indexPath, with: dataGroup![indexPath.row], tableview: tableView)
		return cell!
    }
}

class ExpandableCellDelegate: NSObject, UITableViewDelegate {
    override init() {

    }
	
	func scrollViewDidScroll(_ scrollView: UIScrollView) {
		print("asdasuhuhd")
	}
}
