//
//  ExpandingAnimator.swift
//  SlideInTableViewCells
//
//  Created by Bryan Weber on 11/21/15.
//  Copyright © 2015 Intrepid Pursuits. All rights reserved.
//

import UIKit

class ExpandingAnimator: NSObject , UIViewControllerAnimatedTransitioning {
    
    var presenting = true
    var originFrame = CGRect.zero
    let animationDuration: Double = 0.75
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        if let fromViewController = transitionContext!.viewControllerForKey(UITransitionContextFromViewControllerKey) as? ViewController {
            return fromViewController.transitionDuration!
        }
        
        return animationDuration
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        
        if (presenting) {
            
            if let fromViewController = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey) as? ViewController {
                
                let containerView = transitionContext.containerView()
                let toView = transitionContext.viewForKey(UITransitionContextToViewKey)!
                
                toView.frame = fromViewController.selectedCell!.frame
                
                containerView?.addSubview(toView)
                fromViewController.selectedCell?.transform = CGAffineTransformMakeTranslation(0, fromViewController.tableView.frame.height)
                
                UIView.animateWithDuration(animationDuration, animations: { () -> Void in
                    var frame = toView.frame
                    frame.origin.y = 0
                    toView.frame = frame
                    }, completion: {_ in
                        
                        UIView.animateWithDuration(self.animationDuration, animations: { () -> Void in
                            let frame = fromViewController.view.frame
                            toView.frame = frame
                            }, completion: {_ in
                                transitionContext.completeTransition(true)
                        })
                })
            }
        } else {
            let toView = transitionContext.viewForKey(UITransitionContextToViewKey)!
            let fromView = transitionContext.viewForKey(UITransitionContextFromViewKey)!
            
            let containerView = transitionContext.containerView()
            toView.frame = fromView.frame

            UIView.animateWithDuration(animationDuration, animations: { () -> Void in
                fromView.frame = CGRectMake(0, 0, fromView.frame.width, 0)
                }, completion: {_ in
                    containerView?.addSubview(toView)
                    transitionContext.completeTransition(true)
            })

        }
    }
    
}
