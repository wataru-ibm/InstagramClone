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
            let finalFrame = transitionContext.finalFrame(for: toVC)
            toVC.view.frame = finalFrame
            
            let scaleX = startFrame.width / finalFrame.width
            let scaleY = startFrame.height / finalFrame.height
            
            let tx = startFrame.midX - finalFrame.midX
            let ty = startFrame.midY - finalFrame.midY
            
            toVC.view.transform = CGAffineTransform(scaleX: scaleX, y: scaleY)
                .concatenating(CGAffineTransform(translationX: tx, y:ty))  //.concatenatingはスクリーン座標系
            toVC.view.alpha = 0
            
            UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
                toVC.view.transform = .identity
                toVC.view.alpha = 1
            }, completion: { _ in
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            })
            
        } else {
            guard let fromImageView = fromImageView else { return }
            let startFrame = fromImageView.convert(fromImageView.bounds, to: containerView)
            
            let scaleX = startFrame.width / fromVC.view.frame.width
            let scaleY = startFrame.height / fromVC.view.frame.height
            
            let tx = startFrame.midX - fromVC.view.frame.midX
            let yx = startFrame.midY - fromVC.view.frame.midY
            
            UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
                fromVC.view.transform = CGAffineTransform(scaleX: scaleX, y: scaleY)
                    .concatenating(CGAffineTransform(translationX: tx, y:yx))
            }, completion: { _ in
                fromVC.view.transform = .identity
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            })
        }
    }
    
    
}
