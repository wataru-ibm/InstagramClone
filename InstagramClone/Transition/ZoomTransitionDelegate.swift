//
//  ZoomTransitionDelegate.swift
//  InstagramClone
//
//  Created by Wataru Uehara on 2026/06/06.
//

import UIKit

class ZoomTransitionDelegate: NSObject, UIViewControllerTransitioningDelegate {
    private let zoomAnimator = ZoomAnimator()
    var fromImageView: UIImageView?
    
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> (any UIViewControllerAnimatedTransitioning)? {
        zoomAnimator.isPresenting = true
        zoomAnimator.fromImageView = fromImageView
        return zoomAnimator
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> (any UIViewControllerAnimatedTransitioning)? {
        zoomAnimator.isPresenting = false
        return zoomAnimator
    }
}
