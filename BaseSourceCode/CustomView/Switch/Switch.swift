//
//  PLTSwitch.swift
//  PhucLocTho
//
//  Created by mac mini on 8/14/18.
//  Copyright © 2018 Mac Mini. All rights reserved.
//

import UIKit

@IBDesignable
class Switch: UIControl {
    
    @IBInspectable var bgColorOn: UIColor = UIColor.green
    @IBInspectable var bgColorOff: UIColor = UIColor.gray
    @IBInspectable var paddingHorizontal: CGFloat = 2.0
    @IBInspectable var paddingVertical: CGFloat = 3.0
    @IBInspectable var defaultValue: Bool = false
    
    var didTapPosition: CGPoint = CGPoint(x: 0.0, y: 0.0)
    
    let imgCircle: UIImageView = {
        let img = UIImageView()
        img.backgroundColor = .white
        img.clipsToBounds = true
        return img
    }()
    
    var isOn = false {
        didSet {

        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setUpViews() {
        isOn = defaultValue
        
        imgCircle.frame.size = CGSize(width: self.bounds.height - paddingHorizontal, height: self.bounds.height - paddingVertical)
        imgCircle.layer.cornerRadius = imgCircle.bounds.height/2
        
        if !isOn {
            self.backgroundColor = bgColorOff
            imgCircle.frame.origin.x = paddingHorizontal
        } else {
            self.backgroundColor = bgColorOn
            imgCircle.frame.origin.x = frame.width - imgCircle.bounds.width - paddingHorizontal
        }
        imgCircle.center.y = self.bounds.height/2
        
        isUserInteractionEnabled = true
        
        layer.cornerRadius = self.bounds.height/2
        self.addSubview(imgCircle)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // get touch position
        didTapPosition = touches.first?.location(in: self) ?? CGPoint(x: 0.0, y: 0.0)
        
        // get touched layer
        let layer = self.imgCircle.layer.hitTest(didTapPosition)
        
        if layer == imgCircle.layer {
            return
        } else {
            // handle switch to on state
            if isOn == false && didTapPosition.x > imgCircle.bounds.width {
                UIView.animate(withDuration: 0.3, animations: {
                    self.backgroundColor = self.bgColorOn
                    self.imgCircle.frame.origin.x = self.frame.width - self.imgCircle.bounds.width - self.paddingHorizontal
                }) { _ in
                    self.sendActions(for: .valueChanged)
                }
                isOn = !isOn
            }
			// handle switch to off state
            else if didTapPosition.x < imgCircle.frame.origin.x && isOn == true {
                UIView.animate(withDuration: 0.3, animations: {
                    self.backgroundColor = self.bgColorOff
                    self.imgCircle.frame.origin.x = self.paddingHorizontal
                }) { (_) in
                    self.sendActions(for: .valueChanged)
                }
                isOn = !isOn
            }
            
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        setUpViews()
    }
	
	
	func set(to state: Bool) {
		isOn = state
		
		if isOn != false {
			UIView.animate(withDuration: 0.3, animations: {
				self.backgroundColor = self.bgColorOn
				self.imgCircle.frame.origin.x = self.frame.width - self.imgCircle.bounds.width - self.paddingHorizontal
			}) { _ in
				//                self.sendActions(for: .valueChanged)
			}
		} else {
			UIView.animate(withDuration: 0.3, animations: {
				self.backgroundColor = self.bgColorOff
				self.imgCircle.frame.origin.x = self.paddingHorizontal
			}) { (_) in
				//                self.sendActions(for: .valueChanged)
			}
		}
	}
}
