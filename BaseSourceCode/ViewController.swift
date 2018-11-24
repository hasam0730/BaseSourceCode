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
		
		navigationItem.backBarButtonItem = UIBarButtonItem(title: navigationBarBackItemTitle, style: .plain, target: nil, action: nil)
		navigationController?.navigationBar.backIndicatorImage = navigationBarBackIcon
		navigationController?.navigationBar.backIndicatorTransitionMaskImage = navigationBarBackIcon
		navigationController?.navigationBar.tintColor = navigationBartintColor
		
//		let backItem: UIBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "btn_back").withRenderingMode(.alwaysTemplate),
//														style: .plain,
//														target: self,
//														action: #selector(didTapBackNavItem))
//		navigationItem.leftBarButtonItem = backItem
	}
	
	
	@objc func didTapBackNavItem() {
		navigationController?.popViewController(animated: true)
	}
	
	var navigationBarBackItemTitle: String {
		return ""
	}
	
	var navigationBartintColor: UIColor {
		return UIColor.green
	}
	
	var navigationBarBackIcon: UIImage {
		return UIImage(named: "btn_back")!
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

