//
//  FocusedTextField.swift
//  BaseSourceCode
//
//  Created by Developer on 11/24/18.
//  Copyright © 2018 Developer. All rights reserved.
//

import UIKit

@IBDesignable
class FocusTextfield: UITextField {
	
	@IBInspectable var becomeColor: UIColor = .black
	@IBInspectable var resignColor: UIColor = .red
	
	let underLine = CALayer()
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
	}
	
	override func drawPlaceholder(in rect: CGRect) {
		super.drawPlaceholder(in: rect)
	}
	
	override func draw(_ rect: CGRect) {
		super.draw(rect)
		
		autocorrectionType = .no
		if !(self.layer.sublayers?.contains(underLine))! {
			underLine.backgroundColor = resignColor.cgColor
			underLine.frame = CGRect(x: 0, y: self.bounds.height-1, width: self.bounds.width, height: 1)
			self.layer.addSublayer(underLine)
			borderStyle = .none
		}
	}
	
	override func drawText(in rect: CGRect) {
		super.drawText(in: rect)
	}
	
	override func becomeFirstResponder() -> Bool {
		underLine.backgroundColor = becomeColor.cgColor
		super.becomeFirstResponder()
		return true
	}
	
	override func resignFirstResponder() -> Bool {
		underLine.backgroundColor = resignColor.cgColor
		super.resignFirstResponder()
		return true
	}
	
}
