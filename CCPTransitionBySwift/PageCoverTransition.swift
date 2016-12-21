//
//  PageCoverTransition.swift
//  CCPTransitionBySwift
//
//  Created by 储诚鹏 on 16/12/20.
//  Copyright © 2016年 RUIYI. All rights reserved.
//

import UIKit

enum PageCoverTransitionType {
    case pop
    case push
}

class PageCoverTransition: NSObject,UIViewControllerAnimatedTransitioning {
    var transitionType : PageCoverTransitionType?
    init(TransitionType type : PageCoverTransitionType) {
        transitionType = type
        super.init()
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 1
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        if transitionType == .pop {
            self.popAnimation(using: transitionContext)
        }
        else {
            self.pushAnimation(using: transitionContext)
        }
    }

    func animationAnchorPoint(point : CGPoint, aView : UIView) {
        aView.frame = aView.frame.offsetBy(dx: (point.x - aView.layer.anchorPoint.x) * aView.frame.size.width, dy: (point.y - aView.layer.anchorPoint.y) * aView.frame.size.height)
        aView.layer.anchorPoint = point
    }
    
    func pushAnimation(using context : UIViewControllerContextTransitioning){
        let fromVC = context.viewController(forKey: UITransitionContextViewControllerKey.from)
        let toVC = context.viewController(forKey: UITransitionContextViewControllerKey.to)
        let tempView = fromVC?.view.snapshotView(afterScreenUpdates: false)
        let contrainView = context.containerView
        contrainView.addSubview(toVC!.view)
        contrainView.addSubview(tempView!)
        fromVC!.view.isHidden = true
        contrainView.insertSubview(toVC!.view, at: 0)
        self.animationAnchorPoint(point: CGPoint.init(x: 0, y: 0.5), aView: tempView!)
        var transform3D = CATransform3DIdentity
        transform3D.m34 = -0.002
        contrainView.layer.sublayerTransform = transform3D
        let fromGradient = CAGradientLayer()
        fromGradient.frame = fromVC!.view.bounds
        fromGradient.colors = [UIColor.black.cgColor,UIColor.black.cgColor]
        fromGradient.startPoint = CGPoint.init(x: 0, y: 0.5)
        fromGradient.endPoint = CGPoint.init(x: 0.8, y: 0.5)
        let fromShadow = UIView.init(frame: fromVC!.view.bounds)
        fromShadow.backgroundColor = UIColor.clear
        fromShadow.layer.insertSublayer(fromGradient, at: 1)
        fromShadow.alpha = 0
        tempView?.addSubview(fromShadow)
        let toGradient = CAGradientLayer()
        toGradient.frame = fromVC!.view.bounds
        toGradient.colors = [UIColor.black.cgColor,UIColor.black.cgColor]
        toGradient.startPoint = CGPoint.init(x: 0, y: 0.5)
        toGradient.endPoint = CGPoint.init(x: 0.8, y: 0.5)
        let toShadow = UIView.init(frame: fromVC!.view.bounds)
        toShadow.backgroundColor = UIColor.clear
        toShadow.layer .insertSublayer(toGradient, at: 1)
        toShadow.alpha = 1.0
        toVC?.view.addSubview(toShadow)
        UIView.animate(withDuration: self.transitionDuration(using: context), animations: { 
            fromShadow.alpha = 1.0
            tempView?.layer.transform = CATransform3DMakeRotation(-(CGFloat)(M_PI_2), 0, 1, 0)
            toShadow.alpha = 0
            }) { (finished) in
                context.completeTransition(!context.transitionWasCancelled)
                if context.transitionWasCancelled {
                    tempView?.removeFromSuperview()
                    fromVC?.view.isHidden = false
                }
        }
        
    }
    
    func popAnimation(using context : UIViewControllerContextTransitioning){
        let fromVC = context.viewController(forKey: UITransitionContextViewControllerKey.from)
        let toVC = context.viewController(forKey: UITransitionContextViewControllerKey.to)
        let contrainView = context.containerView
        let tempView = contrainView.subviews.last
        contrainView.addSubview(toVC!.view)
        UIView.animate(withDuration: self.transitionDuration(using: context), animations: { 
            tempView?.layer.transform = CATransform3DIdentity
            fromVC?.view.subviews.last?.alpha = 1.0
            tempView?.subviews.last?.alpha = 0.0
            }) { (finished) in
                if context.transitionWasCancelled {
                    context.completeTransition(false)
                }
                else {
                    context.completeTransition(true)
                    tempView?.removeFromSuperview()
                    toVC?.view.isHidden = false
                }
        }
    }
    
}
