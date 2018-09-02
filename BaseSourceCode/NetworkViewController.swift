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
//		Alamofire.request(Router.history_order(parameters: ["limit": 10, "page": 1], headers: ["Authorization": "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjUzLCJpc3MiOiJodHRwOi8vcGh1Y2xvY3Roby5ob2FudnVzb2x1dGlvbnMuY29tLnZuL2FwaS91c2Vycy9sb2dpbiIsImlhdCI6MTUzNTc5NDIzOSwiZXhwIjoxNTYxNzE0MjM5LCJuYmYiOjE1MzU3OTQyMzksImp0aSI6Imh1OU05RGJhZ2ZhQm9tMDQiLCJpZCI6bnVsbH0.QF7LetAO7ZsuxSySbGLMd-YpTk1lPElW327XO7cpCTw"])).responseJSON { (response) in
//			print(response.result.value!)
//		}
		
		// test network manager class
//		NetworkManager.request(Router.history_order(parameters: ["limit": 10, "page": 1], headers: ["Authorization": "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjUzLCJpc3MiOiJodHRwOi8vcGh1Y2xvY3Roby5ob2FudnVzb2x1dGlvbnMuY29tLnZuL2FwaS91c2Vycy9sb2dpbiIsImlhdCI6MTUzNTc5NDIzOSwiZXhwIjoxNTYxNzE0MjM5LCJuYmYiOjE1MzU3OTQyMzksImp0aSI6Imh1OU05RGJhZ2ZhQm9tMDQiLCJpZCI6bnVsbH0.QF7LetAO7ZsuxSySbGLMd-YpTk1lPElW327XO7cpCTw"])) { result in

//			if let err = error {
//				print("🏔\(err.localizedDescription)")
//				print("⛱\(err.localizedDescription == NetworkResponseError.timeout.localizedDescription)")
//			} else {
//				print(response!.result.value)
//			}
		
		
		NetworkManager.requests(Router.history_order(parameters: ["limit": 10, "page": 1],
													 headers: ["Authorization": "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjUzLCJpc3MiOiJodHRwOi8vcGh1Y2xvY3Roby5ob2FudnVzb2x1dGlvbnMuY29tLnZuL2FwaS91c2Vycy9sb2dpbiIsImlhdCI6MTUzNTc5NDIzOSwiZXhwIjoxNTYxNzE0MjM5LCJuYmYiOjE1MzU3OTQyMzksImp0aSI6Imh1OU05RGJhZ2ZhQm9tMDQiLCpZCI6bnVsbH0.QF7LetAO7ZsuxSySbGLMd-YpTk1lPElW327XO7cpCTw"])) { rs in
														switch rs {
														case .success(let value):
															print(value)
														case .failure(let error):
															print(error.localizedDescription == NetworkResponseError.timeout.localizedDescription)
														}
		}

	}
	
	override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
