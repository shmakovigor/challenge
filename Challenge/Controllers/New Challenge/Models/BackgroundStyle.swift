//
//  BackgroundStyle.swift
//  Challenge
//
//  Created by Igor Shmakov on 05/04/2020.
//  Copyright © 2020 Igor Shmakoff. All rights reserved.
//

import UIKit

struct BackgroundStyle {
    
    enum StyleType {
        case color
        case image
    }
    
    enum Availability {
        case free
        case pro
    }
    
    var type: StyleType
    var availability: Availability
    var color: ColorStyle?
    var image: UIImage?
}

extension BackgroundStyle {
    
    static func backgroundsWithDefault(style: ColorStyle) -> [BackgroundStyle] {
            
        return [
            BackgroundStyle(
                type: .color,
                availability: .free,
                color: style,
                image: nil
            ),
            BackgroundStyle(
                type: .image,
                availability: .free,
                color: ColorStyle(background: .clear, foreground: .white),
                image: #imageLiteral(resourceName: "bg1.jpg")
            ),
            BackgroundStyle(
                type: .image,
                availability: .free,
                color: ColorStyle(background: .clear, foreground: .black),
                image: #imageLiteral(resourceName: "bg2.jpg")
            ),
            BackgroundStyle(
                type: .image,
                availability: .free,
                color: ColorStyle(background: .clear, foreground: .white),
                image: #imageLiteral(resourceName: "bg3.jpg")
            ),
            BackgroundStyle(
                type: .image,
                availability: .pro,
                color: ColorStyle(background: .clear, foreground: .white),
                image: #imageLiteral(resourceName: "bg4.jpeg")
            ),
            BackgroundStyle(
                type: .image,
                availability: .pro,
                color: ColorStyle(background: .clear, foreground: .white),
                image: #imageLiteral(resourceName: "bg5.png")
            ),
            BackgroundStyle(
                type: .image,
                availability: .pro,
                color: ColorStyle(background: .clear, foreground: .white),
                image: #imageLiteral(resourceName: "bg4.jpeg")
            ),
            BackgroundStyle(
                type: .image,
                availability: .pro,
                color: ColorStyle(background: .clear, foreground: .white),
                image: #imageLiteral(resourceName: "bg5.png")
            )
        ]
    }
}
