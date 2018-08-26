//
//  FadeOutAnimationController.swift
//  StoreSearch
//
//  Created by Developer on 7/12/17.
//  Copyright © 2017 TheMovieTrackerTeam. All rights reserved.
//

import Foundation
import UIKit
class FadeOutAnimationController: NSObject, UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.4
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        if let fromView = transitionContext.view(forKey: UITransitionContextViewKey.from) {
            let duration = transitionDuration(using: transitionContext)
            UIView.animate(withDuration: duration, animations: {
                fromView.alpha = 1.0
				
            }, completion: { finished in
                transitionContext.completeTransition(finished)
            })
        }
    }
}
