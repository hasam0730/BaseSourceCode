//
//  UIImageView+Extension.swift
//  BaseSourceCode
//
//  Created by Developer on 8/24/18.
//  Copyright © 2018 Developer. All rights reserved.
//

import UIKit

extension UIImageView {
	
	func resizeImage(image: UIImage, with size: CGSize) -> UIImage {
		let imageSize = image.size
		
		let widthRatio = size.width / image.size.width
		let heightRatio = size.height / image.size.height
		
		// Figure out what our orientation is, and use that to form the rectangle
		var newSize: CGSize
		if(widthRatio > heightRatio) {
			newSize = CGSize.init(width: imageSize.width * heightRatio, height: imageSize.height * heightRatio)
		} else {
			newSize = CGSize.init(width: imageSize.width * widthRatio, height: imageSize.height * widthRatio)
		}
		
		if newSize.width > newSize.height {
			newSize.height = newSize.width
		} else {
			newSize.width = newSize.height
		}
		
		// This is the rect that we've calculated out and this is what is actually used below
		let rect = CGRect.init(x: 0, y: 0, width: newSize.width, height: newSize.height)
		
		// Actually do the resizing to the rect using the ImageContext stuff
		UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
		image.draw(in: rect)
		let newImage = UIGraphicsGetImageFromCurrentImageContext()
		UIGraphicsEndImageContext()
		
		return newImage!
	}
}

