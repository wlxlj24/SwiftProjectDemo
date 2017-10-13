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
let TSAppDelegate = UIApplication.shared.delegate as! AppDelegate

// 沙盒文档路径
let kSandDocumentPath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).last!

/// RGBA的颜色设置
func TCColor(r:CGFloat, g:CGFloat, b:CGFloat, a:CGFloat) -> UIColor {
    return UIColor(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: a)
}

