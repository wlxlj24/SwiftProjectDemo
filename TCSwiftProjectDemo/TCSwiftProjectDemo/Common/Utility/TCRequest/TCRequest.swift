//
//  TCRequest.swift
//  TCSwiftProjectDemo
//
//  Created by Chris on 2017/10/13.
//  Copyright © 2017年 Chris. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SVProgressHUD

//简写的 key->value
public typealias tc_parameters = [String : String]?
public typealias CompleteClosure = (JSON) ->Void
public typealias FailureClosure = (NSError) -> Void

let timeoutInterval:TimeInterval = 30;

class TCRequest: NSObject {
    
    private class func requestWith(URL:String,
                     paras:tc_parameters,
                     headerField:HTTPHeaders,
                     httpMethod:HTTPMethod,
                     complete:@escaping (DataResponse<Any>)->Void) -> () {
        
        let URL = TCConfig.baseURL + URL
        
        let config:URLSessionConfiguration = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = timeoutInterval
        let sessionManager = Alamofire.SessionManager(configuration: config)
        
        sessionManager
            .request(URL, method:httpMethod , parameters: paras, encoding: URLEncoding.default, headers: headerField)
            .responseJSON(completionHandler: complete)
    }
    
}


extension TCRequest {
    
    
    /// POST With headers
    ///
    /// - Parameters:
    ///   - URL: URL地址
    ///   - paras: 参数
    ///   - success: 成功回调
    ///   - failure: 失败回调
    ///   - error: 网络错误回调
    class func requestPOSTWith(URL:String,
                         paras:tc_parameters,
                         success:@escaping CompleteClosure,
                         failure:@escaping CompleteClosure,
                         error:@escaping FailureClosure) -> () {
        
        let headers:HTTPHeaders = requestHeaders()
        
        requestWith(URL: URL, paras: paras, headerField: headers, httpMethod: .post) { (response) in
            guard response.result.isSuccess else {
                //failure
                let errors = response.result.error! as NSError
                let errorString = self.handleError(error: errors)
                SVProgressHUD.showError(withStatus: errorString)
                error(errors)
                
                return
            }
            if let value = response.result.value {
                let dict = JSON(value)
                let code = dict["code"].intValue
                if (code == 1){
                    //success
                    if let value = response.result.value {
                        success(JSON(value))
                    }
                    
                }else{
                    failure(JSON(value))
                }
                
            }
        }
        
    }
    
    class func requestGETWith(URL:String,
                         paras:tc_parameters,
                         success:@escaping CompleteClosure,
                         failure:@escaping CompleteClosure,
                         error:@escaping FailureClosure) -> () {
        
        let headers:HTTPHeaders = requestHeaders()
        
        requestWith(URL: URL, paras: paras, headerField: headers, httpMethod: .get) { (response) in
            guard response.result.isSuccess else {
                //failure
                let errors = response.result.error! as NSError
                let errorString = handleError(error: errors)
                SVProgressHUD.showError(withStatus: errorString)
                error(errors)
                
                return
            }
            if let value = response.result.value {
                let dict = JSON(value)
                let code = dict["code"].intValue
                if (code == 1){
                    //success
                    if let value = response.result.value {
                        success(JSON(value))
                    }
                }else{
                    failure(JSON(value))
                }
                
            }
        }
        
    }
    
    
    
    private class func handleError(error:NSError) -> String {
        if (error.code >= 0) {
            return "服务器异常,请稍后重试或联系客服"
        }else if(error.code == -1009) {
            return "似乎已断开与互联网的连接"
        }else if(error.code == -1001) {
            return "请求超时,请重试"
        }else{
            return "网络异常,请重试"
        }
    }
    
    
    private class func requestHeaders() -> Dictionary<String,String> {
        return ["device":"iOS",
                "network":"",
                "version":"",
                "Accept":""]
    }
    
    
}

