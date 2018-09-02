//
//  Error+Extension.swift
//  BaseSourceCode
//
//  Created by Developer on 9/2/18.
//  Copyright © 2018 Developer. All rights reserved.
//

import Foundation

extension Error {
	var code: Int {
		get {
			return (self as NSError).code
		}
	}
}
