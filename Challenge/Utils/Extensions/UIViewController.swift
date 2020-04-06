//
//  UIViewController.swift
//  Challenge
//
//  Created by Igor Shmakov on 06/04/2020.
//  Copyright © 2020 Igor Shmakoff. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func show(message: String, title: String) {
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let ok = UIAlertAction(title: "OK", style: .cancel) { _ in
            
        }
        
        alertController.addAction(ok)
        present(alertController, animated: true)
    }
}
