//
//  GradientButton.swift
//  Challange
//
//  Created by Igor Shmakov on 05/04/2020.
//  Copyright © 2020 Igor Shmakoff. All rights reserved.
//

import UIKit

class GradientButton: RoundedButton {

    let gradient = CAGradientLayer()
    
    @IBInspectable var first: UIColor = .white {
        didSet {
            gradient.colors = [first.cgColor, second.cgColor]
        }
    }
    
    @IBInspectable var second: UIColor = .black {
        didSet {
            gradient.colors = [first.cgColor, second.cgColor]
        }
    }
    
    override var isEnabled: Bool {
        didSet {
            gradient.isHidden = !isEnabled
            if isEnabled {
                backgroundColor = .clear
                setTitleColor(.white, for: .normal)
            } else {
                backgroundColor = .myGray
                setTitleColor(.lightGray, for: .normal)
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        gradient.locations = [0, 0.85]
        gradient.startPoint = CGPoint(x: 0.5, y: 0.0)
        gradient.endPoint = CGPoint(x: 0.5, y: 1)
        layer.addSublayer(gradient)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        gradient.bounds = bounds
        gradient.position = CGPoint(x: bounds.width / 2, y: bounds.height / 2)
        gradient.zPosition = 0
    }
}
