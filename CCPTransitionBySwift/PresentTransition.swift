//
//  PresentTransition.swift
//  CCPTransitionBySwift
//
//  Created by 储诚鹏 on 16/12/16.
//  Copyright © 2016年 RUIYI. All rights reserved.
//

import UIKit
enum PresentType {
    case present
    case dismiss
}

class PresentTransition: NSObject,UIViewControllerAnimatedTransitioning {
    var type : PresentType
    init(present type : PresentType) {
        self.type = type
        super.init()
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return (self.type == .present) ? 0.5 : 0.25
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        switch type {
        case .present:
            self.presentAnimation(using: transitionContext)
            break
        case .dismiss:
            self.dismissAnimation(using: transitionContext)
            break
        }
    }

    func presentAnimation(using context : UIViewControllerContextTransitioning?) {
        let fromVC = context?.viewController(forKey: UITransitionContextViewControllerKey.from)
        let toVC = context?.viewController(forKey: UITransitionContextViewControllerKey.to)
        let tempView = fromVC?.view.snapshotView(afterScreenUpdates: true)
        tempView?.frame = (fromVC?.view.frame)!
        fromVC?.view.isHidden = true
        let containtView = context?.containerView
        containtView?.addSubview(tempView!)
        containtView?.addSubview((toVC?.view)!)
        containtView?.backgroundColor = UIColor.orange
        toVC?.view.frame = CGRect.init(x: 0, y: containtView!.frame.size.height, width: containtView!.frame.size.width, height: 400)
        UIView.animate(withDuration: self.transitionDuration(using: context), delay: 0, usingSpringWithDamping: 0.55, initialSpringVelocity: 1.0 / 0.55, options: .curveEaseInOut, animations: { 
            toVC?.view.transform = CGAffineTransform.init(translationX: 0, y: -400)
            tempView?.transform = CGAffineTransform.init(scaleX: 0.8, y: 0.8)
            }) { (finished) in
               context?.completeTransition(!context!.transitionWasCancelled)
                if context!.transitionWasCancelled {
                    fromVC?.view.isHidden = false
                    tempView?.removeFromSuperview()
                }
        }
    }
    
    func dismissAnimation(using context : UIViewControllerContextTransitioning?) {
        let fromVC = context?.viewController(forKey: UITransitionContextViewControllerKey.from)
        let toVC = context?.viewController(forKey: UITransitionContextViewControllerKey.to)
        let containView = context?.containerView
        let subViewsArr = containView?.subviews
        let tempView = subViewsArr?[min((subViewsArr?.count)!,max(0,(subViewsArr?.count)! - 2))]
        UIView.animate(withDuration: self.transitionDuration(using: context), delay: 0, usingSpringWithDamping: 0.55, initialSpringVelocity: 1.0 / 0.55, options: .curveEaseInOut, animations: {
            fromVC?.view.transform = CGAffineTransform.identity
            tempView?.transform = CGAffineTransform.identity
            }) { (finished) in
                if context!.transitionWasCancelled {
                    context?.completeTransition(false)
                }
                else {
                    context?.completeTransition(true)
                    toVC?.view.isHidden = false
                    tempView?.removeFromSuperview()
                }
        }
        
        
    }
    

}
