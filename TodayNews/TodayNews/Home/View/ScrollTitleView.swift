//
//  ScrollTitleView.swift
//  TodayNews
//
//  Created by 汪凯 on 16/9/12.
//  Copyright © 2016年 汪凯. All rights reserved.
//

import UIKit
import Kingfisher
import SnapKit
class ScrollTitleView: UIView {

    /// 存放标题模型的数组
    var titles = [HomeTopTitle]()
    /// 存放标题 label 数组
    var labels = [WKTitleLabel]()
    /// 存放 label 的宽度
    private var labelWidths = [CGFloat]()
    /// 顶部导航栏右边加号按钮点击
    var addBtnClickClosure: (() -> ())?
    /// 点击了一个 label
    var didSelectTitleLable: ((titleLabel: WKTitleLabel)->())?
    /// 向外界传递 titles 数组
    var titlesClosure: ((titleArray: [HomeTopTitle])->())?
    /// 记录当前选中的下标
    private var currentIndex = 0
    /// 记录上一个下标
    private var oldIndex = 0
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        let url = BASE_URL + "article/category/get_subscribed/v1/?"
        let params = ["device_id": device_id,
                      "aid": 13,
                      "iid": IID]
        NetworkTool.shareNetworkTool.loadGETRequestDataInfo(url, params: params) { [weak self] (dataDict) in
            print(dataDict)
            let dict = ["category": "__all__", "name": "推荐"]
            let recommend = HomeTopTitle(dict: dict)
            self!.titles.append(recommend)
            let dataArr = dataDict["data"]!.arrayObject
            for dic in dataArr!{
           let title  = HomeTopTitle(dict: dic as! [String : AnyObject])
            self!.titles.append(title)
            }
            
           self!.setupUI()
            
        }
        
    }
    
    /// 设置 UI
    private func setupUI() {
        // 添加滚动视图
        addSubview(scrollView)
        // 添加按钮
        addSubview(addButton)
        // 布局
        scrollView.snp_makeConstraints { (make) in
            make.left.top.bottom.equalTo(self)
            make.right.equalTo(addButton.snp_left)
        }
        
        addButton.snp_makeConstraints { (make) in
            make.top.bottom.right.equalTo(self)
            make.width.equalTo(30)
        }
        
        /// 添加 label
        setupTitlesLable()
        /// 设置 label 的位置
        setupLabelsPosition()
        // 保存 titles 数组
        titlesClosure?(titleArray: titles)
    }
    
    /// 暴露给外界，告知外界点击了哪一个 titleLabel
    func didSelectTitleLableClosure(closure:(titleLabel: WKTitleLabel)->()) {
        didSelectTitleLable = closure
    }
    
    /// 暴露给外界，向外界传递 topic 数组
    func titleArrayClosure(closure: (titleArray: [HomeTopTitle])->()) {
        titlesClosure = closure
    }
    
    /// 设置添加右边按钮
    private lazy var addButton: UIButton = {
        let addButton = UIButton()
        addButton.setImage(UIImage(named: "add_channel_titlbar_16x16_"), forState: .Normal)
        addButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        addButton.addTarget(self, action: #selector(addButtonClick), forControlEvents: .TouchUpInside)
        return addButton
    }()
    
    /// 右边添加按钮点击
    func addButtonClick() {
        addBtnClickClosure?()
    }
    /// 添加按钮闭包
    func addButtonClickClosure(closure:()->()) {
        addBtnClickClosure = closure
    }
    
    /// 设置滚动视图
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        return scrollView
    }()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ScrollTitleView {
    
    /// 添加 label
    private func setupTitlesLable() {
        for (index, topic) in titles.enumerate() {
            let label = WKTitleLabel()
            label.text = topic.name
            label.tag = index
            label.textColor = KColor(235, g: 235, b: 235, a: 1.0)
            label.textAlignment = .Center
            label.userInteractionEnabled = true
            let tap = UITapGestureRecognizer(target: self, action: #selector(titleLabelOnClick(_:)))
            label.addGestureRecognizer(tap)
            label.font = UIFont.systemFontOfSize(17)
            label.sizeToFit()
            label.width += kMargin
            labels.append(label)
            labelWidths.append(label.width)
            scrollView.addSubview(label)
        }
        let currentLabel = labels[currentIndex]
        currentLabel.textColor = UIColor.whiteColor()
        currentLabel.currentScale = 1.1
    }
    
    /// 设置 label 的位置
    private func setupLabelsPosition() {
        var titleX: CGFloat = 0.0
        let titleY: CGFloat = 0.0
        var titleW: CGFloat = 0.0
        let titleH = self.height
        
        for (index, label) in labels.enumerate() {
            titleW = labelWidths[index]
            titleX = kMargin
            if index != 0 {
                let lastLabel = labels[index - 1]
                titleX = CGRectGetMaxX(lastLabel.frame) + kMargin
            }
            label.frame = CGRectMake(titleX, titleY, titleW, titleH)
        }
        /// 设置 contentSize
        if let lastLabel = labels.last {
            scrollView.contentSize = CGSizeMake(CGRectGetMaxX(lastLabel.frame), 0)
        }
    }
    
    /// 标题点击的方法
    func titleLabelOnClick(tap: UITapGestureRecognizer) {
        guard let  currentLabel = tap.view as? WKTitleLabel else {
            return
        }
        oldIndex = currentIndex
        currentIndex = currentLabel.tag
        let oldLabel = labels[oldIndex]
        oldLabel.textColor = KColor(235, g: 235, b: 235, a: 1.0)
        oldLabel.currentScale = 1.0
        currentLabel.textColor = UIColor.whiteColor()
        currentLabel.currentScale = 1.1
        // 改变 label 的位置
        adjustTitleOffSetToCurrentIndex(currentIndex, oldIndex: oldIndex)
        didSelectTitleLable?(titleLabel: currentLabel)
    }
    
    /// 当点击标题的时候，检查是否需要改变 label 的位置
    func adjustTitleOffSetToCurrentIndex(currentIndex: Int, oldIndex: Int) {
        guard oldIndex != currentIndex else {
            return
        }
        // 重新设置 label 的状态
        let oldLabel = labels[oldIndex]
        let currentLabel = labels[currentIndex]
        currentLabel.currentScale = 1.1
        currentLabel.textColor = UIColor.whiteColor()
        oldLabel.textColor = KColor(235, g: 235, b: 235, a: 1.0)
        oldLabel.currentScale = 1.0
        // 当前偏移量
        var offsetX = currentLabel.centerX - SCREENW * 0.5
        if offsetX < 0 {
            offsetX = 0
        }
        // 最大偏移量
        var maxOffsetX = scrollView.contentSize.width - (SCREENW - addButton.width)
        
        if maxOffsetX < 0 {
            maxOffsetX = 0
        }
        
        if offsetX > maxOffsetX {
            offsetX = maxOffsetX
        }
        scrollView.setContentOffset(CGPointMake(offsetX, 0), animated: true)
    }
    
    /// 重写 frame
    override var frame: CGRect {
        didSet {
            let newFrame = CGRectMake(0, 0, SCREENW, 44)
            super.frame = newFrame
        }
    }
}

class WKTitleLabel: UILabel {
    /// 用来记录当前 label 的缩放比例
    var currentScale: CGFloat = 1.0 {
        didSet {
            transform = CGAffineTransformMakeScale(currentScale, currentScale)
        }
    }


}
