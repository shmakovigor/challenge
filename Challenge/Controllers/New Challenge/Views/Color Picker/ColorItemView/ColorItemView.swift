//
//  ColorItemView.swift
//  Challenge
//
//  Created by Igor Shmakov on 05/04/2020.
//  Copyright © 2020 Igor Shmakoff. All rights reserved.
//

import UIKit

final class ColorItemView: UIView, NibInstantinable {

    @IBOutlet weak var selectionView: UIView!
    @IBOutlet weak var selectionInnerView: UIView!
    @IBOutlet weak var checkmarkView: UIImageView!
    
    var onSelect: (()->())?
    
    var isActive: Bool = false {
        didSet {
            selectionView.isHidden = !isActive
            checkmarkView.isHidden = !isActive
        }
    }
    
    func with(color: UIColor) -> ColorItemView {
        
        self.backgroundColor = color
        return self
    }
    
    @IBAction func didSelect(_ sender: UIButton) {
       
        onSelect?()
        isActive = true
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    
        selectionView.layer.cornerRadius = selectionView.bounds.width / 2
        selectionView.layer.borderColor = UIColor(white: 0.9, alpha: 1).cgColor
        selectionView.layer.borderWidth = 2
        
        selectionInnerView.layer.cornerRadius = selectionInnerView.bounds.width / 2
        selectionInnerView.layer.borderColor = UIColor.white.cgColor
        selectionInnerView.layer.borderWidth = 2
        
        layer.cornerRadius = bounds.width / 2
    }
}
