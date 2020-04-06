//
//  ColorPaletteView.swift
//  Challenge
//
//  Created by Igor Shmakov on 05/04/2020.
//  Copyright © 2020 Igor Shmakoff. All rights reserved.
//

import UIKit

class ColorPaletteView: UIView {
    
    weak var delegate: ColorPaletteDelegate?
    
    let thumbView = UIImageView(image: #imageLiteral(resourceName: "thumb"))
    var thumbPosition: CGFloat = 0.5
    
    var active = false {
        didSet {
            thumbView.isHidden = !active
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setup()
    }
    
    func setup() {
        
        layer.masksToBounds = true
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(ColorPaletteView.tap(gesture:)))
        addGestureRecognizer(tapGesture)
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(ColorPaletteView.moveSelector(gesture:)))
        addGestureRecognizer(panGesture)
        
        addSubview(thumbView)
        thumbView.frame.size = CGSize(width: 35, height: 35)
    }
    
    func makeColors(saturation: CGFloat, brightness: CGFloat) -> [UIColor] {

        var colors: [UIColor] = []
        
        for i in 0..<12 {
    
            let hue: CGFloat = CGFloat(i) / 12.0
            let color = UIColor(hue: hue, saturation: saturation, brightness: brightness, alpha: 1)
            colors.append(color)
        }
        
        return colors
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

        layer.cornerRadius = bounds.height / 2
        thumbView.center = CGPoint(x: bounds.width * thumbPosition, y: bounds.height / 2 + 3)
    }
    
    @objc func tap(gesture: UITapGestureRecognizer) {
        
        if !active {
            active = true
            delegate?.colorPaletteDidActivate(view: self)
        } else {
            let location = gesture.location(in: self)
            moveThumb(location: location)
        }
    }
    
    @objc func moveSelector(gesture: UIPanGestureRecognizer) {
        
        let location = gesture.location(in: self)
        
        switch gesture.state {
        case .began:
            moveThumb(location: location)
        case .changed:
            moveThumb(location: location)
        default:
            break
        }
    }
    
    func moveThumb(location: CGPoint) {
        
        thumbPosition = min(max(0, location.x / bounds.width), 1)
        thumbView.center = CGPoint(x: bounds.width * thumbPosition, y: bounds.height / 2 + 3)
        
        let color = UIColor(hue: thumbPosition, saturation: 1, brightness: 1, alpha: 1)
        delegate?.colorPalette(view: self, didChangeColor: color)
    }
    
    override func draw(_ rect: CGRect) {
        
        let context = UIGraphicsGetCurrentContext()!
        let colors = makeColors(saturation: 1, brightness: 1).map { $0.cgColor }

        let colorSpace = CGColorSpaceCreateDeviceRGB()

        let gradient = CGGradient(colorsSpace: colorSpace,
                                  colors: colors as CFArray,
                                  locations: nil)!

        let startPoint = CGPoint.zero
        let endPoint = CGPoint(x: bounds.width, y: 0)
        
        context.drawLinearGradient(gradient,
                                   start: startPoint,
                                   end: endPoint,
                                   options: [CGGradientDrawingOptions(rawValue: 0)])
    }
}


protocol ColorPaletteDelegate: class {
    
    func colorPaletteDidActivate(view: ColorPaletteView)
    
    func colorPalette(view: ColorPaletteView, didChangeColor color: UIColor)
}
