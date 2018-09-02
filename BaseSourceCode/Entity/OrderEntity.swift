//
//  OrderEntity.swift
//  BaseSourceCode
//
//  Created by Developer on 9/2/18.
//  Copyright © 2018 Developer. All rights reserved.
//

import Foundation

struct OrderEntity {
	var id: Int?
	var sender_name: String?
}

extension OrderEntity {
	init(dicData: [String: Any]) {
		self.id = dicData["id"] as? Int
		self.sender_name = dicData["sender_name"] as? String
	}
}
