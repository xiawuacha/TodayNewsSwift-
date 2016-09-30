//
//  NewsTopicModel.swift
//  TodayNews
//
//  Created by 汪凯 on 16/9/30.
//  Copyright © 2016年 汪凯. All rights reserved.
//

import UIKit

class NewsTopicModel: NSObject {

    
    // 文字的高度(自定义的一些属性)
    var titleH: CGFloat = 0
    var titleW: CGFloat = 0
    var imageW: CGFloat = 0
    var imageH: CGFloat = 0
    var cellHeight: CGFloat = 0
    
    
    
    
    
    /// 标题
    var abstract: String?
    /// 关键字
    var keywords: String?
    /// 标题
    var title: NSString?
    
    /// 置顶
    var label: String?
    
    /// 置顶文章url
    var article_alt_url: String?
    /// 文章对应的url
    var article_url: String?
    /// 展示的url
    var display_url: String?
    /// 分享的url
    var share_url: String?
    /// 地址
    var url: String?
    
    var item_id: Int?
    
    var tag_id: Int?
    var tag: String?
    
    var read_count: Int?
    var comment_count: Int?
    var repin_count: Int?
    var digg_count: Int?
    
    var publish_time: Int?
    
    var source: String?
    var source_avatar: String?
    var stick_label: String?
    
    var gallary_image_count: Int?
    var group_id: Int?
    
    var has_image: Bool?
    var has_m3u8_video: Bool?
    var has_mp4_video: Bool?
    var has_video: Bool?
    
    var video_detail_info: VideoDetailInfo?
    
    var video_style: Int?
    var video_duration: Int?
    var video_id: Int?
    
    // 点击 『x』 按钮，弹出框内容
    var filter_words = [FilterWord]()
    
    var image_list = [ImageList]()
    var middle_image: MiddleImage?
    var large_image_list = [LargeImageList]()
    
    var behot_time: Int?
    
    var cell_flag: Int?
    var bury_count: Int?
    
    var article_type: Int?
    
    var cursor: Int?
    
