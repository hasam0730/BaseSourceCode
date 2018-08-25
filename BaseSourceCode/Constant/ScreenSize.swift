//
//  ScreenSize.swift
//  BaseSourceCode
//
//  Created by Developer on 8/24/18.
//  Copyright © 2018 Developer. All rights reserved.
//

import UIKit

struct ScreenSize {
	static let width         = UIScreen.main.bounds.size.width
	static let height        = UIScreen.main.bounds.size.height
	static let maxLength     = max(ScreenSize.width, ScreenSize.height)
	static let minLength     = min(ScreenSize.width, ScreenSize.height)
}
