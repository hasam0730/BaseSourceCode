//
//  TappableLabel.swift
//  BaseSourceCode
//
//  Created by mac mini on 9/13/18.
//  Copyright © 2018 Developer. All rights reserved.
//

import UIKit

final class TappableLabel: UILabel {
    
    private struct Const {
        static let DetectableAttributeName = "DetectableAttributeName"
    }
    
    var detectableText: String?
    var displayableContentText: String?
    
    var mainTextAttributes:[NSAttributedStringKey : AnyObject] = [:]
    var tappableTextAttributes:[NSAttributedStringKey : AnyObject] = [:]
    
    var didDetectTapOnText:((_:String, NSRange) -> ())?
    
    private var tapGesture:UITapGestureRecognizer?
    
    // MARK: - Public
    
    func performPreparation() {
        DispatchQueue.main.async {
            self.prepareDetection()
        }
    }
    
    // MARK: - Private
    
    private func prepareDetection() {
        
        guard let searchableString = self.displayableContentText else { return }
        let attributtedString = NSMutableAttributedString(string: searchableString, attributes: mainTextAttributes)
        
        if let detectionText = detectableText {
            
            var attributesForDetection:[NSAttributedStringKey : AnyObject] = [
                NSAttributedStringKey(rawValue: Const.DetectableAttributeName) : "UserAction" as AnyObject
            ]
            tappableTextAttributes.forEach {
                attributesForDetection.updateValue($1, forKey: $0)
            }
            
            for (_ ,range) in searchableString.rangesOfPattern(patternString: detectionText).enumerated() {
                let tappableRange = searchableString.nsRange(from: range)
                attributtedString.addAttributes(attributesForDetection, range: tappableRange!)
            }
            
            if self.tapGesture == nil {
                setupTouch()
            }
        }
        
        text = nil
        attributedText = attributtedString
    }
    
    private func setupTouch() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(TappableLabel.detectTouch(_:)))
        addGestureRecognizer(tapGesture)
        self.tapGesture = tapGesture
    }
    
    @objc private func detectTouch(_ gesture: UITapGestureRecognizer) {
        guard let attributedText = attributedText, gesture.state == .ended else {
            return
        }
        
        let textContainer = NSTextContainer(size: bounds.size)
        textContainer.lineFragmentPadding = 0.0
        textContainer.lineBreakMode = lineBreakMode
        textContainer.maximumNumberOfLines = numberOfLines
        
        let layoutManager = NSLayoutManager()
        layoutManager.addTextContainer(textContainer)
        
        let textStorage = NSTextStorage(attributedString: attributedText)
        textStorage.addAttribute(NSAttributedStringKey.font, value: font, range: NSMakeRange(0, attributedText.length))
        textStorage.addLayoutManager(layoutManager)
        
        let locationOfTouchInLabel = gesture.location(in: gesture.view)
        
        let textBoundingBox = layoutManager.usedRect(for: textContainer)
        var alignmentOffset: CGFloat!
        switch textAlignment {
        case .left, .natural, .justified:
            alignmentOffset = 0.0
        case .center:
            alignmentOffset = 0.5
        case .right:
            alignmentOffset = 1.0
        }
        let xOffset = ((bounds.size.width - textBoundingBox.size.width) * alignmentOffset) - textBoundingBox.origin.x
        let yOffset = ((bounds.size.height - textBoundingBox.size.height) * alignmentOffset) - textBoundingBox.origin.y
        let locationOfTouchInTextContainer = CGPoint(x: locationOfTouchInLabel.x - xOffset, y: locationOfTouchInLabel.y - yOffset)
        
        let characterIndex = layoutManager.characterIndex(for: locationOfTouchInTextContainer, in: textContainer, fractionOfDistanceBetweenInsertionPoints: nil)
        
        if characterIndex < textStorage.length {
            let tapRange = NSRange(location: characterIndex, length: 1)
            let substring = (self.attributedText?.string as? NSString)?.substring(with: tapRange)
            
            let attributeName = Const.DetectableAttributeName
            let attributeValue = self.attributedText?.attribute(NSAttributedStringKey(rawValue: attributeName), at: characterIndex, effectiveRange: nil) as? String
            if let _ = attributeValue,
                let substring = substring {
                DispatchQueue.main.async {
                    self.didDetectTapOnText?(substring, tapRange)
                }
            }
        }
    }
}
