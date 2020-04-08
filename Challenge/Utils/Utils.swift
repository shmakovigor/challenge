//
//  Utils.swift
//  Challenge
//
//  Created by Igor Shmakov on 08/04/2020.
//  Copyright © 2020 Igor Shmakoff. All rights reserved.
//

import Foundation

func delay(_ delay: Double = 0.0, closure: @escaping ()->()) {
    
    DispatchQueue.main.asyncAfter(deadline: .now() + delay, execute: closure)
}
