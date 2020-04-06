//
//  FontStyle.swift
//  Challenge
//
//  Created by Igor Shmakov on 05/04/2020.
//  Copyright © 2020 Igor Shmakoff. All rights reserved.
//

import Foundation

struct FontStyle {
    var name: String
}

extension FontStyle {
    
    static let defaultFonts = [
        FontStyle(name: "HelveticaNeue-Bold"),
        FontStyle(name: "Optima-Bold"),
        FontStyle(name: "SnellRoundhand-Bold"),
        FontStyle(name: "Didot-Bold"),
        FontStyle(name: "Futura-Bold"),
        FontStyle(name: "GeezaPro-Bold"),
        FontStyle(name: "Thonburi-Bold"),
        FontStyle(name: "Verdana-Bold")
    ]
}
