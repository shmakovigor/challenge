//
//  NavigationController.swift
//  Challenge
//
//  Created by Igor Shmakov on 08/04/2020.
//  Copyright © 2020 Igor Shmakoff. All rights reserved.
//

import UIKit

class NavigationController: UINavigationController {
    
    var navigationInteractor = NavigationInteractor()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNavigationBarHidden(true, animated: false)
        view.backgroundColor = .white
        
        let swipeBackGesture = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(NavigationController.handleBackGesture(sender:)))
        swipeBackGesture.edges = .left
        view.addGestureRecognizer(swipeBackGesture)
        
        delegate = self
    }
    
    @objc func handleBackGesture(sender: UIScreenEdgePanGestureRecognizer) {
        
        let percentThreshold: CGFloat = 0.2
        let translation = sender.translation(in: view)
        let progress = translation.x / view.frame.width
        
        switch sender.state {
        case .began:
            navigationInteractor.transitionInProgress = true
            popViewController(animated: true)
            break
        case .changed:
            navigationInteractor.shouldCompleteTransition = progress > percentThreshold
            navigationInteractor.update(progress)
            break
        case .cancelled:
            navigationInteractor.transitionInProgress = false
            navigationInteractor.cancel()
            break
        case .ended:
            navigationInteractor.transitionInProgress = false
            navigationInteractor.shouldCompleteTransition ? navigationInteractor.finish() : navigationInteractor.cancel()
            break
        default:
            return
        }
    }
}


extension NavigationController: UINavigationControllerDelegate {
    
    func navigationController(_ navigationController: UINavigationController,
                              animationControllerFor operation: UINavigationController.Operation,
                              from fromVC: UIViewController,
                              to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        return NavigationAnimator(operation: operation)
    }
    
    func navigationController(_ navigationController: UINavigationController,
                              interactionControllerFor animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        
        guard let animator = animationController as? NavigationAnimator, animator.operation == .pop else {
            return nil
        }
        
        return navigationInteractor.transitionInProgress ? navigationInteractor : nil
    }
}
