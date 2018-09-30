//
//  ResponsePostEntity.swift
//  BaseSourceCode
//
//  Created by Developer on 10/1/18.
//  Copyright © 2018 Developer. All rights reserved.
//

import Foundation
import Alamofire

struct ResponsePostEntity: ResponseObjectSerializable, ResponseCollectionSerializable {
	
	var comments: [Post]?
	
	init?(response: HTTPURLResponse, representation: Any) {
		guard
			let representation 	= representation 				as? [String: Any],
			let data 		= representation["comments"]
		else { return nil }
		
		self.comments = Post.collection(from: response, withRepresentation: data)
	}
	
	static func fetchingProvincesList(completion: @escaping (ResponsePostEntity?, BackendError?)->()) {
		NetworkManager.requestsObject(Router.serializingJSONCollections) { (rs: NetworkManager.ResultRequest<DataResponse<ResponsePostEntity>>) in
			switch rs {
			case .success(let value):
				completion(value.result.value, nil)
			case .failure(let error):
				completion(nil, error)
			}
		}
	}
}
