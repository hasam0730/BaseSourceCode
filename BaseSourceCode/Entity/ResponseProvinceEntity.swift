//
//  ProvinceEntity.swift
//  BaseSourceCode
//
//  Created by Developer on 9/26/18.
//  Copyright © 2018 Developer. All rights reserved.
//

import Foundation
import Alamofire

struct ResponseProvinceEntity: ResponseObjectSerializable, ResponseCollectionSerializable, CustomStringConvertible {
	
	let code_token: Int
	let datatype: Int
	let status: Int
	let data: [ProvinceEntity]
	let msg: String
	
	init?(response: HTTPURLResponse, representation: Any) {
		guard
			let representation 	= representation 				as? [String: Any],
			let code_token 		= representation["code_token"] 	as? Int,
			let datatype 		= representation["datatype"] 	as? Int,
			let status 			= representation["status"] 		as? Int,
			let data			= representation["data"],
			let msg 			= representation["msg"] 		as? String
		else { return nil }
		
		self.code_token 		= code_token
		self.datatype 			= datatype
		self.status 			= status
		self.data				= ProvinceEntity.collection(from: response, withRepresentation: data)
		self.msg 				= msg
	}
	
	var description: String {
		return "User: { id: \(code_token), name: \(code_token) }"
	}
	
	static func fetchingProvincesList(completion: @escaping (ResponseProvinceEntity?, BackendError?)->()) {
		NetworkManager.requestsObject(Router.demo) { (rs: NetworkManager.ResultRequest<DataResponse<ResponseProvinceEntity>>) in
			switch rs {
			case .success(let value):
				completion(value.result.value, nil)
			case .failure(let error):
				completion(nil, error)
			}
		}
	}
}
