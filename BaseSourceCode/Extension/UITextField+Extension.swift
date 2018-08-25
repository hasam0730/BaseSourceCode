//
//  UITextField+Extension.swift
//  BaseSourceCode
//
//  Created by Developer on 8/24/18.
//  Copyright © 2018 Developer. All rights reserved.
//

import UIKit

extension UITextField {
	func doubleValue() -> Double {
		guard let valueTextField = self.text,
			let doubleValue = Double(valueTextField) else { return 0.0 }
		return doubleValue
	}
	
	func intValue() -> Int {
		guard let valueTextField = self.text,
			let intValue = Int(valueTextField) else { return 0 }
		return intValue
	}
    
    
}
