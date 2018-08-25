//
//  Optional+Extension.swift
//  BaseSourceCode
//
//  Created by Developer on 8/24/18.
//  Copyright © 2018 Developer. All rights reserved.
//

import Foundation

extension Optional where Wrapped == String {
	var nilIfEmpty: String? {
		guard let strSelf = self else {
			return nil
		}
		return strSelf.isEmpty ? nil : strSelf
	}
}
