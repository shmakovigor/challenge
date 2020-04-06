//
//  FontStyleCell.swift
//  Challenge
//
//  Created by Igor Shmakov on 05/04/2020.
//  Copyright © 2020 Igor Shmakoff. All rights reserved.
//

import UIKit

class FontStyleCell: UICollectionViewCell {
    
    @IBOutlet weak var selectionView: UIView!
    @IBOutlet weak var selectionInnerView: UIView!
    @IBOutlet weak var previewLabel: UILabel!
    
    override var isSelected: Bool {
        didSet {
            selectionView.isHidden = !isSelected
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        selectionView.layer.cornerRadius = 8
        selectionView.layer.borderColor = UIColor(white: 0.9, alpha: 1).cgColor
        selectionView.layer.borderWidth = 2
        
        selectionInnerView.layer.cornerRadius = 6
        selectionInnerView.layer.borderColor = UIColor.white.cgColor
        selectionInnerView.layer.borderWidth = 2
        
        layer.cornerRadius = 8
    }
}
