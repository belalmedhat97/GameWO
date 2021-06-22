//
//  AnimationManger.swift
//  GameWO
//
//  Created by Belal medhat on 7/19/20.
//  Copyright © 2020 Belal medhat. All rights reserved.
//

import UIKit

class StretchAnimator: NSObject {
    let animationDuration = 0.8
    var presenting = true
    var originFrame = CGRect.zero
    var dismissCompletion: (() -> Void)?

    
}
extension StretchAnimator: UIViewControllerAnimatedTransitioning{
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return animationDuration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        let toView = transitionContext.view(forKey: .to)!
        let detailView = presenting ? toView : transitionContext.view(forKey: .from)!
        let initialFrame = presenting ? originFrame : detailView.frame
        let finalFrame = presenting ? detailView.frame : originFrame
        
        let xScaleFactor = presenting ?
          initialFrame.width / finalFrame.width :
          finalFrame.width / initialFrame.width

        let yScaleFactor = presenting ?
          initialFrame.height / finalFrame.height :
          finalFrame.height / initialFrame.height
        
        let scaleTransform = CGAffineTransform(scaleX: xScaleFactor, y: yScaleFactor)
        if presenting {
          detailView.transform = scaleTransform
          detailView.center = CGPoint(
            x: initialFrame.midX,
            y: initialFrame.midY)
          detailView.clipsToBounds = true
        }
        detailView.layer.cornerRadius = presenting ? 20.0 : 0.0
        detailView.layer.masksToBounds = true
        containerView.addSubview(toView)
        containerView.bringSubviewToFront(detailView)

        
        UIView.animate(
          withDuration: animationDuration,
          delay:0.0,
          usingSpringWithDamping: 0.5,
          initialSpringVelocity: 0.2,
          animations: {
            detailView.transform = self.presenting ? .identity : scaleTransform
            detailView.center = CGPoint(x: finalFrame.midX, y: finalFrame.midY)
            detailView.layer.cornerRadius = !self.presenting ? 20.0 : 0.0
            if !self.presenting {
              self.dismissCompletion?()
                            detailView.alpha = 0

            }
          }, completion: { _ in
            transitionContext.completeTransition(true)
        })
//        UIView.animate(
//          withDuration: animationDuration,
//          delay:0.0,
//          animations: { [weak self] in
//            guard let self = self else { return }
//            detailView.transform = self.presenting ? .identity : scaleTransform
//            detailView.center = CGPoint(x: finalFrame.midX, y: finalFrame.midY)
//          }, completion: { _ in
//            transitionContext.completeTransition(true)
//        })
    }
    
}
