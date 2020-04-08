//
//  Animators.swift
//  Challenge
//
//  Created by Igor Shmakov on 08/04/2020.
//  Copyright © 2020 Igor Shmakoff. All rights reserved.
//

import UIKit

class NavigationAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    let operation: UINavigationController.Operation
    
    init(operation: UINavigationController.Operation) {
        
        self.operation = operation
        super.init()
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        
        return transitionContext?.isInteractive ?? false ? 0.7 : 0.3
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        guard
            let viewFrom = transitionContext.view(forKey: .from),
            let viewTo = transitionContext.view(forKey: .to),
            let controllerFrom = transitionContext.viewController(forKey: .from),
            let controllerTo = transitionContext.viewController(forKey: .to)
        else {
            return
        }
        
        let container = transitionContext.containerView
        
        let frameFromInitial = transitionContext.initialFrame(for: controllerFrom)
        let frameToFinal = transitionContext.finalFrame(for: controllerTo)
        let direction: CGFloat = operation == .push ? 1 : -1
        
        var frameFromFinal = frameFromInitial
        frameFromFinal.origin.x -= frameFromFinal.width * 0.2 * direction
        
        var frameToInitial = frameToFinal
        frameToInitial.origin.x += frameToInitial.width * 0.2 * direction
        
        viewTo.frame = frameToInitial
        viewTo.alpha = 0
        
        container.addSubview(viewTo)
        
        UIView.animateKeyframes(withDuration: transitionDuration(using: transitionContext), delay: 0, options: .calculationModeCubic, animations: {
            
            UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.5) {
                
                viewFrom.frame = frameFromFinal
                viewFrom.alpha = 0
            }

            UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.5) {
                
                viewTo.frame = frameToFinal
                viewTo.alpha = 1
            }
            
        }) { _ in
                
            let cancelled = transitionContext.transitionWasCancelled
            transitionContext.completeTransition(!cancelled)
        }
    }
}


class NavigationInteractor : UIPercentDrivenInteractiveTransition {
    
    var shouldCompleteTransition = false
    var transitionInProgress = false
}
