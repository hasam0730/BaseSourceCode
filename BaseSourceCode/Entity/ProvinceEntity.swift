//
//  ProvinceEntity.swift
//  BaseSourceCode
//
//  Created by Developer on 9/26/18.
//  Copyright © 2018 Developer. All rights reserved.
//

import Foundation

struct ProvinceEntity: ResponseObjectSerializable, ResponseCollectionSerializable, CustomStringConvertible  {
	
	let id: Int
	let name, code: String
	let countryName, chauLuc: String

	var description: String {
		return "User: { id: \(id), name: \(name) }"
	}

	init?(response: HTTPURLResponse, representation: Any) {
		guard
			let representation = representation as? [String: Any],
			let id 				= representation["id"] 				as? Int,
			let name 			= representation["name"] 			as? String,
			let code 			= representation["code"] 			as? String,
			let countryName 	= representation["country_name"] 	as? String,
			let chauLuc 		= representation["chau_luc"] 		as? String else { return nil }
		
		self.id 			= id
		self.name 			= name
		self.code 			= code
		self.countryName 	= countryName
		self.chauLuc 		= chauLuc
	}
}
