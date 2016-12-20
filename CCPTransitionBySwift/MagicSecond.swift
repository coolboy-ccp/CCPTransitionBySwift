//
//  MagicSecond.swift
//  CCPTransitionBySwift
//
//  Created by 储诚鹏 on 16/12/2.
//  Copyright © 2016年 RUIYI. All rights reserved.
//

import UIKit

class MagicSecond: UIViewController,UINavigationControllerDelegate {
    var imV : UIImageView?
    var transition : MagicTransition?
    var interactiveTransition : PanTransition?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "MagicSecond"
        self.view.backgroundColor = UIColor.green
        imV = UIImageView.init(image: UIImage.init(named: "smallP"))
        self.view.addSubview(imV!)
        imV?.bounds = CGRect.init(x: 0, y: 0, width: 300, height: 300)
        imV?.center = CGPoint.init(x: self.view.center.x, y: self.view.center.y - self.view.bounds.size.height / 2 + 220)
        interactiveTransition = PanTransition.init(transitionType: .pop, panDirection: .right)
        interactiveTransition?.addPanGestureForViewController(vc: self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return MagicTransition.init(Magic: (operation == .push) ? .push : .pop)
    }
    func navigationController(_ navigationController: UINavigationController, interactionControllerFor animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
       // return (interactiveTransition != nil) ? interactiveTransition : nil
        if interactiveTransition == nil {
            return nil
        }
        return interactiveTransition!.isPanGesture ? interactiveTransition : nil
    }
    
}
