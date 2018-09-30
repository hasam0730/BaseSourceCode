//
//  Router.swift
//  BaseSourceCode
//
//  Created by Developer on 9/1/18.
//  Copyright © 2018 Developer. All rights reserved.
//

import Foundation
import Alamofire

fileprivate let demoUrl = "http://demo0368329.mockable.io"
fileprivate let demoCollectionUrl = "http://demo3911457.mockable.io/"

fileprivate let timeout = 5.0

enum Router: URLRequestConvertible {
	
	case demo
	case singleJSONSerialization
	case serializingJSONCollections
	
	var environmentBaseURL: String {
		switch self {
		case .demo:
			return demoUrl
		case .singleJSONSerialization, .serializingJSONCollections:
			return demoCollectionUrl
		}
	}
	
	var baseURL: URL {
		guard let base_url = URL(string: environmentBaseURL) else { fatalError("baseURL could not be configured.") }
		return base_url
	}
	
	var method: HTTPMethod {
		switch self {
		case .demo, .singleJSONSerialization, .serializingJSONCollections:
			return .get
		}
	}
	
	var path: String {
		switch self {
		case .demo:
			return "/dataList"
		case .singleJSONSerialization:
			return "/SingleJSONSerialization"
		case .serializingJSONCollections:
			return "/SerializingJSONCollections"
		}
	}
	
	var header: HTTPHeaders {
		let headers = ["Accept": "application/json"]
		switch self {
		case .demo, .singleJSONSerialization, .serializingJSONCollections:
			break
		}
		return headers
	}
	
//	private var parameters: Parameters? {
//		switch self {
//		case .login(let email, let password):
//			return [
//				"email": email,
//				"password": password
//			]
//		case .changePassword(let pass, let newPass, let confirmNewPass):
//			return[
//				"password": pass,
//				"new_password": newPass,
//				"new_password_confirmation": confirmNewPass
//			]
//		}
//	}
	
	// MARK: URLRequestConvertible
	
	func asURLRequest() throws -> URLRequest {

		var urlRequest = URLRequest(url: baseURL.appendingPathComponent(path))
		urlRequest.timeoutInterval = timeout
		urlRequest.httpMethod = method.rawValue
		urlRequest.allHTTPHeaderFields = header

		switch self {
			case .demo, .singleJSONSerialization, .serializingJSONCollections:
				break
		}
		return urlRequest
	}
}


//			var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: false)
//			urlComponents?.queryItems = []
//			for (key, value) in parameters {
//				urlComponents?.queryItems?.append(URLQueryItem(name: key,
//															   value: "\(value)".addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)))
//			}
//			return urlComponents!



// urlRequest = try URLEncoding.queryString.encode(urlRequest, with: parameters)
// => users/login?account=0166770312&password=123456
