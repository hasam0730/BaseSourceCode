//
//  Alertable+Extension.swift
//  BaseSourceCode
//
//  Created by Developer on 9/1/18.
//  Copyright © 2018 Developer. All rights reserved.
//

import UIKit

protocol Alertable {}

extension Alertable where Self: UIViewController {
	func showALert(_ msg: String) {
		let alertController = UIAlertController(title: "Error:", message: msg, preferredStyle: .alert)
		let action = UIAlertAction(title: "OK", style: .default, handler: nil)
		alertController.addAction(action)
		self.present(alertController, animated: true, completion: nil)
	}
}
