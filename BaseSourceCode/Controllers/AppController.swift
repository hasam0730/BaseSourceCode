//
//  AppDelegate+Extension.swift
//  MoneyTracker
//
//  Created by Developer on 7/7/18.
//  Copyright © 2018 hieu nguyen. All rights reserved.
//

import Foundation
import UIKit

final class AppController {
	
	static let shared = AppController()
	var window: UIWindow!
	
	private init() {
		
	}
	
	func show(in window: UIWindow?) {
		guard let uwrWindow = window else { fatalError("Cannot layout app with a nil window.") }
		self.window = uwrWindow
		
		 //self.window.rootViewController = TabBarController()
		let homeVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TheFirstViewController") as! TheFirstViewController
		let navCon = UINavigationController(rootViewController: homeVC)
		self.window.rootViewController = navCon
		
		setupNavigationBar()
		self.window.makeKeyAndVisible()
	}
	
	func shows(in window: UIWindow?) {
//		guard let uwrWindow = window else { fatalError("Cannot layout app with a nil window.") }
//		self.window = uwrWindow
//
//		if !AuthController.shared.isLogin {
//			self.window.rootViewController = AuthenRouter.createModule()
//		} else {
//			let navCon = UINavigationController(rootViewController: HomeRouter.createModule())
//			self.window.rootViewController = navCon
//		}
//
//		self.window.makeKeyAndVisible()
	}
	
	func setupNavigationBar() {
		UINavigationBar.appearance().isTranslucent = false
		UINavigationBar.appearance().alpha = 1.0
		UINavigationBar.appearance().barStyle = UIBarStyle.black
		UINavigationBar.appearance().setBackgroundImage(UIImage(), for: UIBarMetrics.default)
		UINavigationBar.appearance().tintColor = .brown
		UINavigationBar.appearance().barTintColor = UIColor(red: 87/255, green: 69/255, blue: 192/255, alpha: 1.0)
		UINavigationBar.appearance().barStyle = UIBarStyle.blackOpaque
	}
}
