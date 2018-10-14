//
//  UIViewController+Extension.swift
//  BaseSourceCode
//
//  Created by Developer on 10/7/18.
//  Copyright © 2018 Developer. All rights reserved.
//

import UIKit

extension UIViewController {
	
	// MARK: IS SWIPABLE - FUNCTION
	func isSwipable() {
		let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(_:)))
		self.view.addGestureRecognizer(panGestureRecognizer)
	}
	
	// MARK: HANDLE PAN GESTURE - FUNCTION
	@objc func handlePanGesture(_ panGesture: UIPanGestureRecognizer) {
		let translation = panGesture.translation(in: view)
		let minX = view.frame.height * 0.135
		var originalPosition = CGPoint.zero
		
		if panGesture.state == .began {
			originalPosition = view.center
		} else if panGesture.state == .changed {
			view.frame.origin = CGPoint(x: 0.0, y: translation.y)
			
			if panGesture.location(in: view).y > minX {
				view.frame.origin = originalPosition
			}
			
			if view.frame.origin.y <= 0.0 {
				view.frame.origin.y = 0.0
			}
		} else if panGesture.state == .ended {
			if view.frame.origin.y >= view.frame.height * 0.5 {
				UIView.animate(withDuration: 0.2
					, animations: {
						self.view.frame.origin = CGPoint(x: self.view.frame.origin.x, y: self.view.frame.size.height)
				}, completion: { (isCompleted) in
					if isCompleted {
						self.dismiss(animated: false, completion: nil)
					}
				})
			} else {
				UIView.animate(withDuration: 0.2, animations: {
					self.view.frame.origin = originalPosition
				})
			}
		}
	}
	
}
