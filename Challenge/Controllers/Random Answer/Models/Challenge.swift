//
//  Challenge.swift
//  Challenge
//
//  Created by Igor Shmakov on 08/04/2020.
//  Copyright © 2020 Igor Shmakoff. All rights reserved.
//

import Foundation

struct Challenge {
    
    var name: String
}


extension Challenge {
    
    static let defaultValues = [
        Challenge(name: "Tell your secret dream"),
        Challenge(name: "What's your pet name?"),
        Challenge(name: "Where do you live?"),
        Challenge(name: "What's your card CVV?"),
        Challenge(name: "Where do you hide your money?"),
        Challenge(name: "Your favorite place to travel to")
    ]
    
    static var random: Challenge {
        
        return defaultValues[Int.random(in: 0..<defaultValues.count)]
    }
}
