//
//  TestUserdefaulViewController.swift
//  BaseSourceCode
//
//  Created by Developer on 9/1/18.
//  Copyright © 2018 Developer. All rights reserved.
//

import UIKit

class TestUserdefaulViewController: UIViewController, Alertable {

	@IBAction func showAction(_ sender: UIButton) {
		let defaults = UserDefaults.standard
		let age = defaults.integer(forKey: "Age")
		showALert("\(age)")
	}
	
	@IBAction func setAction(_ sender: UIButton) {
		let defaults = UserDefaults.standard
		defaults.set(25, forKey: "Age")
	}
	
	@IBAction func clearAllAction(_ sender: UIButton) {
		let appDomain: String? = Bundle.main.bundleIdentifier
		UserDefaults.standard.removePersistentDomain(forName: appDomain!)
	}
	
	override func viewDidLoad() {
        super.viewDidLoad()

		
    }
}
