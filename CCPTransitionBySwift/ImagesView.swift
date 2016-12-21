//
//  ImagesView.swift
//  CCPTransitionBySwift
//
//  Created by 储诚鹏 on 16/12/21.
//  Copyright © 2016年 RUIYI. All rights reserved.
//

import UIKit

class ImagesView: UIViewController {
    var index : Int = 0 {
        didSet {
            if index > 2 {
                index = 0
            }
            else if index < 0 {
                index = 2
            }
        }
    }
    let imgNames = ["banner1","banner2","banner3"]
    let imgV = UIImageView.init(frame: UIScreen.main.bounds.offsetBy(dx: 0, dy: 64))
    var pan :UIPanGestureRecognizer?
    var panX : CGFloat?
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        imgV.image = UIImage.init(named: imgNames[0])
        view.addSubview(imgV)
        imgV.isUserInteractionEnabled = true
        pan = UIPanGestureRecognizer.init(target: self, action: #selector(self.panAction(pan:)))
        imgV.addGestureRecognizer(pan!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func panAction(pan : UIPanGestureRecognizer) {
        panX = pan.translation(in: imgV).x
        if pan.state == .ended {
            if panX! > 0 {
                self.imgsMove(using: kCATransitionFromLeft)
            }
            else if panX! < 0 {
                self.imgsMove(using: kCATransitionFromRight)
            }
        }
    }
    
    func imgsMove(using direction : String) {
        if panX! > 0 {
            index += 1
        }
        else if panX! < 0 {
            index -= 1
        }
        let imgName = imgNames[index]
        imgV.image = UIImage.init(named: imgName)
        let transition = CATransition()
        transition.type = "pageCurl"
        transition.subtype = direction
        transition.duration = 1
        transition.isRemovedOnCompletion = true
        imgV.layer.add(transition, forKey: nil)
    }
    

}
