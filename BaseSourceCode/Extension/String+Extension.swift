//
//  String+Extension.swift
//  BaseSourceCode
//
//  Created by Developer on 8/12/18.
//  Copyright © 2018 Developer. All rights reserved.
//

import Foundation

extension String {
	
	func formatDecimalNumber(withDecimalPlace: String = "1") -> String? {
		let formatter = NumberFormatter()
		formatter.minimumFractionDigits = 0
		formatter.maximumFractionDigits = 2
		formatter.numberStyle = .decimal
		formatter.locale = Locale(identifier: "vi_VN")
		guard let castedDoubleValue = Double(self) as NSNumber? else { return nil }
		return formatter.string(from: castedDoubleValue)!
	}

	func trim() -> String {
		return self.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
	}
	
	func toDouble() -> Double {
		guard let doubleValue = Double(self) else { return 0.0 }
		return doubleValue
	}
	
	func toInt() -> Int {
		guard let intValue = Int(self) else { return 0 }
		return intValue
	}
	
}
