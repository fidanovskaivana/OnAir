//
//  SlideIn.swift
//  4Music
//
//  Created by Ivana Fidanovska on 10/14/20.
//  Copyright © 2020 Fidanovska. All rights reserved.
//

import UIKit

class SlideIn: NSObject, UIViewControllerAnimatedTransitioning {
    
    var isPresenting = false
    let dimmingView = UIView()
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.5
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        guard let toViewController = transitionContext.viewController(forKey: .to),
            let fromViewController = transitionContext.viewController(forKey: .from)
            else{
                return
        }
        
        let containerView = transitionContext.containerView
        let finalWidth = toViewController.view.bounds.width * 0.8
        let finalHight = toViewController.view.bounds.height
        
        if isPresenting {
            dimmingView.alpha = 0.0
            dimmingView.backgroundColor = .black
            containerView.addSubview(dimmingView)
            dimmingView.frame = containerView.bounds
            
            containerView.addSubview(toViewController.view)
            
            toViewController.view.frame = CGRect(x: -finalWidth, y: 0, width: finalWidth, height: finalHight)
            
        }
        let transform = { toViewController.view.transform = CGAffineTransform(translationX: finalWidth, y: 0)}
        
        let identity = {
            self.dimmingView.alpha = 0.0
            fromViewController.view.transform = .identity
        }
        
        let duration = transitionDuration(using: transitionContext)
        let isCancelled = transitionContext.transitionWasCancelled
        UIView.animate(withDuration: duration, animations: {
            self.isPresenting ? transform() : identity()
        }) {(_) in transitionContext.completeTransition(!isCancelled)}
        
    }

}
