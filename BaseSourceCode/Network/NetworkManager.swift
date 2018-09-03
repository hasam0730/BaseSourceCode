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
	case canceled //
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
			case .canceled:
				return "request bi huy"
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
	
	enum TaskType {
		case dataTask
		case downloadTask
		case uploadTask
	}
	
	static func requests(_ router: URLRequestConvertible, completion: @escaping AlamofireJSONCompletionHandler) {
		
		Alamofire.request(router).responseJSON { response in
			switch response.result {
			case .success(_):
				let rs = self.handleStatusCodeValidation(response)
				switch rs {
				case .success:
					completion(.success(response))
				case .failure(let error): // connect success to server but fail by server
					completion(.failure(error))
				}
			case .failure(let error): // fail because of time out or canceled request
				// print("🚁\(error.localizedDescription): \(error.code)")
				switch error.code {
					case -999	: completion(.failure(NetworkResponseError.canceled))
					case -1001	: completion(.failure(NetworkResponseError.timeout))
					default		: completion(.failure(NetworkResponseError.failed))
				}
			}
		}
	}
	
	static func cancelAllRequest() {
		Alamofire.SessionManager.default.session.getTasksWithCompletionHandler { (dataTasks, uploadTasks, downloadTasks) in
			dataTasks.forEach { $0.cancel() }
			uploadTasks.forEach { $0.cancel() }
			downloadTasks.forEach { $0.cancel() }
		}
	}
	
	static func cancelRequest(by urlString: String, taskType: TaskType) {
		switch taskType {
		case .dataTask:
			Alamofire.SessionManager.default.session.getAllTasks(completionHandler: { sessionTasksList in
				let tasksList = sessionTasksList.filter({ sessionTask -> Bool in
					return sessionTask.originalRequest?.url?.absoluteString == urlString
				})
				tasksList.forEach({
					$0.cancel()
				})
			})
		case .downloadTask:
			Alamofire.SessionManager.default.session.getTasksWithCompletionHandler { _, _, downloadTasks in
				let tasks = downloadTasks.filter({
					return $0.originalRequest?.url?.absoluteString == urlString
				})
				tasks.forEach({
					$0.cancel()
				})
			}
		case .uploadTask:
			Alamofire.SessionManager.default.session.getTasksWithCompletionHandler { _, uploadTasks, _ in
				let tasks = uploadTasks.filter({
					return $0.originalRequest?.url?.absoluteString == urlString
				})
				tasks.forEach({
					$0.cancel()
				})
			}
		}
	}
	
	static func upload(_ params: Parameters,
					   router: URLRequestConvertible,
					   completion: @escaping AlamofireJSONCompletionHandler) {
		
		let request = try! router.asURLRequest()
		
		Alamofire.upload(multipartFormData: { multipartFormData in
			
		}, to: router.urlRequest!.url!,
		   method: HTTPMethod(rawValue: request.httpMethod!)!,
		   headers: request.allHTTPHeaderFields,
		   encodingCompletion: { (result) in
		
			
			
		})
		
		
		
		
//		request(router).responseJSON { response in
//			switch response.result {
//			case .success(_):
//				let rs = self.handleStatusCodeValidation(response)
//				switch rs {
//				case .success:
//					completion(.success(response))
//				case .failure(let error): // connect success to server but fail by server
//					completion(.failure(error))
//				}
//			case .failure(let error): // fail because of time out or canceled request
//				// print("🚁\(error.localizedDescription): \(error.code)")
//				switch error.code {
//				case -999	: completion(.failure(NetworkResponseError.canceled))
//				case -1001	: completion(.failure(NetworkResponseError.timeout))
//				default		: completion(.failure(NetworkResponseError.failed))
//				}
//			}
//		}
	}
}

private extension NetworkManager {
	
	static func handleStatusCodeValidation(_ dataReponse: DataResponse<Any>?) -> ResultStatusCode<NetworkResponseError> {
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
