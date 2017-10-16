//
//  TCDefine.swift
//  TCSwiftProjectDemo
//
//  Created by Chris on 2017/10/13.
//  Copyright © 2017年 Chris. All rights reserved.
//

import Foundation
import UIKit

//delegate 代理
let APPDELEGATE = UIApplication.shared.delegate as! AppDelegate
let WINDOW_MAIN = APPDELEGATE.window
let kScreenWidth = UIScreen.main.bounds.size.width
let kScreenHeight = UIScreen.main.bounds.size.height

// 沙盒文档路径
let kSandDocumentPath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).last!

/// RGBA的颜色设置
func TCColor(r:CGFloat, g:CGFloat, b:CGFloat, a:CGFloat) -> UIColor {
    return UIColor(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: a)
}

public typealias TCParas0Callback = () -> ()
public typealias TCParas1Callback = (_ para:AnyObject) -> ()
public typealias TCParas2Callback = (_ para1:AnyObject,_ para2:AnyObject) -> ()
public typealias TCParas3Callback = (_ para1:AnyObject,_ para2:AnyObject,_ para3:AnyObject) -> ()
public typealias TCParas4Callback = (_ para1:AnyObject,_ para2:AnyObject,_ para3:AnyObject,_ para4:AnyObject) -> ()

