//
//  HomeLargeCell.swift
//  TodayNews
//
//  Created by 汪凯 on 16/9/30.
//  Copyright © 2016年 汪凯. All rights reserved.
//

import UIKit

class HomeLargeCell: HomeBaseTopicCell {

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(largeImageView)
        
        largeImageView.addSubview(rightBottomLabel)
        
        largeImageView.addSubview(playButton)
        
        largeImageView.snp_makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp_bottom).offset(kMargin)
            make.left.equalTo(titleLabel.snp_left)
            make.right.equalTo(titleLabel.snp_right)
            make.size.equalTo(CGSizeMake(SCREENW - 30, 170))
        }
        
        rightBottomLabel.snp_makeConstraints { (make) in
            make.size.equalTo(CGSizeMake(50, 20))
            make.right.equalTo(largeImageView.snp_right).offset(-7)
            make.bottom.equalTo(largeImageView.snp_bottom).offset(-7)
        }
        
        playButton.snp_makeConstraints { (make) in
            make.center.equalTo(largeImageView)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// 中间的播放按钮
    private lazy var playButton: UIButton = {
        let playButotn = UIButton()
        playButotn.setImage(UIImage(named: "playicon_video_60x60_"), forState: .Normal)
        playButotn.sizeToFit()
        playButotn.addTarget(self, action: #selector(playButtonClick), forControlEvents: .TouchUpInside)
        return playButotn
    }()
    
    /// 右下角显示图片数量或视频时长
    lazy var  rightBottomLabel: UILabel = {
        let rightBottomLabel = UILabel()
        rightBottomLabel.textAlignment = .Center
        rightBottomLabel.layer.cornerRadius = 10
        rightBottomLabel.layer.masksToBounds = true
        rightBottomLabel.font = UIFont.systemFontOfSize(13)
        rightBottomLabel.textColor = UIColor.whiteColor()
        rightBottomLabel.backgroundColor = KColor(0, g: 0, b: 0, a: 0.6)
        return rightBottomLabel
    }()
    
    /// 中间大图
    private lazy var largeImageView: UIImageView = {
        let largeImageView = UIImageView()
        largeImageView.backgroundColor = UIColor.lightGrayColor()
        return largeImageView
    }()
    

    /// 重写newsTopic的set方法
    var newsTopic: NewsTopicModel? {
        didSet{
        
            titleLabel.text = String(newsTopic!.title!)
            timeLabel.text = NSString.changeDateTime(newsTopic!.publish_time!)
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
            var urlString = String()
            
            if let videoDetailInfo = newsTopic?.video_detail_info {
                // 说明是视频
                urlString = videoDetailInfo.detail_video_large_image!.url!
                /// 格式化时间
                let minute = Int(newsTopic!.video_duration! / 60)
                let second = newsTopic!.video_duration! % 60
                rightBottomLabel.text = String(format: "%02d:%02d", minute, second)
            } else { // 说明是大图
                playButton.hidden = true
                urlString = newsTopic!.large_image_list.first!.url!
                rightBottomLabel.text = "\(newsTopic!.gallary_image_count!)图"
            }
            
            largeImageView.kf_setImageWithURL(NSURL(string: urlString)!)
            if let label = newsTopic?.label {
                if label == "" {
                    stickLabel.hidden = true
                } else {
                    stickLabel.setTitle(" \(label) ", forState: .Normal)
                    stickLabel.hidden = false
                }
            }

        
        }
    }
    
    
    
    /// 举报按钮点击
    override func closeBtnClick() {
        closeButtonClosure?(filterWords: filterWords!)
    }
    
    /// 播放按钮点击
    func playButtonClick() {
        
    }
    
    /// 举报按钮点击回调
    func closeButtonClick(closure:(filterWord: [FilterWord])->()) {
        closeButtonClosure = closure
    }

  

}
