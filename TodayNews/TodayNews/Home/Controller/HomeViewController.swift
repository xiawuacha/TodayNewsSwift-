//
//  HomeViewController.swift
//  TodayNews
//
//  Created by 汪凯 on 16/9/8.
//  Copyright © 2016年 汪凯. All rights reserved.
//

import UIKit

class HomeViewController: BaseViewController {
    // 当前选中的 titleLabel 的 上一个 titleLabel
    var oldIndex: Int = 0
    
    /// 首页顶部标题
    var homeTitleArr = [HomeTopTitle]()
    
    //MARK:懒加载 每次刷新显示的提示标题
//    private lazy var tipView: YMTipView = {
//        let tipView = YMTipView()
//        tipView.frame = CGRectMake(0, 44, SCREENW, 35)
//        // 加载 navBar 上面，不会随着 tableView 一起滚动
//        self.navigationController?.navigationBar.insertSubview(tipView, atIndex: 0)
//        return tipView
//    }()
    
    //MARK:懒加载 滚动视图
//    private lazy var scrollView: UIScrollView = {
//        let scrollView = UIScrollView()
//        scrollView.frame = UIScreen.mainScreen().bounds
//        scrollView.pagingEnabled = true
//        scrollView.delegate = self
//        return scrollView
//    }()
    
    //MARK:懒加载 顶部标题
    private lazy var titleView: ScrollTitleView = {
        let titleView = ScrollTitleView()
        return titleView
    }()

    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //1.布局界面
        setupUI()
//        // 2.有多少条文章更新
//        showRefreshTipView()
//        // 3.处理标题的回调
//        homeTitleViewCallback()


    }
    
    private func setupUI() {
        view!.backgroundColor = KGlobalColor()
        //不要自动调整inset
        automaticallyAdjustsScrollViewInsets = false
        // 设置导航栏属性
        navigationController?.navigationBar.barStyle = .Black
        navigationController?.navigationBar.barTintColor = KColor(210, g: 63, b: 66, a: 1.0)
        // 设置 titleView
        navigationItem.titleView = titleView
        // 添加滚动视图
//        view.addSubview(scrollView)
    }






}
