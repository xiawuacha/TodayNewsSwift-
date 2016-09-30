//
//  HomeTopicTableViewController.swift
//  TodayNews
//
//  Created by 汪凯 on 16/9/30.
//  Copyright © 2016年 汪凯. All rights reserved.
//

import UIKit

let topicSmallCellID = "HomeSmallCell"
let topicMiddleCellID = "HomeMiddleCell"
let topicLargeCellID = "HomeLargeCell"
let topicNoImageCellID = "HomeNoImageCell"

class HomeTopicTableViewController: UITableViewController {

    
    /// 上一次选中 tabBar 的索引
    var lastSelectedIndex = Int()
    // 下拉刷新的时间
    private var pullRefreshTime: NSTimeInterval?
    // 记录点击的顶部标题模型
    var topTitle: HomeTopTitle?
    // 存放新闻主题的模型数组
    private var newsTopics = [NewsTopicModel]()
    
    
    /// 懒加载homeSearchBar  搜索栏
    private lazy var homeSearchBar: HomeSearchBar = {
        let homeSearchBar = HomeSearchBar()
        homeSearchBar.searchBar.delegate = self
        homeSearchBar.frame = CGRectMake(0, 0, SCREENW, 44)
        return homeSearchBar
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

       setupUI()
        
        // 添加上拉刷新和下拉刷新
        setupRefresh()
    
    }
    
    
    
    private func setupUI() {
        self.definesPresentationContext = true
        tableView.contentInset = UIEdgeInsetsMake(20, 0, 49, 0)
        // 注册四种类型 cell
        tableView.registerClass(HomeSmallCell.self, forCellReuseIdentifier: topicSmallCellID)
        tableView.registerClass(HomeMiddleCell.self, forCellReuseIdentifier: topicMiddleCellID)
        tableView.registerClass(HomeLargeCell.self, forCellReuseIdentifier: topicLargeCellID)
        tableView.registerClass(HomeNoImageCell.self, forCellReuseIdentifier: topicNoImageCellID)
        // 预设定 cell 的高度为 97
        tableView.estimatedRowHeight = 97
        
        tableView.tableHeaderView = homeSearchBar
        
        // 添加监听，监听 tabbar 的点击
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(tabBarSelected), name: TabBarDidSelectedNotification, object: nil)
    }

    func tabBarSelected() {
        //如果是连点 2 次，并且 如果选中的是当前导航控制器，刷新
        if lastSelectedIndex == tabBarController?.selectedIndex {
            tableView.mj_header.beginRefreshing()
            
        }
        lastSelectedIndex = tabBarController!.selectedIndex
    }

    func setupRefresh(){
     pullRefreshTime = NSDate().timeIntervalSince1970
        tableView.mj_header = MJRefreshNormalHeader(refreshingBlock: {
        
        
        })
        
    
    }
    
//    /// 添加上拉刷新和下拉刷新
//    private func setupRefresh() {
//        pullRefreshTime = NSDate().timeIntervalSince1970
//        // 获取首页不同分类的新闻内容
//        YMNetworkTool.shareNetworkTool.loadHomeCategoryNewsFeed(topTitle!.category!, tableView: tableView) { [weak self] (nowTime, newsTopics) in
//            self!.pullRefreshTime = nowTime
//            self!.newsTopics = newsTopics
//            self!.tableView.reloadData()
//        }
//        // 获取更多新闻内容
//        YMNetworkTool.shareNetworkTool.loadHomeCategoryMoreNewsFeed(topTitle!.category!, lastRefreshTime: pullRefreshTime!, tableView: tableView) { [weak self] (moreTopics) in
//            self?.newsTopics += moreTopics
//            self!.tableView.reloadData()
//        }
//    }
//    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }

    /*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
