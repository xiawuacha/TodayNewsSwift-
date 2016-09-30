//
//  HomeNoImageCell.swift
//  TodayNews
//
//  Created by 汪凯 on 16/9/30.
//  Copyright © 2016年 汪凯. All rights reserved.
//

import UIKit

class HomeNoImageCell: HomeBaseTopicCell {

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    
    /// 重写set方法
    var newsTopic: NewsTopicModel? {
        didSet{
            
            titleLabel.text = String(newsTopic!.title!)
            if let publishTime = newsTopic?.publish_time {
                timeLabel.text = NSString.changeDateTime(publishTime)
            }
            
            if let sourceAvatar = newsTopic?.source_avatar {
                nameLabel.text = newsTopic!.source
                avatarImageView.setCircleHeader(sourceAvatar)
            }
            
            if let mediaInfo = newsTopic!.media_info {
                nameLabel.text = mediaInfo.name
                avatarImageView.setCircleHeader(mediaInfo.avatar_url!)
            }
            
            if let commentCount = newsTopic!.comment_count {
                commentCount >= 10000 ? (commentLabel.text = "\(commentCount / 10000)万评论") : (commentLabel.text = "\(commentCount)评论")
            } else {
                commentLabel.hidden = true
            }
            
            filterWords = newsTopic?.filter_words
            if let label = newsTopic?.label {
                stickLabel.setTitle(" \(label) ", forState: .Normal)
                stickLabel.hidden = false
                closeButton.hidden = (label == "置顶") ?  true : false
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
