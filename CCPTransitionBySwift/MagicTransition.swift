//
//  MagicTransition.swift
//  CCPTransitionBySwift
//
//  Created by 储诚鹏 on 16/12/2.
//  Copyright © 2016年 RUIYI. All rights reserved.
//

import UIKit
enum MagicType {
    case push
    case pop
}

class MagicTransition: NSObject,UIViewControllerAnimatedTransitioning {
    var type : MagicType
    
    init(Magic type:MagicType) {
        self.type = type
        super.init()
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.5
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        switch type {
        case .push:
            self.pushAnimation(using: transitionContext)
            break
        case .pop:
            self.popAnimation(using: transitionContext)
            break
        }
    }
    func pushAnimation(using context : UIViewControllerContextTransitioning) {
        let fromVC = context.viewController(forKey: UITransitionContextViewControllerKey.from) as! MagicFirst
        let toVC = context.viewController(forKey: UITransitionContextViewControllerKey.to) as! MagicSecond
        let conView = context.containerView
        conView.backgroundColor = UIColor.white
        let imgV = fromVC.imgs?[fromVC.index]
        let tV = imgV?.snapshotView(afterScreenUpdates: false)
        tV?.frame = (imgV?.convert((imgV?.bounds)!, to: conView))!
        toVC.imV?.isHidden = true
        imgV?.isHidden = true
        toVC.view.alpha = 0
        conView.addSubview(toVC.view)
        conView.addSubview(tV!)
        UIView.animate(withDuration: self.transitionDuration(using: context), delay: 0, usingSpringWithDamping: 0.55, initialSpringVelocity: 1 / 0.55, options: .layoutSubviews, animations: { 
            tV?.frame = (toVC.imV?.convert((toVC.imV?.bounds)!, to: conView))!
            toVC.view.alpha = 1
            }) { (finished) in
                tV?.isHidden = true;
                toVC.imV?.isHidden = false
                context.completeTransition(true)
        }
        
    }
    
    func popAnimation(using context:UIViewControllerContextTransitioning) {
        let fromVC = context.viewController(forKey: UITransitionContextViewControllerKey.from) as! MagicSecond
        let toVC = context.viewController(forKey: UITransitionContextViewControllerKey.to) as! MagicFirst
        let conView = context.containerView
        let imgV = toVC.imgs?[toVC.index]
        let tempView = conView.subviews.last
        imgV?.isHidden = true
        fromVC.imV?.isHidden = true
        tempView?.isHidden = false
        conView.insertSubview(toVC.view, at: 0)
        UIView.animate(withDuration: self.transitionDuration(using: context), delay: 0, usingSpringWithDamping: 0.55, initialSpringVelocity: 1 / 0.55, options: .layoutSubviews, animations: { 
            tempView?.frame = (imgV?.convert((imgV?.bounds)!, to: conView))!
            fromVC.view.alpha = 0
            }) { (finished) in
                if context.transitionWasCancelled{
                    print("pop was cancelled!")
                }
                context.completeTransition(!context.transitionWasCancelled)
                if context.transitionWasCancelled {
                    tempView?.isHidden = true
                    fromVC.imV?.isHidden = false
                }
                else {
                    imgV?.isHidden = false
                    tempView?.removeFromSuperview()
                }
        }
    }
}

