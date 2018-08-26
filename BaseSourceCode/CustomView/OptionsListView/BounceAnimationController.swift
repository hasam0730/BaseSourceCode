//
//  BounceAnimationController.swift
//  StoreSearch
//
//  Created by Developer on 7/12/17.
//  Copyright © 2017 TheMovieTrackerTeam. All rights reserved.
//

import Foundation
import UIKit

class BounceAnimationController: NSObject, UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.5
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        if let toViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to), let toView = transitionContext.view(forKey: UITransitionContextViewKey.to) {
            let containerView = transitionContext.containerView
            toView.frame = transitionContext.finalFrame(for: toViewController)
            containerView.addSubview(toView)
            toView.transform = CGAffineTransform(scaleX: 0.7, y: 0.7)
            UIView.animateKeyframes(withDuration: transitionDuration(using: transitionContext), delay: 0, options: .calculationModeCubic, animations: { 
                UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.3, animations: { 
                    toView.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
                })
                UIView.addKeyframe(withRelativeStartTime: 0.3, relativeDuration: 0.3, animations: {
                    toView.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
                })
                
                UIView.addKeyframe(withRelativeStartTime: 0.6, relativeDuration: 0.3, animations: { 
                    toView.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
                })
            }, completion: { isFinished in
                transitionContext.completeTransition(isFinished)
            })
        }
    }
}
