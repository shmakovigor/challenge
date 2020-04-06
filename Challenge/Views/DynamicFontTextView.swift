//
//  DynamicFontTextView.swift
//  Challenge
//
//  Created by Igor Shmakov on 05/04/2020.
//  Copyright © 2020 Igor Shmakoff. All rights reserved.
//

import UIKit

class DynamicFontTextView: UITextView {

    @IBInspectable var maxContentHeight: CGFloat = 200
    @IBInspectable var maxFontSize: CGFloat = 48
    @IBInspectable var minFontSize: CGFloat = 24
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let center = NotificationCenter.default
        center.addObserver(self, selector: #selector(textDidChangeNotification),
                           name: UITextView.textDidChangeNotification,
                           object: nil)
        
        textContainer.lineBreakMode = .byTruncatingTail
        textContainerInset = .zero
        tintColor = .black
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    @objc func textDidChangeNotification(_ notification: Notification) {
        
        guard self === notification.object as? UITextView else {
            return
        }
        
        fitTextToBounds()
    }

    
    func bestFittingFontSize() -> CGFloat {
        
        guard let font = font else {
            return maxFontSize
        }
        
        let properBounds = CGRect(origin: .zero, size: CGSize(width: bounds.width, height: maxContentHeight))
        let infiniteBounds = CGSize(width: bounds.width, height: CGFloat.infinity)
        var bestFontSize = minFontSize
        
        for fontSize in stride(from: maxFontSize, through: minFontSize, by: -1) {
            
            let newFont = UIFont(descriptor: font.fontDescriptor, size: fontSize)
        
            let currentFrame = text.boundingRect(
                with: infiniteBounds,
                options: [.usesLineFragmentOrigin, .usesFontLeading],
                attributes: [.font: newFont],
                context: nil
            )
            
            if properBounds.contains(currentFrame) {
                bestFontSize = fontSize
                break
            }
        }
        
        return bestFontSize
    }
    
    func bestFittingFont() -> UIFont {
        
        guard let font = font else {
            return .systemFont(ofSize: minFontSize)
        }
        
        let bestSize = bestFittingFontSize()
        return UIFont(descriptor: font.fontDescriptor, size: bestSize)
    }
    
    func fitTextToBounds() {
        
        font = bestFittingFont()
    }
}
