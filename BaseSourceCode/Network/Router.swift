//
//  Router.swift
//  BaseSourceCode
//
//  Created by Developer on 9/1/18.
//  Copyright © 2018 Developer. All rights reserved.
//

import Foundation
import Alamofire

fileprivate let baseURLString = "http://vinastudy.hoanvusolutions.com.vn/api"
fileprivate let phuoclocthoURLString = "http://phucloctho.hoanvusolutions.com.vn/api"
fileprivate let timeout = 5.0

enum Router: URLRequestConvertible {
	
	case login(parameters: Parameters)
	case list_level(id: Int)
	case history_order(parameters: Parameters, headers: HTTPHeaders)
	case transport(params: Parameters, headers: HTTPHeaders)
	
	var environmentBaseURL: String {
		switch self {
		case .login(_), .list_level(_):
			return baseURLString
		case .history_order(_, _), .transport(_, _):
			return phuoclocthoURLString
		}
	}
	
	var baseURL: URL {
		guard let base_url = URL(string: environmentBaseURL) else { fatalError("baseURL could not be configured.") }
		return base_url
	}
	
	var method: HTTPMethod {
		switch self {
		case .login(_), .transport(_, _):
			return .post
		case .list_level(_), .history_order(_):
			return .get
		}
	}
	
	var path: String {
		switch self {
		case .login(_):
			return "/user/login"
		case.list_level(let id):
			return "/course/list-level/\(id)"
		case .history_order(_):
			return "/transport/history-order"
		case .transport(_, _):
			return "/transport/order"
		}
	}
	
	var header: HTTPHeaders? {
		switch self {
		case .login(_), .list_level(_):
			return nil
		case .history_order(_, let headers), .transport(_, let headers):
			return headers
		}
	}
	
	var components: URLComponents? {
		switch self {
		case .login(_):
			return nil
		case .list_level(_), .history_order(_), .transport(_, _):
			return nil
		}
	}
	
	// MARK: URLRequestConvertible
	
	func asURLRequest() throws -> URLRequest {

		var urlRequest = URLRequest(url: baseURL.appendingPathComponent(path))
		urlRequest.timeoutInterval = timeout
		urlRequest.httpMethod = method.rawValue
		urlRequest.allHTTPHeaderFields = header

		switch self {
			case .login(let parameters), .transport(let parameters, _):
				urlRequest = try URLEncoding.default.encode(urlRequest, with: parameters)
			case .list_level(_):
				break
			case .history_order(let params, _):
				urlRequest = try URLEncoding.queryString.encode(urlRequest, with: params)
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
