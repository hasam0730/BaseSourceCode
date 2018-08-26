//
//  DimmingPresentationController.swift
//  StoreSearch
//
//  Created by Developer on 7/11/17.
//  Copyright © 2017 TheMovieTrackerTeam. All rights reserved.
//

import Foundation
import UIKit

class DimmingPresentationController: UIPresentationController {
    
    lazy var dimmingView = GradientView(frame: CGRect.zero)
    
    override var shouldRemovePresentersView: Bool {
        return false
    }
    
    override func presentationTransitionWillBegin() {
        super.presentationTransitionWillBegin()
        dimmingView.frame = containerView!.bounds
        containerView!.insertSubview(dimmingView, at: 0)
        //
        dimmingView.alpha = 0.0
        if let coordinator = presentedViewController.transitionCoordinator {
            coordinator.animate(alongsideTransition: { _ in
                self.dimmingView.alpha = 1.0
				self.dimmingView.layoutIfNeeded()
            }, completion: nil)
        }
    }
    
    override func dismissalTransitionWillBegin() {
        super.dismissalTransitionWillBegin()
        if let coordinator = presentedViewController.transitionCoordinator {
            coordinator.animate(alongsideTransition: { _ in
                self.dimmingView.alpha = 0.0
				self.dimmingView.layoutIfNeeded()
            }, completion: nil)
        }
    }
}
