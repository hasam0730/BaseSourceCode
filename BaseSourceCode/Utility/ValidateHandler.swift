 //
//  ValidateController.swift
//  MoneyTracker
//
//  Created by Developer on 7/8/18.
//  Copyright © 2018 hieu nguyen. All rights reserved.
//

import Foundation

public enum Validation<L,R> {
	
	case Failure(L)
	case Success(R)
	
	/// Returns the value of `Success` if it exists otherwise nil.
	fileprivate var success : R? {
		switch self {
		case .Success(let r): return r
		default: return nil
		}
	}
	
	/// Returns the value of `Failure` if it exists otherwise nil.
	fileprivate var failure : L? {
		switch self {
		case .Failure(let l): return l
		default: return nil
		}
	}
}


extension Validation /*: Functor*/ {
	public typealias A = R
	public typealias B = Any
	public typealias FB = Validation<L,B>
	
	private func fmap<B>(_ f : @escaping (A) -> B) -> Validation<L,B> {
		switch self {
		case .Failure(let a):
			return Validation<L,B>.Failure(a)
		case .Success(let b):
			return Validation<L,B>.Success(f(b))
		}
	}
	
	public var messages: [String] {
		switch self {
		case .Failure(let mess):
			return mess as! [String]
		case .Success(let mess):
			return [mess] as! [String]
		}
	}
	
	public var isValid: Bool {
		switch self {
		case .Failure:
			return false
		case .Success:
			return true
		}
	}
}

extension Validation where L:Concatable/*: Semigroup*/ {
	
	typealias FA = Validation<L,A>
	
	fileprivate func sconcat(_ other : FA) -> FA {
		switch self {
		case .Success( _):
			return other
		case .Failure(let error):
			switch other {
			case .Success( _):
				return self
			case .Failure(let otherError):
				return Validation<L,A>.Failure(error.concat(otherError))
			}
		}
	}
}

protocol Concatable {
	func concat(_ other : Self) -> Self
}

extension String: Concatable {
	func concat(_ other: String) -> String {
		return self + other
	}
}

extension Array: Concatable {
	func concat(_ other: Array<Element>) -> Array<Element> {
		return self + other
	}
}

struct ValidateHandler {
	
	enum Formatter {
		case email
		case phoneNumber
	}
	
	static func isPasswordLongEnough(_ password: String) -> Validation<[String], String> {
		if password.count < 8 {
			return Validation.Failure(["Password must have more than 8 characters."])
		} else {
			return Validation.Success(password)
		}
	}
	
	static func isPasswordStrongEnough(_ password:String) -> Validation<[String], String> {
		if (password.range(of:"[\\W]", options: .regularExpression) != nil){
			return Validation.Success(password)
		} else {
			return Validation.Failure(["Password must contain a special character."])
		}
	}
	
	static func isDifferentUserPass(_ user:String, _ password:String) -> Validation<[String], String> {
		if (user == password){
			return Validation.Failure(["Username and password MUST be different."])
		} else {
			return Validation.Success(password)
		}
	}
	
	static func isFormatEmail(email: String) -> Validation<[String], String> {
		let regex = try! NSRegularExpression(pattern: "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$", options: .caseInsensitive)
		let rs = regex.firstMatch(in: email, options: [], range: NSRange(location: 0, length: email.count)) != nil
		if rs == true {
			return Validation.Success(email)
		} else {
			return Validation.Failure(["Incorrect email format"])
		}
	}
	
	static func isFormatPhoneNumber(phoneNumb: String) -> Validation<[String], String> {
//		let PHONE_REGEX = "^((\\+)|(00))[0-9]{6,14}$"
//		let phoneTest = NSPredicate(format: "SELF MATCHES %@", PHONE_REGEX)
//		let result =  phoneTest.evaluate(with: phoneNumb)
		let numberCharacters = NSCharacterSet.decimalDigits.inverted
		let result = !phoneNumb.isEmpty && phoneNumb.rangeOfCharacter(from: numberCharacters) == nil
		if result {
			return Validation.Success(phoneNumb)
		} else {
			return Validation.Failure(["Incorrect phone number format"])
		}
	}
	
	static func isNilUsername(_ user: String) -> Validation<[String], String> {
		if (user.count == 0){
			return Validation.Failure(["Username must not be nil"])
		} else {
			return Validation.Success(user)
		}
	}
	
	static func username(user: String) -> Validation<[String], String> {
		return isNilUsername(user)
	}
	
	static func password(user: String, password:String) -> Validation<[String], String> {
		return 	isPasswordLongEnough(password)
				.sconcat(isPasswordStrongEnough(password))
				.sconcat(isDifferentUserPass(user, password))
	}
	
	static func isCorrect(formatter: Formatter, string: String) -> Validation<[String], String> {
		switch formatter {
		case .email:
			return isFormatEmail(email: string)
		default:
			return isFormatPhoneNumber(phoneNumb: string)
		}
		
	}
}