    var media_info: MediaInfo?

    
    init(dict: [String: AnyObject]) {
        super.init()
        
        cursor = dict["cursor"] as? Int
        
        article_type = dict["article_type"] as? Int
        
        url = dict["url"] as? String
        article_url = dict["article_url"] as? String
        article_alt_url = dict["article_alt_url"] as? String
        
        bury_count = dict["bury_count"] as? Int
        cell_flag = dict["cell_flag"] as? Int
        behot_time = dict["behot_time"] as? Int
        
        has_video = dict["has_video"] as? Bool
        has_mp4_video = dict["has_mp4_video"] as? Bool
        has_m3u8_video = dict["has_m3u8_video"] as? Bool
        has_image = dict["has_image"] as? Bool
        
        video_duration = dict["video_duration"] as? Int
        video_id = dict["video_id"] as? Int
        video_style = dict["video_style"] as? Int
        
        group_id = dict["group_id"] as? Int
        gallary_image_count = dict["gallary_image_count"] as? Int
        
        tag = dict["tag"] as? String
        tag_id = dict["tag_id"] as? Int
        item_id = dict["item_id"] as? Int
        
        read_count = dict["read_count"] as? Int
        comment_count = dict["comment_count"] as? Int
        repin_count = dict["repin_count"] as? Int
        digg_count = dict["digg_count"] as? Int
        
        publish_time = dict["publish_time"] as? Int
        
        keywords = dict["keywords"] as? String
        abstract = dict["abstract"] as? String
        
        source = dict["source"] as? String
        source_avatar = dict["source_avatar"] as? String
        stick_label = dict["stick_label"] as? String
        
        label = dict["label"] as? String
        
        /// 遍历举报的内容
        if let filterWords = dict["filter_words"] as? [AnyObject] {
            for item in filterWords {
                let filterWord = FilterWord(dict: item as! [String: AnyObject])
                filter_words.append(filterWord)
            }
        }
        
        title = dict["title"] as? NSString
        
        if let mediaDict = dict["media_info"] {
            media_info = MediaInfo(dict: mediaDict as! [String: AnyObject])
        }
        
        if let videoDetailInfo = dict["video_detail_info"] {
            video_detail_info = VideoDetailInfo(dict: videoDetailInfo as! [String : AnyObject])
        }
        
        if let middleImage = dict["middle_image"] {
            middle_image = MiddleImage(dict: middleImage as! [String: AnyObject])
        }
        
        let largeImageLists = dict["large_image_list"] as? [AnyObject]
        let imageLists = dict["image_list"] as? [AnyObject]
        
        
        //MARK:对于图片的处理 
        if imageLists == nil || imageLists?.count == 0 {
            // 再判断 middle_image 是否为空
            if middle_image?.height != nil {  // 大图、视频图片或广告
                // 如果 large_image_list 或 video_detail_info 不为空，则显示一张大图 (SCREENW -30)×170，文字在上边
                // 再判断 video_detail_info 是否为空
                if video_detail_info?.video_id != nil || largeImageLists?.count > 0 {
                    imageW = SCREENW - CGFloat(30)
                    imageH = 170
                    titleW = SCREENW - 30
                    titleH = NSString.boundingRectWithString(title!, size: CGSizeMake(titleW, CGFloat(MAXFLOAT)), fontSize: 17)
                    // 中间有一张大图（包括视频和广告的图片），cell 的高度 = 底部间距 + 标题的高度 + 中间间距 + 图片高度 + 中间间距 + 用户头像的高度 + 底部间距
                    cellHeight = 2 * kHomeMargin + titleH + imageH + 2 * kMargin + 16
                    if largeImageLists?.count > 0 {
                        for index in largeImageLists! {
                            let largeImage = LargeImageList(dict: index as! [String : AnyObject])
                            large_image_list.append(largeImage)
                        }
                    }
                } else {
                    // 如果 middle_image 不为空，则在 cell 显示一张图片 70 × 108，文字在左边，图片在右边
                    // 说明是右边图
                    imageW = 108
                    // 图片在右边的情况和有三张图片的情况，为了计算简单，图片的高度设置为相等
                    imageH = 70
                    // 文字宽度 SCREENW - 108 - 30 - 20
                    titleW = SCREENW - 158
                    titleH = NSString.boundingRectWithString(title!, size: CGSizeMake(titleW, CGFloat(MAXFLOAT)), fontSize: 17)
                    // 比较标题和图片的高度哪个大，那么 cell 的高度就根据大的计算
                    // 右边有一张图片，cell 的高度 = 底部间距 + 标题的高度 + 中间的间距 + 用户头像的高度 + 底部间距
                    cellHeight = (titleH + 16 + kMargin >= imageH) ? (2 * kHomeMargin + titleH + kMargin + 16):(2 * kHomeMargin + imageH)
                }
            } else { // 没有图片,也不是视频
                titleW = SCREENW - 30
                titleH = NSString.boundingRectWithString(title!, size: CGSizeMake(titleW, CGFloat(MAXFLOAT)), fontSize: 17)
                // 没有图片，cell 的高度 = 底部间距 + 标题的高度 + 中间的间距 + 用户头像的高度 + 底部间距
                cellHeight = 2 * kHomeMargin + titleH + kMargin + 16
            }
        } else {
            // 如果 image_list 不为空，则显示 3 张图片 ((SCREENW -30 -12) / 3)×70，文字在上边
            // 循环遍历 image_list
            for item in imageLists! {
                let imageList = ImageList(dict: item as! [String: AnyObject])
                image_list.append(imageList)
            }
            imageW = (SCREENW - CGFloat(42)) / 3
            imageH = 70
            // 文字的宽度 SCREENW-30
            titleW = SCREENW - 30
            titleH = NSString.boundingRectWithString(title!, size: CGSizeMake(titleW, CGFloat(MAXFLOAT)), fontSize: 17)
            cellHeight = 2 * kHomeMargin + titleH + imageH + 2 * kMargin + 16
        }
    }
}


