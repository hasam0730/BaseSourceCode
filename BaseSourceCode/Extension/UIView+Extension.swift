//
//  UIView+Extension.swift
//  BaseSourceCode
//
//  Created by Developer on 10/5/18.
//  Copyright © 2018 Developer. All rights reserved.
//

import UIKit

typealias GradientPoint = (x: CGPoint, y: CGPoint)

public enum GradientDirection {
	case leftRight
	case rightLeft
	case topBottom
	case bottomTop
	case topLeftBottomRight
	case bottomRightTopLeft
	case topRightBottomLeft
	case bottomLeftTopRight
	case genkiApp
	
	func draw() -> GradientPoint {
		switch self {
		case .leftRight:
			return (x: CGPoint(x: 0, y: 0.5), y: CGPoint(x: 1, y: 0.5))
		case .rightLeft:
			return (x: CGPoint(x: 1, y: 0.5), y: CGPoint(x: 0, y: 0.5))
		case .topBottom:
			return (x: CGPoint(x: 0.5, y: 0), y: CGPoint(x: 0.5, y: 1))
		case .bottomTop:
			return (x: CGPoint(x: 0.5, y: 1), y: CGPoint(x: 0.5, y: 0))
		case .topLeftBottomRight:
			return (x: CGPoint(x: 0, y: 0), y: CGPoint(x: 1, y: 1))
		case .bottomRightTopLeft:
			return (x: CGPoint(x: 1, y: 1), y: CGPoint(x: 0, y: 0))
		case .topRightBottomLeft:
			return (x: CGPoint(x: 1, y: 0), y: CGPoint(x: 0, y: 1))
		case .bottomLeftTopRight:
			return (x: CGPoint(x: 0, y: 1), y: CGPoint(x: 1, y: 0))
		case .genkiApp:
			return (x: CGPoint(x: 1, y: 0.05), y: CGPoint(x: 0.6, y: 1))
		}
	}
}

@IBDesignable
extension UIView {
	@IBInspectable
	var cornerRadius: CGFloat {
		get {
			return layer.cornerRadius
		}
		set {
			layer.cornerRadius = newValue
		}
	}
	
	@IBInspectable
	var borderColor: UIColor? {
		get {
			if let color = layer.borderColor {
				return UIColor(cgColor: color)
			}
			return nil
		}
		set {
			if let color = newValue {
				layer.borderColor = color.cgColor
			} else {
				layer.borderColor = nil
			}
		}
	}
	
	@IBInspectable
	var borderWidth: CGFloat {
		get {
			return layer.borderWidth
		}
		set {
			layer.borderWidth = newValue
		}
	}
	
	@IBInspectable
	var shadowRadius: CGFloat {
		get {
			return layer.shadowRadius
		}
		set {
			layer.shadowRadius = newValue
		}
	}
	
	@IBInspectable
	var shadowOpacity: Float {
		get {
			return layer.shadowOpacity
		}
		set {
			layer.shadowOpacity = newValue
		}
	}
	
	@IBInspectable
	var shadowOffset: CGSize {
		get {
			return layer.shadowOffset
		}
		set {
			 layer.shadowOffset = newValue
		}
	}
	
	@IBInspectable
	var shadowColor: UIColor? {
		get {
			if let color = layer.shadowColor {
				return UIColor(cgColor: color)
			}
			return nil
		}
		set {
			if let color = newValue {
				layer.shadowColor = color.cgColor
			} else {
				layer.shadowColor = nil
			}
		}
	}
	
	@IBInspectable
	var scale: Bool {
		get {
			return layer.shouldRasterize
		}
		set {
			layer.shouldRasterize = true
		}
	}
	
	public func addGradient(colors: [UIColor], direction: GradientDirection) {
		let cgColorsList = colors.compactMap { return $0.cgColor }
		let gradientLayer = CAGradientLayer()
		gradientLayer.frame = bounds
		gradientLayer.colors = cgColorsList
		gradientLayer.startPoint = direction.draw().x
		gradientLayer.endPoint = direction.draw().y
		
		gradientLayer.cornerRadius = cornerRadius
		
		layer.insertSublayer(gradientLayer, at: 0)
	}
}


class CustomView: UIView {
	
	private var shadowLayer: CAShapeLayer!

	override func layoutSubviews() {
		super.layoutSubviews()
		
//		if shadowLayer == nil {
//			shadowLayer = CAShapeLayer()
//			shadowLayer.path = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius).cgPath
//			shadowLayer.fillColor = backgroundColor?.cgColor
////			shadowLayer.backgroundColor = backgroundColor?.cgColor
//			shadowLayer.shadowColor = shadowColor?.cgColor
//			shadowLayer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius).cgPath
//			shadowLayer.shadowOffset = shadowOffset
//			shadowLayer.shadowOpacity = shadowOpacity
//			shadowLayer.shadowRadius = shadowRadius
//
////			layer.shouldRasterize = true will make the shadow static and cause a shadow for the initial state of the UIView. So I would recommend not 			to use layer.shouldRasterize = true in dynamic layouts like view inside a UITableViewCell.
////			When we rasterizing the layer, It needs to be set to 2.0 for retina displays. Otherwise label text or images on that view will be blurry. 			So we need to add rasterizationScale also.
//			layer.shouldRasterize = scale
//			layer.rasterizationScale = 2
//
//			layer.insertSublayer(shadowLayer, at: 0)
//		}
	}
}
