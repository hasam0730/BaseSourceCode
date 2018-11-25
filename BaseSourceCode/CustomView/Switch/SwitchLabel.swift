//
//  PLTLabelSwitch.swift
//  PhucLocTho
//
//  Created by mac mini on 8/14/18.
//  Copyright © 2018 Mac Mini. All rights reserved.
//

import UIKit

@IBDesignable
class SwitchLabel: Switch {
    
    @IBInspectable var title: String = ""
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        setUpViews()
    }
    
    override func setUpViews() {
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
        
        let label = UILabel(frame: CGRect(x: imgCircle.bounds.width, y: 0, width: self.bounds.width - imgCircle.bounds.width * 2, height: self.bounds.height))
        label.text = title
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = .white
        label.textAlignment = .center
        
        isUserInteractionEnabled = true
        
        layer.cornerRadius = self.bounds.height/2
        self.addSubview(label)
        self.addSubview(imgCircle)
    }
}
