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
	func showALert(_ title: String = "Title", _ msg: String) {
		let alertController = UIAlertController(title: title, message: msg, preferredStyle: .alert)
		let action = UIAlertAction(title: "OK", style: .default, handler: nil)
		alertController.addAction(action)
		self.present(alertController, animated: true, completion: nil)
	}
	
	func showLoading() -> UIView {

		let loadingV = view.subviews.first
		if loadingV?.tag == 1 {
			
			return  UIView()
		} else {
			let loadingView = UIView(frame: CGRect(x: 0, y: ScreenSize.height, width: ScreenSize.width, height: 50))
			loadingView.tag = 1
			let label = UILabel(frame: loadingView.frame)
			label.text = "loading..."
			loadingView.backgroundColor = UIColor.black.withAlphaComponent(0.7)
			
			loadingView.addSubview(label)
			
			self.view.insertSubview(loadingView, aboveSubview: view.subviews.last!)
			
			
			UIView.animate(withDuration: 2.0) {
				loadingView.frame.origin.y = loadingView.frame.origin.y - 100
			}
			return loadingView
		}
		
		
	}
	
	func hideLoading( v: inout UIView) {
		if v.tag == 1 {
			v.frame.origin.y = v.frame.origin.y + 100
//			UIView.animate(withDuration: 2.0, animations: {
//
//			}) { isFinish in
//				v.removeFromSuperview()
//			}
			v.removeFromSuperview()
			view.layoutSubviews()
		}
		
	}
}
