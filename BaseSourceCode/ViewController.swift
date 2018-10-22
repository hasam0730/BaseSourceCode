//
//  ViewController.swift
//  BaseSourceCode
//
//  Created by Developer on 8/12/18.
//  Copyright © 2018 Developer. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

	override func viewDidLoad() {
		super.viewDidLoad()
		
		navigationItem.backBarButtonItem = UIBarButtonItem(title: "quay ve", style: .plain, target: nil, action: nil)
		navigationController?.navigationBar.backIndicatorImage = UIImage(named: "ico_down")
		navigationController?.navigationBar.backIndicatorTransitionMaskImage = UIImage(named: "ico_down")
	}
	
	
	
	@objc
	func backButtonTapped() {
		_ = navigationController?.popToRootViewController(animated: true)
	}

//	@objc
//	func backButtonTapped() {
//		self.navigationController?.popViewController(animated: true)
//	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}

	

}

