//
//  UIView.swift
//  Challenge
//
//  Created by Igor Shmakov on 08/04/2020.
//  Copyright © 2020 Igor Shmakoff. All rights reserved.
//

import UIKit

extension UIView {
    
    func hide(beginTime: Double = 0.0, scale: CGFloat? = nil, to: CGFloat? = nil, duration: CFTimeInterval) {
        
        delay(beginTime) {
        
            self.animateOpacity(to: 0, duration: duration)
            
            if let to = to {
                self.animateY(to: to, duration: duration)
            }
            
            if let scale = scale {
                self.animateScale(to: scale, duration: duration)
            }
        }
    }
    
    func show(beginTime: Double = 0.0, scale: CGFloat? = nil, from: CGFloat? = nil, duration: CFTimeInterval) {
        
        delay(beginTime) {
            
            self.animateOpacity(to: 1, duration: duration)
            
            if let from = from {
                self.animateY(from: from, duration: duration)
            }
            
            if let scale = scale {
                self.animateScale(from: scale, duration: duration)
            }
        }
    }
    
    func setOpacity(value: Float) {
        
        layer.opacity = value
    }
    
    func animateOpacity(to: Float, duration: CFTimeInterval, completion: (()->())? = nil) {
        
        CATransaction.begin()
        CATransaction.setCompletionBlock(completion)
        
        setOpacity(value: to)
        
        let animation = CABasicAnimation(keyPath: "opacity")
        animation.duration = duration
        animation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        
        layer.add(animation, forKey: nil)
        
        CATransaction.commit()
    }
    
    func animateY(from: CGFloat, duration: CFTimeInterval) {
            
        let animation = CABasicAnimation(keyPath: "position.y")
        animation.duration = duration
        animation.fromValue = layer.position.y + from
        animation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        
        layer.add(animation, forKey: nil)
    }
    
    func animateY(to: CGFloat, duration: CFTimeInterval) {
            
        let animation = CABasicAnimation(keyPath: "position.y")
        animation.duration = duration
        animation.toValue = layer.position.y + to
        animation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        
        layer.add(animation, forKey: nil)
    }
    
    func animateScale(to: CGFloat, duration: CFTimeInterval, completion: (()->())? = nil) {
        
        let animation = CABasicAnimation(keyPath: "transform.scale")
        animation.duration = duration
        animation.toValue = to
        animation.timingFunction = CAMediaTimingFunction(name: .linear)
        
        layer.add(animation, forKey: nil)
    }
    
    func animateScale(from: CGFloat, duration: CFTimeInterval, completion: (()->())? = nil) {
        
        let animation = CABasicAnimation(keyPath: "transform.scale")
        animation.duration = duration
        animation.fromValue = from
        animation.timingFunction = CAMediaTimingFunction(name: .linear)
        
        layer.add(animation, forKey: nil)
    }
    
    func rotate(beginTime: CFTimeInterval = 0, duration: CFTimeInterval, completion: (()->())? = nil) {
        
        CATransaction.begin()
        CATransaction.setCompletionBlock(completion)
        
        let animation = CABasicAnimation(keyPath: "transform.rotation.z")
        animation.toValue = .pi * 2.0
        animation.duration = duration
        animation.beginTime = CACurrentMediaTime() + beginTime
        animation.timingFunction = .easeInOutCubic
        
        layer.add(animation, forKey: nil)
        
        CATransaction.commit()
    }
}

