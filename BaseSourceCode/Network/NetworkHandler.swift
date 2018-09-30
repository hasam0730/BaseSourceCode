//
//  NetworkManager.swift
//  BaseSourceCode
//
//  Created by Developer on 9/2/18.
//  Copyright © 2018 Developer. All rights reserved.
//

import Foundation
import Alamofire

typealias AlamofireJSONCompletionHandler = (NetworkManager.ResultRequest<Any>)->()
typealias ViewControllerAndMyprotocol = ResponseCollectionSerializable & ResponseObjectSerializable

class NetworkManager {
	
	enum TaskType {
		case dataTask
		case downloadTask
		case uploadTask
	}
	
	enum ResultRequest<T> {
		case success(T)
		case failure(BackendError)
	}
	
	enum ResultStatusCode<NetworkResponseError> {
		case success
		case failure(BackendError)
	}
	
	//----------------------------------------------------------------------------------------------------------
	
	class func requestsObject<T: ResponseObjectSerializable>(_ router: URLRequestConvertible,
															 completion: @escaping (ResultRequest<DataResponse<T>>)->()) {
		
		guard NetworkConnectionStatus.sharedInstance.reachabilityManager?.isReachable == true else {
			completion(.failure(BackendError.disconnected))
			return
		}
		
		_ = Alamofire.request(router).responseObject { (response: DataResponse<T>) in
			switch response.result {
			case .success(_):
				let rs = self.handleStatusCodeValidationObject(response: response.response)
				switch rs {
				case .success:
					completion(.success(response))
				case .failure(let error): // connect success to server but fail by server
					completion(.failure(error))
				}
			case .failure(let error): // fail because of time out or canceled request
				switch error.code {
				case -999, -1001	: completion(.failure(BackendError.network(error: error)))
				default		: completion(.failure(BackendError.network(error: error)))
				}
			}
		}
	}
	
	class func requestCollection<T: ResponseCollectionSerializable>(_ router: URLRequestConvertible,
																	completionHandler: @escaping (ResultRequest<DataResponse<[T]>>) -> Void) {
		
		guard NetworkConnectionStatus.sharedInstance.reachabilityManager?.isReachable == true else {
			completionHandler(.failure(BackendError.disconnected))
			return
		}
		
		_ = Alamofire.request(router).responseCollection(completionHandler: { (response: DataResponse<[T]>) in
			switch response.result {
			case .success:
				let rs = self.handleStatusCodeValidationObject(response: response.response)
				switch rs {
				case .success:
					completionHandler(.success(response))
				case .failure(let error): // connect success to server but fail by server
					completionHandler(.failure(error))
				}
			case .failure(let error):
				switch error.code {
				case -999, -1001	: completionHandler(.failure(BackendError.network(error: error)))
				default		: completionHandler(.failure(BackendError.network(error: error)))
				}
			}
		})
	}
	
	//----------------------------------------------------------------------------------------------------------
	
	class func cancelAllRequest() {
		Alamofire.SessionManager.default.session.getTasksWithCompletionHandler { (dataTasks, uploadTasks, downloadTasks) in
			dataTasks.forEach { $0.cancel() }
			uploadTasks.forEach { $0.cancel() }
			downloadTasks.forEach { $0.cancel() }
		}
	}
	
	class func cancelRequest(by urlString: String, taskType: TaskType) {
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
	}
}

private extension NetworkManager {
	
	static func handleStatusCodeValidationObject(response: HTTPURLResponse?) -> ResultStatusCode<BackendError> {
		
		guard let uwrReponse = response else { fatalError("response is not allowed to be nil") }
		switch uwrReponse.statusCode {
		case 200...299:
			return .success
		case 401...500:
			return .failure(BackendError.authenticationError(reason: "loi xac thuc"))
		case 501...599:
			return .failure(BackendError.badRequest(reason: "bad request"))
		case 600:
			return .failure(BackendError.outdated(reason: "outdated"))
		default:
			return .failure(BackendError.failed(reason: "fail"))
		}
	}
}
