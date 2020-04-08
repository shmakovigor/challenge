//
//  Instantinable.swift
//  Challenge
//
//  Created by Igor Shmakov on 08/04/2020.
//  Copyright © 2020 Igor Shmakoff. All rights reserved.
//

import UIKit

protocol Instantinable: class {
    
    static var storyboard: StoryboardName { get }
    static var identifier: String { get }
    static var controller: Self { get }
}


extension Instantinable where Self: UIViewController {
    
    static var storyboard: StoryboardName {
        
        return .main
    }
    
    static var identifier: String {
        
        return String(describing: self)
    }
    
    static var controller: Self {
        
        let controller = UIStoryboard(name: storyboard.rawValue, bundle: .main).instantiateViewController(identifier: identifier)
        return controller as! Self
    }
}


enum StoryboardName: String {
    
    case main = "Main"
}
