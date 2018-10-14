//
//  PostEntity.swift
//  BaseSourceCode
//
//  Created by Developer on 9/29/18.
//  Copyright © 2018 Developer. All rights reserved.
//

import Foundation
import Alamofire

struct Post: ResponseObjectSerializable, ResponseCollectionSerializable {
	var id: Int
	var title: String
	var body: String
	
	init?(response: HTTPURLResponse, representation: Any) {
		guard
			let represent 	= representation 		as? [String: Any],
			let id 			= represent["id"] 		as? Int,
			let title 		= represent["title"] 	as? String,
			let body 		= represent["body"] 	as? String
		else { return nil }
		
		self.id = id
		self.title = title
		self.body = body
		
	}
	
	static func fetchingCollectionData(completion: @escaping([Post]?, BackendError?)->()) {
		NetworkManager.requestCollection(Router.serializingJSONCollections) { (value: NetworkManager.ResultRequest<DataResponse<[Post]>>) in
			switch value {
			case .success(let value):
				completion(value.result.value, nil)
			case .failure(let error):
				completion(nil, error)
			}
		}
	}
}

extension Post {
	func collection(response: HTTPURLResponse, representation: [Any]) -> [ProvinceEntity?] {
		guard let representation = representation as? [[String: Any]] else { return [nil] }
		return representation.map {
			ProvinceEntity(response: response, representation: $0)
		}
	}
}


