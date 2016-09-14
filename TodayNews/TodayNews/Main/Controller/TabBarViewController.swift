//
//  TabBarViewController.swift
//  TodayNews
//
//  Created by 汪凯 on 16/9/8.
//  Copyright © 2016年 汪凯. All rights reserved.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        addChildVC()
        
    }

    override class func initialize() {
        let tabBar = UITabBar.appearance()
        tabBar.tintColor = KColor(111, g: 111, b: 111, a: 1.0)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK:添加自控制器
    func addChildVC(){
        
        addChildViewController(HomeViewController(), title: "首页", imageName: "home_tabbar_22x22_", selectedImageName: "home_tabbar_press_22x22_")
        addChildViewController(VideoViewController(), title: "视频", imageName: "video_tabbar_22x22_", selectedImageName: "video_tabbar_press_22x22_")
        addChildViewController(CareViewController(), title: "关注", imageName: "newcare_tabbar_22x22_", selectedImageName: "newcare_tabbar_press_22x22_")
        addChildViewController(MineViewController(), title: "我的", imageName: "mine_tabbar_22x22_", selectedImageName: "mine_tabbar_press_22x22_")
        
        
    }
    
    func addChildViewController(childController: UIViewController, title: String, imageName: String, selectedImageName: String) {
        childController.tabBarItem.image = UIImage(named: imageName)
        childController.tabBarItem.selectedImage = UIImage(named: selectedImageName)
        childController.title = title
        let nav = NavViewController(rootViewController: childController)
        addChildViewController(nav)
    }

}
