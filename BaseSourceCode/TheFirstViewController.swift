//
//  View.swift
//  BaseSourceCode
//
//  Created by Developer on 8/12/18.
//  Copyright © 2018 Developer. All rights reserved.
//

import UIKit

class TheFirstViewController: BaseSourceCode.ViewController {
	
	@IBOutlet weak var imageView: UIImageView!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		//
		let value = "10.30"
		print(value.formatDecimalNumber(withDecimalPlace: "2"))
		
		let img = imageView.resizeImage(image: #imageLiteral(resourceName: "image"), with: CGSize(width: 100, height: 50))
		imageView.image = img
		
		checkValidate()
	}
	
	func checkValidate() {
		let result = ValidateHandler.isCorrect(formatter: .phoneNumber, string: "d84237127312")
		switch result {
		case .Success(let mess):
			print(mess)
		case .Failure(let mess):
			print(mess)
		}
		
	}
}
