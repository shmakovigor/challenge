//
//  ColorStyle.swift
//  Challenge
//
//  Created by Igor Shmakov on 05/04/2020.
//  Copyright © 2020 Igor Shmakoff. All rights reserved.
//

import UIKit

struct ColorStyle {
    var background: UIColor
    var foreground: UIColor
}

extension ColorStyle {
    
    static let defaultColors = [
        ColorStyle(
            background: UIColor(white: 0.95, alpha: 1),
            foreground: .black
        ),
        ColorStyle(
            background: UIColor(red: 0.979, green: 0.849, blue: 0.849, alpha: 1),
            foreground: .black
        ),
        ColorStyle(
            background: UIColor(red: 0.847, green: 0.98, blue: 0.956, alpha: 1),
            foreground: .black
        ),
        ColorStyle(
            background: UIColor(red: 1, green: 0.94, blue: 0.825, alpha: 1),
            foreground: .black
        )
    ]
}