//MARK:MediaInfo模型
class MediaInfo: NSObject {
    
    var avatar_url: String?
    var name: String?
    var media_id: Int?
    var user_verified: Int?
    
    init(dict: [String: AnyObject]) {
        super.init()
        avatar_url = dict["avatar_url"] as? String
        name = dict["name"] as? String
        user_verified = dict["user_verified"] as? Int
        media_id = dict["media_id"] as? Int
    }
}

//MARK:弹出文字FilterWord模型
class FilterWord: NSObject {
    
    var id: String?
    
    var is_selected: Bool?
    
    var name: String?
    
    init(dict: [String: AnyObject]) {
        super.init()
        id = dict["id"] as? String
        name = dict["name"] as? String
        is_selected = dict["is_selected"] as? Bool
    }
}


//MARK:突变数组ImageList模型
class ImageList: NSObject {
    
    var height: Int?
    var width: Int?
    
    var url: String?
    
    var url_list: [[String: AnyObject]]?
    
    init(dict: [String: AnyObject]) {
        super.init()
        height = dict["hight"] as? Int
        width = dict["width"] as? Int
        url = dict["url"] as? String
        url_list = dict["url_list"] as? [[String: AnyObject]] ?? [[:]]
    }
}

//MARK:中等图MiddleImage模型
class MiddleImage: NSObject {
    
    var height: Int?
    var width: Int?
    
    var url: String?
    
    var url_list: [[String: AnyObject]]?
    
    init(dict: [String: AnyObject]) {
        super.init()
        height = dict["height"] as? Int
        width = dict["width"] as? Int
        if let urlString = dict["url"] as? String {
            if urlString.hasSuffix(".webp") {
                let range = urlString.rangeOfString(".webp")
                url = urlString.substringToIndex(range!.startIndex)
            } else {
                url = urlString
            }
        }
        url_list = dict["url_list"] as? [[String: AnyObject]] ?? [[:]]
    }
}
//MARK:大图
class LargeImageList: NSObject {
    
    var height: Int?
    var width: Int?
    
    var url: String?
    
    var url_list: [[String: AnyObject]]?
    
    init(dict: [String: AnyObject]) {
        super.init()
        height = dict["height"] as? Int
        width = dict["width"] as? Int
        url = dict["url"] as? String
        url_list = dict["url_list"] as? [[String: AnyObject]] ?? [[:]]
    }
}

//MARK:详情信息
class VideoDetailInfo: NSObject {
    
    var direct_play: Int?
    var group_flags: Int?
    var show_pgc_subscribe: Int?
    var video_id: String?
    var video_preloading_flag: Bool?
    var video_type: Int?
    var video_watch_count: Int?
    var video_watching_count: Int?
    var detail_video_large_image: DetailVideoLargeImage?
    
    init(dict: [String: AnyObject]) {
        super.init()
        video_watching_count = dict["video_watching_count"] as? Int
        video_watch_count = dict["video_watch_count"] as? Int
        video_type = dict["video_type"] as? Int
        video_preloading_flag = dict["video_preloading_flag"] as? Bool
        video_id = dict["video_id"] as? String
        direct_play = dict["direct_play"] as? Int
        group_flags = dict["group_flags"] as? Int
        show_pgc_subscribe = dict["show_pgc_subscribe"] as? Int
        detail_video_large_image = DetailVideoLargeImage(dict: dict["detail_video_large_image"] as! [String: AnyObject])
    }
}

//MARK:详情个大图
class DetailVideoLargeImage: NSObject {
    
    var height: Int?
    var width: Int?
    
    var url: String?
    
    var url_list = [[String: AnyObject]]()
    
    init(dict: [String: AnyObject]) {
        super.init()
        height = dict["height"] as? Int
        width = dict["width"] as? Int
        url = dict["url"] as? String
        url_list = dict["url_list"] as? [[String: AnyObject]] ?? [[:]]
    }
}
