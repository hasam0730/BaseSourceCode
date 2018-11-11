//
//  GradientView.swift
//  BaseSourceCode
//
//  Created by Developer on 11/11/18.
//  Copyright © 2018 Developer. All rights reserved.
//

import UIKit

@IBDesignable
class GradientView: UIView {

    @IBInspectable
	var startColor: UIColor = .black {
		didSet {
			updateColors()
		}
	}
	
    @IBInspectable
	var endColor: UIColor = .white {
		didSet {
			updateColors()
		}
	}
	
	
    @IBInspectable var startLocation: Double =   0.05 {
		didSet {
			updateLocations()
		}
	}
	
    @IBInspectable var endLocation:   Double =   0.95 {
		didSet {
			updateLocations()
		}
	}
	
    @IBInspectable var horizontalMode:  Bool =  false {
		didSet {
			updatePoints()
		}
	}
	
	
    @IBInspectable var diagonalMode:    Bool =  false { didSet { updatePoints() }}

    override class var layerClass: AnyClass { return CAGradientLayer.self }

    var gradientLayer: CAGradientLayer { return layer as! CAGradientLayer }

    func updatePoints() {
        if horizontalMode {
            gradientLayer.startPoint = diagonalMode ? CGPoint(x: 1, y: 0) : CGPoint(x: 0, y: 0.5)
            gradientLayer.endPoint   = diagonalMode ? CGPoint(x: 0, y: 1) : CGPoint(x: 1, y: 0.5)
        } else {
            gradientLayer.startPoint = diagonalMode ? CGPoint(x: 0, y: 0) : CGPoint(x: 0.5, y: 0)
            gradientLayer.endPoint   = diagonalMode ? CGPoint(x: 1, y: 1) : CGPoint(x: 0.5, y: 1)
        }
    }
    func updateLocations() {
        gradientLayer.locations = [startLocation as NSNumber, endLocation as NSNumber]
    }
    func updateColors() {
        gradientLayer.colors    = [startColor.cgColor, endColor.cgColor]
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        updatePoints()
        updateLocations()
        updateColors()
    }
}


//
//typealias GradientPoint = (x: CGPoint, y: CGPoint)
//
//public enum GradientDirection {
//	case leftRight
//	case rightLeft
//	case topBottom
//	case bottomTop
//	case topLeftBottomRight
//	case bottomRightTopLeft
//	case topRightBottomLeft
//	case bottomLeftTopRight
//	case genkiApp
//
//	func draw() -> GradientPoint {
//		switch self {
//		case .leftRight:
//			return (x: CGPoint(x: 0, y: 0.5), y: CGPoint(x: 1, y: 0.5))
//		case .rightLeft:
//			return (x: CGPoint(x: 1, y: 0.5), y: CGPoint(x: 0, y: 0.5))
//		case .topBottom:
//			return (x: CGPoint(x: 0.5, y: 0), y: CGPoint(x: 0.5, y: 1))
//		case .bottomTop:
//			return (x: CGPoint(x: 0.5, y: 1), y: CGPoint(x: 0.5, y: 0))
//		case .topLeftBottomRight:
//			return (x: CGPoint(x: 0, y: 0), y: CGPoint(x: 1, y: 1))
//		case .bottomRightTopLeft:
//			return (x: CGPoint(x: 1, y: 1), y: CGPoint(x: 0, y: 0))
//		case .topRightBottomLeft:
//			return (x: CGPoint(x: 1, y: 0), y: CGPoint(x: 0, y: 1))
//		case .bottomLeftTopRight:
//			return (x: CGPoint(x: 0, y: 1), y: CGPoint(x: 1, y: 0))
//		case .genkiApp:
//			return (x: CGPoint(x: 1, y: 0.05), y: CGPoint(x: 0.6, y: 1))
//		}
//	}
//}
