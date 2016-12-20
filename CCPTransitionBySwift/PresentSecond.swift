//
//  PresentSecond.swift
//  CCPTransitionBySwift
//
//  Created by 储诚鹏 on 16/12/16.
//  Copyright © 2016年 RUIYI. All rights reserved.
//

import UIKit

public protocol PresentSecondDelegate {
     func PresentSecondDismiss()
     func interactiveTransitionForPresent() -> UIViewControllerInteractiveTransitioning
}

class PresentSecond: UIViewController,UIViewControllerTransitioningDelegate {
    var delegate : PresentSecondDelegate?
    var presentPan : PanTransition?
    var dismissPan : PanTransition?
  
    override func viewDidLoad() {
        super.viewDidLoad()
        self.transitioningDelegate = self
        self.modalPresentationStyle = .custom
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = true
        view.backgroundColor = UIColor.white
        dismissPan = PanTransition.init(transitionType: .dismiss, panDirection: .down)
        dismissPan?.addPanGestureForViewController(vc: self)
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return PresentTransition.init(present: .present)
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return PresentTransition.init(present: .dismiss)
    }
    
    func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        if dismissPan == nil {
            return nil
        }
        else {
            return dismissPan!.isPanGesture ? dismissPan : nil
        }
    }
    
    func interactionControllerForPresentation(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        presentPan = delegate?.interactiveTransitionForPresent() as! PanTransition?
        if presentPan == nil {
            return nil
        }
        else {
            return presentPan!.isPanGesture ? presentPan : nil
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
