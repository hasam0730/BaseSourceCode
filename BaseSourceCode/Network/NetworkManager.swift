//
//  NetworkManager.swift
//  BaseSourceCode
//
//  Created by Developer on 9/2/18.
//  Copyright © 2018 Developer. All rights reserved.
//

import Foundation
import Alamofire

typealias AlamofireJSONCompletionHandler = (ResultRequest<Any>)->()

enum NetworkResponseError: Error {
	case authenticationError // = "you need to be authenticated first"
	case badRequest // = "Bad request"
	case outdated // = "the url you requested is outdated"
	case failed // = "request failed"
	case noData // = "response returned with no data to decode"
	case unableToDecode // = "we cound not decode the response"
	case timeout // = "we cound not decode the response"
}

extension NetworkResponseError: LocalizedError {
	var localizedDescription: String {
		get {
			switch self {
			case .authenticationError:
				return "you need to be authenticated first"
			case .badRequest:
				return "Bad request"
			case .outdated:
				return "the url you requested is outdated"
			case .failed:
				return "request failed"
			case .noData:
				return "response returned with no data to decode"
			case .unableToDecode:
				return "we cound not decode the response"
			case .timeout:
				return "request time out"
			}
		}
	}
}

fileprivate enum ResultStatusCode<NetworkResponseError> {
	case success
	case failure(NetworkResponseError)
}

enum ResultRequest<T> {
	case success(T)
	case failure(NetworkResponseError)
}

class NetworkManager {
	
	static func requests(_ router: URLRequestConvertible, completion: @escaping AlamofireJSONCompletionHandler) {
		Alamofire.request(router).responseJSON { response in
			switch response.result {
			case .success(_):
				let rs = self.handleNetworkResponseValidation(response)
				switch rs {
				case .success:
					completion(.success(response))
				case .failure(let error):
					completion(.failure(error))
				}
			case .failure(_):
				completion(.failure(NetworkResponseError.timeout))
			}
		}
	}
	
	private static func handleNetworkResponseValidation(_ dataReponse: DataResponse<Any>?) -> ResultStatusCode<NetworkResponseError> {
		guard let uwrDataResponse = dataReponse, let uwrResponse = uwrDataResponse.response else {
			return .failure(NetworkResponseError.failed)
		}
		
		switch uwrResponse.statusCode {
			case 200...299:
				return .success
			case 401...500:
				return .failure(NetworkResponseError.authenticationError)
			case 501...599:
				return .failure(NetworkResponseError.badRequest)
			case 600:
				return .failure(NetworkResponseError.outdated)
			default:
				return .failure(NetworkResponseError.failed)
		}
	}
	
}
