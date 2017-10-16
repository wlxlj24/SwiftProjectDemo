//
//  TCUserCenter.swift
//  TCSwiftProjectDemo
//
//  Created by Chris on 2017/10/16.
//  Copyright © 2017年 Chris. All rights reserved.
//

import UIKit
import SwiftyJSON

class TCUserCenter: NSObject {
    
    private var userName:String?
    public var token:String?
    public var isLogin:Bool {
        get {
            return UserDefaults.standard.bool(forKey: "isLogin")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "isLogin")
        }
    }
    
}

extension TCUserCenter {
    
    class var sharedInstance : TCUserCenter {
        struct Static {
            static let instance : TCUserCenter = TCUserCenter()
        }
        return Static.instance
    }
    
    /// 用户登录
    ///
    /// - Parameter result: 登录成功后传进来的字典
    func userLoginSuccess(_ result:JSON) -> Void {
        
    }
    
    /// 用户退出登录
    private func userLoginout() -> Void {
        
    }
    
    /// 显示登录界面(内部调用 用户退出登录,清空数据接口)
    func presntLoginVC() -> Void {
        
    }
    
}
