//
//  PageCoverFirst.swift
//  CCPTransitionBySwift
//
//  Created by 储诚鹏 on 16/12/20.
//  Copyright © 2016年 RUIYI. All rights reserved.
//

import UIKit

class PageCoverFirst: UIViewController,PagecoverSecondDelegate {
    var pushPan : PanTransition?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        let imgV = UIImageView.init(frame: UIScreen.main.bounds.offsetBy(dx: 0, dy: 64))
        imgV.image = UIImage.init(named: "pageCoverFirst")
        view.addSubview(imgV)
        pushPan = PanTransition.init(transitionType: .push, panDirection: .left)
        pushPan?.pushConfig = {
            self.pushToNextView()
        }
        pushPan?.addPanGestureForViewController(vc: self)
        let backBtn = UIBarButtonItem.init(title: "back", style: .plain, target: self, action: #selector(self.back))
        self.navigationItem.leftBarButtonItem = backBtn
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func back() {
        self.navigationController?.delegate = nil
        self.navigationController?.popViewController(animated: true)
    }
  
    func pushToNextView() {
        let second = PageCoverSecond.init()
        second.delegate = self
        self.navigationController?.delegate = second
        self.navigationController?.pushViewController(second, animated: true)
    }
    
    func pushTransition() -> UIViewControllerInteractiveTransitioning {
        return pushPan!
    }

}
