//
//  HomeSearchBar.swift
//  TodayNews
//
//  Created by 汪凯 on 16/9/30.
//  Copyright © 2016年 汪凯. All rights reserved.
//

import UIKit
import SnapKit
class HomeSearchBar: UIView {

    lazy var searchBar: SearchBar = {
        let searchBar = SearchBar()
        searchBar.placeholder = "搜索"
        return searchBar
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = KGlobalColor()
        addSubview(searchBar)
        
        searchBar.snp_makeConstraints { (make) in
            make.size.equalTo(CGSizeMake(SCREENW - 30, 30))
            make.center.equalTo(self)
        }

}
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}



class SearchBar: UITextField {
        override init(frame: CGRect) {
            super.init(frame: frame)
            backgroundColor = UIColor.whiteColor()
            layer.cornerRadius = kCornerRadius
            layer.masksToBounds = true
            let searchIcon = UIImageView()
            font = UIFont.systemFontOfSize(15)
            searchIcon.image = UIImage(named: "search_discover_16x16_")
            searchIcon.width = 16
            searchIcon.height = 16
            leftView = searchIcon
            leftViewMode = .Always
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
}

