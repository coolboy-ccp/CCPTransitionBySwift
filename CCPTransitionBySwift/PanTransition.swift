//
//  PanTransition.swift
//  CCPTransitionBySwift
//
//  Created by 储诚鹏 on 16/12/5.
//  Copyright © 2016年 RUIYI. All rights reserved.
//

/*
 **手势过度
 */

import UIKit

enum PanDirection {
    case left
    case right
    case up
    case down
}

enum TransitionType {
    case push
    case pop
    case present
    case dismiss
}


class PanTransition: UIPercentDrivenInteractiveTransition {
    typealias gestureConfig = ()->Void
    var pushConfig : gestureConfig? = nil
    var presentConfig : gestureConfig? = nil
    var direction : PanDirection = .left
    var type : TransitionType = .push
    var vcontroller : UIViewController?
    var isPanGesture : Bool = false
    
    init(transitionType type : TransitionType,panDirection direction : PanDirection) {
        self.direction = direction
        self.type = type
        super.init()
    }
    
    func addPanGestureForViewController(vc : UIViewController) {
        let pan = UIPanGestureRecognizer.init(target: self, action: #selector(self.panAction(pan:)))
        self.vcontroller = vc;
        vc.view.addGestureRecognizer(pan)
    }
    
    func addGestureWithView(av : UIView) {
        let pan = UIPanGestureRecognizer.init(target: self, action: #selector(self.panAction(pan:)))
        av.addGestureRecognizer(pan)
    }

    func panAction(pan : UIPanGestureRecognizer) {
        var present : CGFloat = 0
        var transitionX : CGFloat = 0
        var absValue : CGFloat = 0;
        switch direction {
        case .left:
            transitionX = -pan.translation(in: pan.view).x
            present = transitionX / (pan.view?.frame.size.width)!
            absValue = transitionX
            break
        case .right:
            transitionX = pan.translation(in: pan.view).x
            present = transitionX / pan.view!.frame.size.width
            absValue = transitionX
            break
        case .up:
            let transitionY = -pan.translation(in: pan.view).y
            present = transitionY / pan.view!.frame.size.height
            absValue = transitionY
            break
        case .down:
            let transitionY = pan.translation(in: pan.view).y
            present = transitionY / pan.view!.frame.size.height
            absValue = transitionY
            break

        }
        if absValue > 0 {
            switch pan.state {
            case .began:
                isPanGesture = true
                self.startGesture()
                break
            case .changed:
                self.update(present)
                break
            case .ended:
                isPanGesture = false
                if present > 0.3 {
                    self.finish()
                }
                else {
                    self.cancel()
                }
                break
            default:
                break
            }
        }
    }
    
    func startGesture() {
        switch type {
        case .present:
            if presentConfig != nil {
                presentConfig!()
            }
            break
        case .push:
            if pushConfig != nil {
                pushConfig!()
            }
            break
        case .dismiss:
            vcontroller!.dismiss(animated: true, completion: nil)
            break
        case .pop:
            vcontroller!.navigationController?.popViewController(animated: true)
            break
        }
    }
}
