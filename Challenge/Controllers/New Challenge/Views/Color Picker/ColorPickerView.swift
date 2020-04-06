//
//  ColorPickerView.swift
//  Challenge
//
//  Created by Igor Shmakov on 05/04/2020.
//  Copyright © 2020 Igor Shmakoff. All rights reserved.
//

import UIKit

class ColorPickerView: UIStackView {

    weak var delegate: ColorPickerViewDelegate?
    var selectedDefault: Int? = 0
    
    let defaultColors = ColorStyle.defaultColors
    
    lazy var defaultColorViews: [ColorItemView] = {
        return defaultColors.map { ColorItemView.view.with(color: $0.background) }
    }()
        
    let paletteView = ColorPaletteView(frame: .zero)
    let closePaletteButton = RoundedButton(type: .custom)
    
    var showingPallete = false {
        didSet {
            defaultColorViews.forEach { $0.isHidden = showingPallete }
            paletteView.active = showingPallete
            closePaletteButton.isHidden = !showingPallete
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        spacing = 16
        setup()
    }
    
    func setup() {
        
        closePaletteButton.setImage(#imageLiteral(resourceName: "icClose"), for: .normal)
        closePaletteButton.backgroundColor = .myGray
        closePaletteButton.tintColor = .black
        closePaletteButton.widthAnchor.constraint(equalTo: closePaletteButton.heightAnchor).isActive = true
        closePaletteButton.addTarget(self, action: #selector(ColorPickerView.closePalette), for: .touchUpInside)
        addArrangedSubview(closePaletteButton)
        
        for (index, view) in defaultColorViews.enumerated() {
            
            view.isSelected = index == selectedDefault
            view.onSelect = { self.selectDefault(at: index) }
            addArrangedSubview(view)
        }
        
        paletteView.delegate = self
        addArrangedSubview(paletteView)
        
        showingPallete = false
    }
    
    func selectDefault(at index: Int?) {
        
        if let selected = selectedDefault {
            defaultColorViews[selected].isSelected = false
        }
        
        selectedDefault = index
        
        if let index = index {
            delegate?.colorPickerDidSelect(style: defaultColors[index])
        }
    }
    
    @objc func closePalette() {
        
        UIView.animate(withDuration: 0.2, animations: {
            self.showingPallete = false
        })
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        closePaletteButton.cornerRadius = bounds.height / 2
    }
}


extension ColorPickerView: ColorPaletteDelegate {
    
    func colorPaletteDidActivate(view: ColorPaletteView) {
        
        UIView.animate(withDuration: 0.2, animations: {
            self.showingPallete = true
        })
    }
    
    func colorPalette(view: ColorPaletteView, didChangeColor color: UIColor) {
        
        selectDefault(at: nil)
        delegate?.colorPickerDidSelect(style: ColorStyle(background: color, foreground: .white))
    }
}


protocol ColorPickerViewDelegate: class {
    
    func colorPickerDidSelect(style: ColorStyle)
}
