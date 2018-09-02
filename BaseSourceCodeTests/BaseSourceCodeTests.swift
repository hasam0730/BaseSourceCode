//
//  BaseSourceCodeTests.swift
//  BaseSourceCodeTests
//
//  Created by Developer on 8/12/18.
//  Copyright © 2018 Developer. All rights reserved.
//

import XCTest
@testable import BaseSourceCode

class BaseSourceCodeTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
	
	func testToken() {
		let user = UserLogin(username: nil, email: "hasam@gmail.com")
		do {
			let smt = try AuthController.shared.getPassword(user: user)
			XCTAssertEqual(smt, "tokencuahieu")
		} catch let error {
			print("🗿: \(error.localizedDescription)")
		}
	}
	
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
