//
//  FontStyleDataSource.swift
//  Challenge
//
//  Created by Igor Shmakov on 05/04/2020.
//  Copyright © 2020 Igor Shmakoff. All rights reserved.
//

import UIKit

class FontStyleViewDataSource: NSObject, UICollectionViewDelegate, UICollectionViewDataSource {
    
    weak var delegate: FontStyleDelegate?
    weak var collection: UICollectionView?
    
    private var styles = [FontStyle]()
    private var selectedIndex = 0
    
    var selected: FontStyle? {
        return styles[selectedIndex]
    }
    
    init(collection: UICollectionView, delegate: FontStyleDelegate) {

        super.init()
        self.styles = FontStyle.defaultFonts
        self.collection = collection
        self.collection?.delegate = self
        self.collection?.dataSource = self
        self.collection?.selectItem(at: IndexPath(item: selectedIndex, section: 0), animated: false, scrollPosition: .right)
        self.delegate = delegate
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return styles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let identifier = String(describing: FontStyleCell.self)
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! FontStyleCell
        let style = styles[indexPath.item]
        
        cell.previewLabel.font = UIFont(name: style.name, size: 20)
        cell.isActive = selectedIndex == indexPath.item
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let style = styles[indexPath.item]
        
        selectedIndex = indexPath.item
        collection?.reloadData()
        delegate?.fontStyleDidSelect(style: style)
    }
}


protocol FontStyleDelegate: class {
    
    func fontStyleDidSelect(style: FontStyle)
}
