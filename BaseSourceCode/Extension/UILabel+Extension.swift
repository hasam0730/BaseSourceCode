//
//  UILabel+Extension.swift
//  BaseSourceCode
//
//  Created by hasam on 8/25/18.
//  Copyright © 2018 Developer. All rights reserved.
//

import UIKit

extension UILabel {
    func underline() {
        if let textString = self.text {
            let attributedString = NSMutableAttributedString(string: textString)
            attributedString.addAttribute(NSAttributedStringKey.underlineStyle, value: NSUnderlineStyle.styleSingle.rawValue, range: NSRange(location: 0, length: attributedString.length))
            attributedText = attributedString
        }
    }
	
	func addImageWith(name: String, behindText: Bool) {
		
		let attachment = NSTextAttachment()
		attachment.image = UIImage(named: name)
		let attachmentString = NSAttributedString(attachment: attachment)
		
		guard let txt = self.text else {
			return
		}
		
		if behindText {
			let strLabelText = NSMutableAttributedString(string: txt)
			strLabelText.append(attachmentString)
			self.attributedText = strLabelText
		} else {
			let strLabelText = NSAttributedString(string: txt)
			let mutableAttachmentString = NSMutableAttributedString(attributedString: attachmentString)
			mutableAttachmentString.append(strLabelText)
			self.attributedText = mutableAttachmentString
		}
	}
	
	func removeImage() {
		let text = self.text
		self.attributedText = nil
		self.text = text
	}
	
	// usage:
	//	lbl.text = "ksahdfjahsfhsuahfushduif"
	//	lbl.addImageWith(name: "1", behindText: true)
}
