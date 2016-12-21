//
//  ViewController.swift
//  CCPTransitionBySwift
//
//  Created by 储诚鹏 on 16/12/2.
//  Copyright © 2016年 RUIYI. All rights reserved.
//

import UIKit


class ViewController: UIViewController {
    let classes : Array<AnyObject> = [MagicFirst.init(),PresentFirst.init(),PageCoverFirst.init(),ImagesView.init()]
    let titles : Array<String> = ["Magic","Present","PageCover","ImagesView"]
    
    @IBAction func pushAction(_ sender: AnyObject) {
        let vc : UIViewController = classes[sender.tag] as! UIViewController
        vc.view.backgroundColor = UIColor.white
        vc.title = titles[sender.tag]
        self.navigationController?.pushViewController(vc, animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Menu"
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

