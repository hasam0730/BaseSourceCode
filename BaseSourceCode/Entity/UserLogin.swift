//
//  UserLogin.swift
//  MoneyTracker
//
//  Created by Developer on 7/7/18.
//  Copyright © 2018 hieu nguyen. All rights reserved.
//

import Foundation

class UserLogin {
	var username: String?
	var email: String?
	
	init(username: String? = nil, email: String? = nil) {
		self.username 	= username
		self.email 		= email
	}
}
