//
//  UIImageView+Extension.swift
//  BaseSourceCode
//
//  Created by Developer on 8/24/18.
//  Copyright © 2018 Developer. All rights reserved.
//

import UIKit

extension UIImage {
	
	func resized(withPercentage percentage: CGFloat) -> UIImage? {
		let canvasSize = CGSize(width: size.width * percentage, height: size.height * percentage)
		UIGraphicsBeginImageContextWithOptions(canvasSize, false, scale)
		defer { UIGraphicsEndImageContext() }
		draw(in: CGRect(origin: .zero, size: canvasSize))
		return UIGraphicsGetImageFromCurrentImageContext()
	}
	
	
	
	func resized(toWidth width: CGFloat) -> UIImage? {
		let canvasSize = CGSize(width: width, height: CGFloat(ceil(width/size.width * size.height)))
		UIGraphicsBeginImageContextWithOptions(canvasSize, false, scale)
		defer { UIGraphicsEndImageContext() }
		draw(in: CGRect(origin: .zero, size: canvasSize))
		return UIGraphicsGetImageFromCurrentImageContext()
	}
	
	
	
	func getMetaData() {
		guard let data = UIImageJPEGRepresentation(self, 1),
			let source = CGImageSourceCreateWithData(data as CFData, nil) else { return}
		
		if let type = CGImageSourceGetType(source) {
			print("type: \(type)")
		}
		
		if let properties = CGImageSourceCopyProperties(source, nil) {
			print("properties - \(properties)")
		}
		
		let count = CGImageSourceGetCount(source)
		print("count: \(count)")
		
		for index in 0..<count {
			if let metaData = CGImageSourceCopyMetadataAtIndex(source, index, nil) {
				print("all metaData[\(index)]: \(metaData)")
				
				let typeId = CGImageMetadataGetTypeID()
				print("metadata typeId[\(index)]: \(typeId)")
				
				
				if let tags = CGImageMetadataCopyTags(metaData) as? [CGImageMetadataTag] {
					
					print("number of tags - \(tags.count)")
					
					for tag in tags {
						
						let tagType = CGImageMetadataTagGetTypeID()
						print("tagType: \(tagType)")
						if let name = CGImageMetadataTagCopyName(tag) {
							print("name: \(name)")
						}
						if let value = CGImageMetadataTagCopyValue(tag) {
							print("value: \(value)")
						}
						if let prefix = CGImageMetadataTagCopyPrefix(tag) {
							print("prefix: \(prefix)")
						}
						if let namespace = CGImageMetadataTagCopyNamespace(tag) {
							print("namespace: \(namespace)")
						}
						if let qualifiers = CGImageMetadataTagCopyQualifiers(tag) {
							print("qualifiers: \(qualifiers)")
						}
						print("-------")
					}
				}
			}
			
			if let properties = CGImageSourceCopyPropertiesAtIndex(source, index, nil) {
				print("properties[\(index)]: \(properties)")
			}
		}
	}
	
	
	
	func resetOrientation() -> UIImage? {
		
		guard imageOrientation != UIImageOrientation.up else {
			//This is default orientation, don't need to do anything
			return self.copy() as? UIImage
		}
		
		guard let cgImage = self.cgImage else {
			//CGImage is not available
			return nil
		}
		
		guard let colorSpace = cgImage.colorSpace, let ctx = CGContext(data: nil, width: Int(size.width), height: Int(size.height), bitsPerComponent: cgImage.bitsPerComponent, bytesPerRow: 0, space: colorSpace, bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue) else {
			return nil //Not able to create CGContext
		}
		
		var transform: CGAffineTransform = CGAffineTransform.identity
		
		switch imageOrientation {
		case .down, .downMirrored:
			transform = transform.translatedBy(x: size.width, y: size.height)
			transform = transform.rotated(by: CGFloat.pi)
			break
		case .left, .leftMirrored:
			transform = transform.translatedBy(x: size.width, y: 0)
			transform = transform.rotated(by: CGFloat.pi / 2.0)
			break
		case .right, .rightMirrored:
			transform = transform.translatedBy(x: 0, y: size.height)
			transform = transform.rotated(by: CGFloat.pi / -2.0)
			break
		case .up, .upMirrored:
			break
		}
		
		//Flip image one more time if needed to, this is to prevent flipped image
		switch imageOrientation {
		case .upMirrored, .downMirrored:
			transform.translatedBy(x: size.width, y: 0)
			transform.scaledBy(x: -1, y: 1)
			break
		case .leftMirrored, .rightMirrored:
			transform.translatedBy(x: size.height, y: 0)
			transform.scaledBy(x: -1, y: 1)
		case .up, .down, .left, .right:
			break
		}
		
		ctx.concatenate(transform)
		
		switch imageOrientation {
		case .left, .leftMirrored, .right, .rightMirrored:
			ctx.draw(self.cgImage!, in: CGRect(x: 0, y: 0, width: size.height, height: size.width))
		default:
			ctx.draw(self.cgImage!, in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
			break
		}
		
		guard let newCGImage = ctx.makeImage() else { return nil }
		return UIImage.init(cgImage: newCGImage, scale: 1, orientation: .up)
	}
	
	
	
	func resetedOrientation() -> UIImage? {
		
		if (imageOrientation == .up) { return self }
		
		var transform = CGAffineTransform.identity
		
		switch imageOrientation {
		case .left, .leftMirrored:
			transform = transform.translatedBy(x: size.width, y: 0.0)
			transform = transform.rotated(by: .pi / 2.0)
		case .right, .rightMirrored:
			transform = transform.translatedBy(x: 0.0, y: size.height)
			transform = transform.rotated(by: -.pi / 2.0)
		case .down, .downMirrored:
			transform = transform.translatedBy(x: size.width, y: size.height)
			transform = transform.rotated(by: .pi)
		default:
			break
		}
		
		switch imageOrientation {
		case .upMirrored, .downMirrored:
			transform = transform.translatedBy(x: size.width, y: 0.0)
			transform = transform.scaledBy(x: -1.0, y: 1.0)
		case .leftMirrored, .rightMirrored:
			transform = transform.translatedBy(x: size.height, y: 0.0)
			transform = transform.scaledBy(x: -1.0, y: 1.0)
		default:
			break
		}
		
		guard let cgImg = cgImage else { return nil }
		
		if let context = CGContext(data: nil,
								   width: Int(size.width), height: Int(size.height),
								   bitsPerComponent: cgImg.bitsPerComponent,
								   bytesPerRow: 0, space: cgImg.colorSpace!,
								   bitmapInfo: cgImg.bitmapInfo.rawValue) {
			
			context.concatenate(transform)
			
			if imageOrientation == .left || imageOrientation == .leftMirrored ||
				imageOrientation == .right || imageOrientation == .rightMirrored {
				context.draw(cgImg, in: CGRect(x: 0.0, y: 0.0, width: size.height, height: size.width))
			} else {
				context.draw(cgImg, in: CGRect(x: 0.0 , y: 0.0, width: size.width, height: size.height))
			}
			
			if let contextImage = context.makeImage() {
				return UIImage(cgImage: contextImage)
			}
			
		}
		
		return nil
	}
	
	
	
	func saveImageToLibrary() {
		UIImageWriteToSavedPhotosAlbum(self, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
	}
	
	@objc func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
		if let error = error {
			print("‼️ \(error.localizedDescription)")
		} else {
			print("✅ save successfully")
		}
	}
}

