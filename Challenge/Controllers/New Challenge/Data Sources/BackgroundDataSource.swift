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
    
    var styles = [BackgroundStyle]()
    
    var selected: BackgroundStyle? {
        if let index = collection?.indexPathsForSelectedItems?.first?.item {
            return styles[index]
        } else {
            return nil
        }
    }
    
    init(collection: UICollectionView, defaultStyle: ColorStyle, delegate: BackgroundStyleDelegate) {
        
        super.init()
        self.styles = BackgroundStyle.backgroundsWithDefault(style: defaultStyle)
        self.collection = collection
        self.collection?.delegate = self
        self.collection?.dataSource = self
        self.collection?.selectItem(at: IndexPath(item: 0, section: 0), animated: false, scrollPosition: .right)
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
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let style = styles[indexPath.item]
        delegate?.backgroundStyleDidSelect(style: style)
    }
    
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        
        let style = styles[indexPath.item]
        
        if style.availability == .pro {
            delegate?.backgroundStyleGetPro()
        }
        
        return style.availability == .free
    }
    
    func update(defaultStyle: ColorStyle) {
        
        let index = collection?.indexPathsForSelectedItems?.first
        styles = BackgroundStyle.backgroundsWithDefault(style: defaultStyle)
        collection?.reloadData()
        collection?.selectItem(at: index, animated: true, scrollPosition: .right)
    }
}


protocol BackgroundStyleDelegate: class {

    func backgroundStyleDidSelect(style: BackgroundStyle)

    func backgroundStyleGetPro()
}
