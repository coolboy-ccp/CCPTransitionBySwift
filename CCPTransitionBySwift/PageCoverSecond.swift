//
//  PageCoverSecond.swift
//  CCPTransitionBySwift
//
//  Created by 储诚鹏 on 16/12/20.
//  Copyright © 2016年 RUIYI. All rights reserved.
//

import UIKit


protocol PagecoverSecondDelegate {
    func pushTransition() -> UIViewControllerInteractiveTransitioning
}

class PageCoverSecond: UIViewController,UINavigationControllerDelegate {

    var operation : UINavigationControllerOperation?
    var popPan : PanTransition?
    var delegate : PagecoverSecondDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "pagecoverSecond"
        let imgV = UIImageView.init(frame: UIScreen.main.bounds.offsetBy(dx: 0, dy: 64))
        imgV.image = UIImage.init(named: "pageCoverSecond")
        view.addSubview(imgV)
        view.backgroundColor = UIColor.white
        popPan = PanTransition.init(transitionType: .pop, panDirection: .right)
        popPan?.addPanGestureForViewController(vc: self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        self.operation = operation
        return PageCoverTransition.init(TransitionType: (operation == UINavigationControllerOperation.push) ? .push : .pop)
    }
    func navigationController(_ navigationController: UINavigationController, interactionControllerFor animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        if operation == UINavigationControllerOperation.push {
            let pushTransition = delegate!.pushTransition() as! PanTransition
            return pushTransition.isPanGesture ? pushTransition : nil
        }
        else {
            return popPan!.isPanGesture ? popPan : nil
        }
    }


}
