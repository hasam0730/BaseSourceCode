//
//  NetworkViewController.swift
//  BaseSourceCode
//
//  Created by Developer on 9/1/18.
//  Copyright © 2018 Developer. All rights reserved.
//

import UIKit
import Alamofire

class NetworkViewController: UIViewController {

	@IBAction func networkAction(_ sender: UIButton) {
		// Alamofire.request(Router.readUser(username: ""))
		
//		Alamofire.request(Router.login(parameters: ["email": "truonghanhhv1990@gmail.com",
//													"password": "123456"])).responseJSON(completionHandler: { reponse in
//			print(reponse.result.value!)
//		})
//		
//		print("----")
//		Alamofire.request(Router.list_level(id: 0))
//			.responseJSON(completionHandler: { reponse in
//			print(reponse.result.value!)
//		})
//		
//		
//		// danh sach lich su dat hang
		
		NetworkManager.requests(Router.history_order(parameters: ["limit": 10, "page": 1],
													 headers: ["Authorization": "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjUzLCJpc3MiOiJodHRwOi8vcGh1Y2xvY3Roby5ob2FudnVzb2x1dGlvbnMuY29tLnZuL2FwaS91c2Vycy9sb2dpbiIsImlhdCI6MTUzNTc5NDIzOSwiZXhwIjoxNTYxNzE0MjM5LCJuYmYiOjE1MzU3OTQyMzksImp0aSI6Imh1OU05RGJhZ2ZhQm9tMDQiLCJpZCI6bnVsbH0.QF7LetAO7ZsuxSySbGLMd-YpTk1lPElW327XO7cpCTw"])) { rs in
														switch rs {
														case .success(let value):
															print("⛵️sucess1: \((value as! DataResponse<Any>).request!.url!)")
														case .failure(let error):
															print("⛵️fail1: \(error.localizedDescription)")
														}
		}
		
		NetworkManager.requests(Router.history_order(parameters: ["limit": 10, "page": 2],
													 headers: ["Authorization": "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjUzLCJpc3MiOiJodHRwOi8vcGh1Y2xvY3Roby5ob2FudnVzb2x1dGlvbnMuY29tLnZuL2FwaS91c2Vycy9sb2dpbiIsImlhdCI6MTUzNTc5NDIzOSwiZXhwIjoxNTYxNzE0MjM5LCJuYmYiOjE1MzU3OTQyMzksImp0aSI6Imh1OU05RGJhZ2ZhQm9tMDQiLCJpZCI6bnVsbH0.QF7LetAO7ZsuxSySbGLMd-YpTk1lPElW327XO7cpCTw"])) { rs in
														switch rs {
														case .success(let value):
															print("⛵️sucess2: \((value as! DataResponse<Any>).request!.url!)")
														case .failure(let error):
															print("⛵️fail2: \(error.localizedDescription)")
														}
		}
		
		NetworkManager.upload(Router.login(parameters: ["account": #imageLiteral(resourceName: "image"),
														"password": "123456"])) { (rs) in
														
		}
	}
	
	
	@IBAction func cancelAll(_ sender: UIButton) {
		NetworkManager.cancelAllRequest()
	}
	
	@IBAction func cancelOne(_ sender: UIButton) {
		 NetworkManager.cancelRequest(by: "http://phucloctho.hoanvusolutions.com.vn/api/transport/history-order?limit=10&page=1", taskType: NetworkManager.TaskType.dataTask)
	}
	
	
	override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
