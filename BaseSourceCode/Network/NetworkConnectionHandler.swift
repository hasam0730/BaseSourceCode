//
//  NetworkConnectionStatus.swift
//  BaseSourceCode
//
//  Created by Developer on 9/26/18.
//  Copyright © 2018 Developer. All rights reserved.
//

import Foundation
import Alamofire

class NetworkConnectionStatus {
	static let sharedInstance = NetworkConnectionStatus()
	
	private init() {}
	
	let reachabilityManager = Alamofire.NetworkReachabilityManager(host: "www.apple.com")
	
	func startNetworkReachabilityObserver() {
		reachabilityManager?.listener = { status in
			
			switch status {
				
			case .notReachable:
				print("notReachable")
			case .unknown :
				print("It is unknown whether the network is reachable")
			case .reachable(.ethernetOrWiFi):
				print("The network is reachable over the WiFi connection")
			case .reachable(.wwan):
				print("The network is reachable over the WWAN connection")				
			}
		}
		reachabilityManager?.startListening()
	}
}
