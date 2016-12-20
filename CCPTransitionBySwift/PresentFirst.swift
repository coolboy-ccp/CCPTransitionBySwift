//
//  PresentFirst.swift
//  CCPTransitionBySwift
//
//  Created by 储诚鹏 on 16/12/16.
//  Copyright © 2016年 RUIYI. All rights reserved.
//

import UIKit

class PresentFirst: UIViewController,PresentSecondDelegate {
    var interactiveTransition : PanTransition?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "PresentFirst"
        self.view.backgroundColor = UIColor.white
        let imgV = UIImageView.init(frame: CGRect.init(x: 0, y: 0, width: 300,height: 533))
        imgV.center = view.center;
        imgV.image = UIImage.init(named: "presentImg.jpeg")
        self.view.addSubview(imgV)
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(self.tapAction(tap:)))
        self.view.addGestureRecognizer(tap)
        interactiveTransition = PanTransition.init(transitionType: .present, panDirection: .up)
        interactiveTransition?.presentConfig = {
            self.present()
        }
        interactiveTransition?.addPanGestureForViewController(vc: self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func PresentSecondDismiss() {
        self.dismiss(animated: true, completion: nil)
    }
    
    func interactiveTransitionForPresent() -> UIViewControllerInteractiveTransitioning {
        return (interactiveTransition ?? nil)!
    }
    
    func tapAction(tap : UITapGestureRecognizer) {
        self.present()
    }
    
    func present() {
        let second = PresentSecond()
        second.delegate = self
        self.present(second, animated: true, completion: nil)
    }

}
