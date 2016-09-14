//
//  NavViewController.swift
//  TodayNews
//
//  Created by 汪凯 on 16/9/8.
//  Copyright © 2016年 汪凯. All rights reserved.
//

import UIKit

class NavViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
   override class func initialize(){
    super.initialize()
    let navBar = UINavigationBar.appearance()
    navBar.barTintColor = UIColor.whiteColor()
    navBar.tintColor = KColor(0, g: 0, b: 0, a: 0.7)
    navBar.titleTextAttributes = [NSFontAttributeName: UIFont.systemFontOfSize(17)]
    
    }
    
//   //MARK:重写push方法
    override func pushViewController(viewController: UIViewController, animated: Bool) {
        
        super.pushViewController(viewController, animated: true)
        
        if viewControllers.count>1{
            //自动显示和隐藏tabbar
        viewController.hidesBottomBarWhenPushed = true
            
            viewController.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "lefterbackicon_titlebar_28x28_"), style: .Plain, target: self, action: #selector(Navback))
        }
        
    }
    
    
    func Navback(){
     popViewControllerAnimated(true)
    
    }
}
