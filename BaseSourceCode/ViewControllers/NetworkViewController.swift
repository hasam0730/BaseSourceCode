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
