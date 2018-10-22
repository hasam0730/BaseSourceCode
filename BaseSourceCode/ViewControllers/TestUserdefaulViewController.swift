//
//  TestUserdefaulViewController.swift
//  BaseSourceCode
//
//  Created by Developer on 9/1/18.
//  Copyright © 2018 Developer. All rights reserved.
//

import UIKit

class TestUserdefaulViewController: ViewController, Alertable {

	@IBAction func showAction(_ sender: UIButton) {
		showALert("", UserHolder.name)
	}
	
	@IBAction func setAction(_ sender: UIButton) {
		UserHolder.name = "hieu"
	}
	
	@IBAction func clearAllAction(_ sender: UIButton) {
		UserHolder.deleteAllData()
	}
	
	override func viewDidLoad() {
        super.viewDidLoad()

		
    }
}
