//
//  GenericStruct.swift
//  BaseSourceCode
//
//  Created by Developer on 10/23/18.
//  Copyright © 2018 Developer. All rights reserved.
//

import Foundation

protocol GenericStruct {
	associatedtype T
	var property: T { get set }
}

extension GenericStruct {
	func dosomething() {
		print("☣️")
	}
}


class SomeClass: GenericStruct {
	var property: Int = 10
}

struct SomeStruct: GenericStruct {
	var property: String = "struct name"
}

