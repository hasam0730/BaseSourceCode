//
//  LoadMoreViewController.swift
//  BaseSourceCode
//
//  Created by Developer on 9/2/18.
//  Copyright © 2018 Developer. All rights reserved.
//

import UIKit
import Alamofire

class LoadMoreViewController: UIViewController {

	@IBOutlet weak var tableView: LoadMoreTableView!
	
	var page = 1
	let limit = 15
	var ordersList = [OrderEntity]()
	
    override func viewDidLoad() {
        super.viewDidLoad()
		//
		NetworkManager.requests(Router.history_order(parameters: ["limit": limit, "page": page],
													 headers: ["Authorization": "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjUzLCJpc3MiOiJodHRwOi8vcGh1Y2xvY3Roby5ob2FudnVzb2x1dGlvbnMuY29tLnZuL2FwaS91c2Vycy9sb2dpbiIsImlhdCI6MTUzNTc5NDIzOSwiZXhwIjoxNTYxNzE0MjM5LCJuYmYiOjE1MzU3OTQyMzksImp0aSI6Imh1OU05RGJhZ2ZhQm9tMDQiLCJpZCI6bnVsbH0.QF7LetAO7ZsuxSySbGLMd-YpTk1lPElW327XO7cpCTw"])) { rs in
														switch rs {
														case .success(let value):
															let smt = value as! DataResponse<Any>
															let caigifvay = (smt.result.value as! [String: Any])["data"] as! [String: Any]
															let cai = (caigifvay["data"] as! [[String: Any]])
															cai.map({
																let order = OrderEntity(dicData: $0)
																self.ordersList.append(order)
															})
															
															DispatchQueue.main.async {
																self.tableView.reloadData()
															}
														case .failure(let error):
															print(error.localizedDescription)
														}
		}
		//
    }
}

extension LoadMoreViewController: UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return ordersList.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueCell(reuseIdentifier: "cell", for: indexPath)
		cell.textLabel?.text = "\(indexPath.row)"
		cell.detailTextLabel?.text = ordersList[indexPath.row].sender_name
		return cell
	}
}

private var pendingRequestWorkItem: DispatchWorkItem?
private let timeDelay = 200

extension LoadMoreViewController: UITableViewDelegate {
	func scrollViewDidScroll(_ scrollView: UIScrollView) {
		let  height = scrollView.frame.size.height
		let contentYoffset = scrollView.contentOffset.y
		let distanceFromBottom = scrollView.contentSize.height - contentYoffset
		
		if distanceFromBottom < height {
			pendingRequestWorkItem?.cancel()
			let task = DispatchWorkItem { [weak self] in
				NetworkManager.requests(Router.history_order(parameters: ["limit": self?.limit, "page": self!.page+1],
															 headers: ["Authorization": "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjUzLCJpc3MiOiJodHRwOi8vcGh1Y2xvY3Roby5ob2FudnVzb2x1dGlvbnMuY29tLnZuL2FwaS91c2Vycy9sb2dpbiIsImlhdCI6MTUzNTc5NDIzOSwiZXhwIjoxNTYxNzE0MjM5LCJuYmYiOjE1MzU3OTQyMzksImp0aSI6Imh1OU05RGJhZ2ZhQm9tMDQiLCJpZCI6bnVsbH0.QF7LetAO7ZsuxSySbGLMd-YpTk1lPElW327XO7cpCTw"])) { rs in
																switch rs {
																case .success(let value):
																	let smt = value as! DataResponse<Any>
																	let caigifvay = (smt.result.value as! [String: Any])["data"] as! [String: Any]
																	let cai = (caigifvay["data"] as! [[String: Any]])
																	
																	guard cai.count != 0 else { return }
																	_ = cai.map({
																		let order = OrderEntity(dicData: $0)
																		self?.ordersList.append(order)
																	})
																	
																	DispatchQueue.main.async {
																		self?.tableView.reloadData()
																		print("🎠 tableview reload")
																		self?.page += 1
																	}
																case .failure(let error):
																	print(error.localizedDescription)
																}
				}
			}
			pendingRequestWorkItem = task
			DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(timeDelay), execute: task)
			
		}
	}
}
