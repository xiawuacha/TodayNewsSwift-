//
//  NetworkTool.swift
//  TodayNews
//
//  Created by 汪凯 on 16/9/12.
//  Copyright © 2016年 汪凯. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import SVProgressHUD
import SwiftyJSON

class NetworkTool: NSObject {
    
    /// 单例
    static let shareNetworkTool =  NetworkTool()

    
    
    //有参数的 GET 请求
    func loadGETRequestDataInfo(url:String!,params:[String:AnyObject], finished:(dataDict:[String: JSON]) -> ()) {
        SVProgressHUD.showWithStatus("正在加载...")
        
        let URL = BASE_URL + url
        
        Alamofire
            .request(.GET, URL, parameters: params)
            .responseJSON { (response) in
                guard response.result.isSuccess else {
                    SVProgressHUD.showErrorWithStatus("加载失败...")
                    return
                }
                if let value = response.result.value {
                    let dict = JSON(value)
                    let message = dict["message"].stringValue
                    guard message != "success" else {
                        SVProgressHUD.showInfoWithStatus(message)
                        return
                    }
                    SVProgressHUD.dismiss()
                    let data = dict["data"].dictionary
                    finished(dataDict: data!)
                }
        }
    }
    
    
    
    //    无参数的 GET 请求
    func loadGETRequestDataInfoWithOutParmas(url:String!, finished:(dataDict:[String: JSON]) -> ()) {
        
        let URL = BASE_URL + url
        
        Alamofire
            .request(.GET, URL)
            .responseJSON { (response) in
                guard response.result.isSuccess else {
                    SVProgressHUD.showErrorWithStatus("加载失败...")
                    return
                }
                if let value = response.result.value {
                    let dict = JSON(value)
                    let code = dict["code"].intValue
                    let message = dict["message"].stringValue
                    guard code == RETURN_OK else {
                        SVProgressHUD.showInfoWithStatus(message)
                        return
                    }
                    let data = dict["data"].dictionary
                    finished(dataDict: data!)
                }
        }
    }
    
    
    //    无参数的 GET 请求 返回的是[String: AnyObject]类型
    func loadGETRequestDataInfoWithOutParmasWithAnyObject(url:String!, finished:(dataDict:[String: AnyObject]) -> ()) {
        
        let URL = BASE_URL + url
        
        Alamofire
            .request(.GET, URL)
            .responseJSON { (response) in
                guard response.result.isSuccess else {
                    SVProgressHUD.showErrorWithStatus("加载失败...")
                    return
                }
                if let value = response.result.value {
                    let dict = JSON(value)
                    let code = dict["code"].intValue
                    let message = dict["message"].stringValue
                    guard code == RETURN_OK else {
                        SVProgressHUD.showInfoWithStatus(message)
                        return
                    }
                    let data = dict["data"].dictionaryObject
                    finished(dataDict: data!)
                }
        }
    }
    

    

}
