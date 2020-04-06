//
//  BackgroundDataSource.swift
//  Challenge
//
//  Created by Igor Shmakov on 05/04/2020.
//  Copyright © 2020 Igor Shmakoff. All rights reserved.
//

import UIKit

class BackgroundStyleViewDataSource: NSObject, UICollectionViewDelegate, UICollectionViewDataSource {
    
    weak var delegate: BackgroundStyleDelegate?
    weak var collection: UICollectionView?
    
    private var styles = [BackgroundStyle]()
    private var selectedIndex = 0
    
    var selected: BackgroundStyle? {
        return styles[selectedIndex]
    }
    
    init(collection: UICollectionView, defaultStyle: ColorStyle, delegate: BackgroundStyleDelegate) {
        
        super.init()
        self.styles = BackgroundStyle.backgroundsWithDefault(style: defaultStyle)
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
        
        let identifier = String(describing: BackgroundStyleCell.self)
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! BackgroundStyleCell
        let style = styles[indexPath.item]
        
        cell.previewImageView.image = style.image
        cell.checkmarkView.tintColor = style.type == .color ? style.color?.foreground : .white
        cell.contentView.backgroundColor = style.color?.background
        cell.proBadge.isHidden = style.availability == .free
        cell.isActive = selectedIndex == indexPath.item
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let style = styles[indexPath.item]
        
        if style.availability == .free {
            selectedIndex = indexPath.item
            collection?.reloadData()
            delegate?.backgroundStyleDidSelect(style: style)
        } else {
            delegate?.backgroundStyleGetPro()
        }
    }

    func update(defaultStyle: ColorStyle) {
        
        styles = BackgroundStyle.backgroundsWithDefault(style: defaultStyle)
        collection?.reloadData()
    }
}


protocol BackgroundStyleDelegate: class {

    func backgroundStyleDidSelect(style: BackgroundStyle)

    func backgroundStyleGetPro()
}
