//
//  Int+Extension.swift
//  BaseSourceCode
//
//  Created by Developer on 9/30/18.
//  Copyright © 2018 Developer. All rights reserved.
//

import Foundation

extension Int {
	func formatNumber() -> String? {
		let formatter = NumberFormatter()
		formatter.numberStyle = .decimal
		formatter.groupingSeparator = " "
		
//		formatter.groupingSeparator = Locale.current.groupingSeparator
//		formatter.groupingSeparator = Locale(identifier: "FR_fr").groupingSeparator
		
		return formatter.string(for: self)
	}
}
