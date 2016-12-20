//
//  MagicFirst.swift
//  CCPTransitionBySwift
//
//  Created by 储诚鹏 on 16/12/2.
//  Copyright © 2016年 RUIYI. All rights reserved.
//

import UIKit

class MagicFirst: UIViewController,UINavigationControllerDelegate {

    var imgs : Array<UIImageView>? = []
    var index : Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "MagicFirst"
        self.createAImageView()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func createAImageView() {
        for i in 0..<5 {
            let x : Int = i % 2
            let y : Int = i / 2
            let w : CGFloat = (UIScreen.main.bounds.size.width - 70) / 2
            let imgV = UIImageView.init(frame: CGRect.init(x: CGFloat(x) * (w + 30), y: 64 + CGFloat(y) * (w + 20), width: w, height: w))
            imgV.image = UIImage.init(named: "smallP")
            let tap = UITapGestureRecognizer.init(target: self, action:#selector(self.tapAction(tap:)))
            imgV.addGestureRecognizer(tap)
            imgV.tag = 100 + i
            imgV.isUserInteractionEnabled = true
            self.view.addSubview(imgV)
            imgs?.append(imgV)
            let backBtn = UIBarButtonItem.init(title: "back", style: .plain, target: self, action: #selector(self.backTo))
            self.navigationItem.leftBarButtonItem = backBtn
        }
    }
 
    func backTo() {
        self.navigationController?.delegate = nil
        self.navigationController?.popViewController(animated: true)
    }
    
    func tapAction(tap : UITapGestureRecognizer) {
        index = Int((tap.view?.tag)! - 100)
        let second = MagicSecond.init()
        self.navigationController?.delegate = second
        self.navigationController?.pushViewController(second, animated: true)
    }

}
