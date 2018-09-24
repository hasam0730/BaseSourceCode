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
		// formatter.locale = Locale.current //(identifier: "de_DE")
		guard let castedDoubleValue = Double(self) as NSNumber? else { return nil }
		return formatter.string(from: castedDoubleValue)!
	}
    
    func convertStringToDate(format: String = "yyyy-MM-dd HH:mm:ss") -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format //Your date format
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT+7:00") //Current time zone
        let date = dateFormatter.date(from: self) //according to date format your date string
        return date
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
    
    var html2AttributedString: NSAttributedString? {
        do {
            return try NSAttributedString(data: Data(utf8),
                                          options: [.documentType: NSAttributedString.DocumentType.html,
                                                    .characterEncoding: String.Encoding.utf8.rawValue],
                                          documentAttributes: nil)
        } catch {
            print("error: ", error)
            return nil
        }
    }

    var html2String: String {
        return html2AttributedString?.string ?? ""
    }
    
    
    // MARK: - String+RangeDetection
    
    func rangesOfPattern(patternString: String) -> [Range<Index>] {
        var ranges : [Range<Index>] = []
        
        let patternCharactersCount = patternString.count
        let strCharactersCount = self.count
        if  strCharactersCount >= patternCharactersCount {
            
            for i in 0...(strCharactersCount - patternCharactersCount) {
                let from:Index = self.index(self.startIndex, offsetBy:i)
                if let to:Index = self.index(from, offsetBy:patternCharactersCount, limitedBy: self.endIndex) {
                    
                    if patternString == self[from..<to] {
                        ranges.append(from..<to)
                    }
                }
            }
        }
        
        return ranges
    }
    
    func nsRange(from range: Range<String.Index>) -> NSRange? {
        let utf16view = self.utf16
        if let from = range.lowerBound.samePosition(in: utf16view),
            let to = range.upperBound.samePosition(in: utf16view) {
            return NSMakeRange(utf16view.distance(from: utf16view.startIndex, to: from),
                               utf16view.distance(from: from, to: to))
        }
        return nil
    }
    
    func range(from nsRange: NSRange) -> Range<String.Index>? {
        guard
            let from16 = utf16.index(utf16.startIndex, offsetBy: nsRange.location, limitedBy: utf16.endIndex),
            let to16 = utf16.index(from16, offsetBy: nsRange.length, limitedBy: utf16.endIndex),
            let from = String.Index(from16, within: self),
            let to = String.Index(to16, within: self)
            else { return nil }
        return from ..< to
    }
}
