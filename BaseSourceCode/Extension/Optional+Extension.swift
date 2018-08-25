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
    
    var defaultIfNil: String {
        guard let strSelf = self else {
            return ""
        }
        return strSelf
    }
}

extension Optional where Wrapped == Int {
    var nilIfZero: Int? {
        guard let strSelf = self else {
            return nil
        }
        return strSelf == 0 ? nil : strSelf
    }
    
    var defaultIfNil: Int {
        guard let strSelf = self else {
            return 0
        }
        return strSelf
    }
}

extension Optional where Wrapped == Double {
    var nilIfZero: Double? {
        guard let strSelf = self else {
            return nil
        }
        return strSelf == 0.0 ? nil : strSelf
    }
    
    var defaultIfNil: Double {
        guard let strSelf = self else {
            return 0.0
        }
        return strSelf
    }
}

extension Optional where Wrapped == Bool {
    var defaultIfNil: Bool {
        guard let strSelf = self else {
            return false
        }
        return strSelf
    }
}
