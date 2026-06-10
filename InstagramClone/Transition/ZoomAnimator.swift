//
//  ZoomAnimator.swift
//  InstagramClone
//
//  Created by Wataru Uehara on 2026/06/03.
//

import UIKit

class ZoomAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    var isPresenting: Bool = false
    var fromImageView: UIImageView?
    
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.3
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let toVC = transitionContext.viewController(forKey: .to) else { return }
        guard let fromVC = transitionContext.viewController(forKey: .from) else { return }
        let containerView = transitionContext.containerView
        
        if isPresenting {
            containerView.addSubview(toVC.view)
            guard let fromImageView = fromImageView else { return }
            let startFrame = fromImageView.convert(fromImageView.bounds, to: containerView)
            let endFrame = toVC.view.frame
            toVC.view.frame = startFrame

            UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
                toVC.view.frame = endFrame
            }, completion: { _ in
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            })
        } else {
            guard let fromImageView = fromImageView else { return }
            let startFrame = fromImageView.convert(fromImageView.bounds, to: containerView)
                        
            UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
                fromVC.view.frame = startFrame
            }, completion: { _ in
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            })
        }
    }
    
    
}
