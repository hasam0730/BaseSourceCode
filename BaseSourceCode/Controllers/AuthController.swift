//
//  UserInfo.swift
//  MoneyTracker
//
//  Created by Developer on 7/7/18.
//  Copyright © 2018 hieu nguyen. All rights reserved.
//

import Foundation
import CryptoSwift

final class AuthController {
	
	private let serviceName = "FriendvatarsService"
	
	static let shared = AuthController()
	
	private init() {
		
	}

	var isLogin: Bool {
		return false
	}
	
	private func passwordHash(_ string: String) -> String {
//		let salt = "x4vV8bGgqqmQwgCoyXFQj+(o.nUNQhVP7ND"
//		return "\(string).\(salt)".sha256()
		return string
	}
	
	func signIn(user: UserLogin, password: String) throws {
		let passHash = passwordHash(password)
	
		var acc: String!
		if user.email != nil {
			acc = user.email
		} else {
			acc = user.username
		}
		
		try KeychainPasswordItem(service: serviceName, account: acc).savePassword(passHash)
	}
	
	func getPassword(user: UserLogin) throws -> String {
		var acc: String!
		if user.email != nil {
			acc = user.email
		} else {
			acc = user.username
		}
		
		return try KeychainPasswordItem(service: serviceName, account: acc).readPassword()
	}
	
	func clearPassword(user: UserLogin) throws {
		var acc: String!
		if user.email != nil {
			acc = user.email
		} else {
			acc = user.username
		}
		
		try KeychainPasswordItem(service: serviceName, account: acc).deleteItem()
	}
}
