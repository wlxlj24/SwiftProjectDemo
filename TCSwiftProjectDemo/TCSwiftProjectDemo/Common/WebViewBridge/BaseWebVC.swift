//
//  BaseWebVC.swift
//  TCSwiftProjectDemo
//
//  Created by Chris on 2017/10/13.
//  Copyright © 2017年 Chris. All rights reserved.
//

import UIKit
import WebKit
import WebViewJavascriptBridge

class BaseWebVC: UIViewController ,WKNavigationDelegate,WKUIDelegate{

    private var bridge:WKWebViewJavascriptBridge = WKWebViewJavascriptBridge()
    
    private var webView:WKWebView = WKWebView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let webConfiguration = WKWebViewConfiguration()
        let myURL = URL(string: "https://h.d.weknet.cn/identity.html")
        webView = WKWebView(frame: self.view.bounds, configuration: webConfiguration)
        let myRequest = URLRequest(url: myURL!)
        
        view.addSubview(webView)
        webView.snp.makeConstraints { (make) in
            make.left.top.bottom.right.equalTo(view)
        }
        
        //bride
        bridge = WKWebViewJavascriptBridge.init(for: webView)
        bridge.setWebViewDelegate(self)
        
        bridge.registerHandler(WebViewBridgeName.getAuth) { (data, responseCallback) in
            responseCallback!(["token":TCUserCenter.sharedInstance.token])
        }
        bridge.registerHandler(WebViewBridgeName.hideNavigationBar) { (data, responseCallback) in
            self.navigationController?.navigationBar.alpha = 0
        }
        
        webView.load(myRequest)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    
}
