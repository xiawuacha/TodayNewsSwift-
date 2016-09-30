//
//  HomeMiddleCell.swift
//  TodayNews
//
//  Created by 汪凯 on 16/9/30.
//  Copyright © 2016年 汪凯. All rights reserved.
////  右边显示一张图片的情况

import UIKit

class HomeMiddleCell: HomeBaseTopicCell {

    
    /// 右下角的视频时长
    private lazy var timeButton: UIButton = {
        let timeButton = UIButton()
        timeButton.hidden = true
        timeButton.userInteractionEnabled = false
        timeButton.layer.cornerRadius = 8
        timeButton.layer.masksToBounds = true
        timeButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        timeButton.titleLabel?.font = UIFont.systemFontOfSize(12)
        timeButton.setImage(UIImage(named: "palyicon_video_textpage_7x10_"), forState: .Normal)
        return timeButton
    }()
    
    /// 右边图片
    private lazy var rightImageView: UIImageView = {
        let rightImageView = UIImageView()
        rightImageView.backgroundColor = UIColor.lightGrayColor()
        return rightImageView
    }()

    
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(rightImageView)
        
        addSubview(timeButton)
        
        timeButton.snp_makeConstraints { (make) in
            make.right.equalTo(rightImageView.snp_right).offset(-5)
            make.bottom.equalTo(rightImageView.snp_bottom).offset(-5)
        }
        
        rightImageView.snp_makeConstraints { (make) in
            make.top.equalTo(self).offset(kHomeMargin)
            make.size.equalTo(CGSizeMake(108, 70))
            make.right.equalTo(self).offset(-kHomeMargin)
        }
        
        titleLabel.snp_remakeConstraints { (make) in
            make.right.equalTo(rightImageView.snp_left).offset(-kHomeMargin)
            make.left.top.equalTo(self).offset(kHomeMargin)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    //重写set方法
    var newsTopic: NewsTopicModel? {
        didSet{
            
            titleLabel.text = String(newsTopic!.title!)
            timeLabel.text = NSString.changeDateTime(newsTopic!.publish_time!)
            if let sourceAvatar = newsTopic?.source_avatar {
                nameLabel.text = newsTopic!.source
                avatarImageView.setCircleHeader(sourceAvatar)
                rightImageView.kf_setImageWithURL(NSURL(string: sourceAvatar)!)
            }
            
            if let mediaInfo = newsTopic!.media_info {
                nameLabel.text = mediaInfo.name
                avatarImageView.setCircleHeader(mediaInfo.avatar_url!)
                rightImageView.kf_setImageWithURL(NSURL(string: mediaInfo.avatar_url!)!)
            }
            
            if let commentCount = newsTopic!.comment_count {
                commentCount >= 10000 ? (commentLabel.text = "\(commentCount / 10000)万评论") : (commentLabel.text = "\(commentCount)评论")
            } else {
                commentLabel.hidden = true
            }
            
            if (newsTopic!.titleH + avatarImageView.height + kMargin) < newsTopic?.imageH {
                closeButton.snp_remakeConstraints(closure: { (make) in
                    make.right.equalTo(rightImageView.snp_left).offset(-kHomeMargin)
                    make.centerY.equalTo(avatarImageView)
                    make.size.equalTo(CGSizeMake(17, 12))
                })
            }
            filterWords = newsTopic?.filter_words
            let url = newsTopic!.middle_image?.url
            rightImageView.kf_setImageWithURL(NSURL(string: url!)!)
            
            if let label = newsTopic?.label {
                stickLabel.setTitle(" \(label) ", forState: .Normal)
                stickLabel.hidden = false
            }

        }
        
    }
    
    
    
    /// 举报按钮点击
    override func closeBtnClick() {
        closeButtonClosure?(filterWords: filterWords!)
    }
    
    /// 举报按钮点击回调
    func closeButtonClick(closure:(filterWord: [FilterWord])->()) {
        closeButtonClosure = closure
    }
    

}
