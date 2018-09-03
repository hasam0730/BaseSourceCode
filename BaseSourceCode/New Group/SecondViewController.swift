//
//  SecondViewController.swift
//  ExpandCellTableView
//
//  Created by hieu nguyen on 7/5/18.
//  Copyright © 2018 hieu nguyen. All rights reserved.
//

import UIKit
import Alamofire
import PullRefresh_LoadMore

class SecondViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
	
	var refreshloadView: RefreshLoadView!
	var allObjectArray: NSMutableArray = []
	
	var page = 1
	let limit = 15
	var ordersList = [OrderEntity]()
	let token = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjUzLCJpc3MiOiJodHRwOi8vcGh1Y2xvY3Roby5ob2FudnVzb2x1dGlvbnMuY29tLnZuL2FwaS91c2Vycy9sb2dpbiIsImlhdCI6MTUzNTc5NDIzOSwiZXhwIjoxNTYxNzE0MjM5LCJuYmYiOjE1MzU3OTQyMzksImp0aSI6Imh1OU05RGJhZ2ZhQm9tMDQiLCJpZCI6bnVsbH0.QF7LetAO7ZsuxSySbGLMd-YpTk1lPElW327XO7cpCTw"
    override func viewDidLoad() {
        super.viewDidLoad()
		
		//add Test Data
		NetworkManager.requests(Router.history_order(parameters: ["limit": limit, "page": page],
													 headers: ["Authorization": "Bearer \(token)"])) { rs in
				switch rs {
				case .success(let value):
					let smt = value as! DataResponse<Any>
					let caigifvay = (smt.result.value as! [String: Any])["data"] as! [String: Any]
					let cai = (caigifvay["data"] as! [[String: Any]])
					_ = cai.map({
						let order = OrderEntity(dicData: $0)
						self.ordersList.append(order)
					})

					DispatchQueue.main.async {
						tableView.reloadData()
					}
				case .failure(let error):
					print(error.localizedDescription)
				}
}
		
		
		
		
		for i in 1...(100) {
			allObjectArray.add(i.description)
		}
		
		//Initial
		refreshloadView  = RefreshLoadView(frame: CGRect(x: 95, y: 0, width: tableView.frame.width, height: tableView.frame.height), pic_size: CGFloat(30), insert_size: CGFloat(50))
		
		//have 25 item on each page
		refreshloadView.pageItems = 25
		
		//set Data
		refreshloadView.setData(allObjectArray)
		refreshloadView.delegate = self
		
		//add RefreshLoadView to tableView
		tableView.addSubview(refreshloadView)
		
		tableView.register(UITableViewCell.self, reuseIdentifier: "cell")
    }
}

extension SecondViewController: RefreshLoadViewDelegate {
	func refreshData(_ view: RefreshLoadView) {
		
		//refresh data
		DispatchQueue.global(priority: DispatchQueue.GlobalQueuePriority.default).async(execute: {
			sleep(1)
			DispatchQueue.main.async(execute: {
				//end refresh
				self.refreshloadView.endRefresh(self.tableView)
			});
		});
	}
	
	func loadData(_ view: RefreshLoadView) {
		//load more data
		DispatchQueue.global(priority: DispatchQueue.GlobalQueuePriority.default).async(execute: {
			sleep(1)
			DispatchQueue.main.async(execute: {
				//end load more
				self.refreshloadView.endLoadMore(self.tableView)
			});
		});
	}
}

extension SecondViewController: UITableViewDataSource, UITableViewDelegate {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		if refreshloadView != nil {
			return refreshloadView.showElements.count
		} else {
			return 0
		}
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		var cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! UITableViewCell
		if !(cell != nil) {
			cell = UITableViewCell(style: UITableViewCellStyle.value1, reuseIdentifier: "cell")
		}
		if refreshloadView != nil {
			cell!.textLabel!.text = refreshloadView.showElements[indexPath.row] as? String
		}
		return cell!
	}
	
	func scrollViewDidScroll(_ scrollView: UIScrollView) {
		refreshloadView.scrollViewDidScroll(scrollView)
	}
	
	//scroll event
	func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
		refreshloadView.scrollViewDidEndDragging(scrollView)
	}
}
