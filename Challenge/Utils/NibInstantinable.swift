//
//  NibInstantinable.swift
//  Challenge
//
//  Created by Igor Shmakov on 05/04/2020.
//  Copyright © 2020 Igor Shmakoff. All rights reserved.
//

import UIKit

protocol NibInstantinable: class {
    
    static var view: Self { get }
    static var nibName: String { get }
}


extension NibInstantinable {
    
    static var nibName: String {
        
        return String(describing: self)
    }
    
    static var nib: UINib {
        
        return UINib(nibName: self.nibName, bundle: nil)
    }
    
    static var view: Self {
        
        return self.nib.instantiate(withOwner: self, options: nil).first as! Self
    }
}
