//
//  TCVerticalButton.swift
//  TCSwiftProjectDemo
//
//  Created by Chris on 2017/10/13.
//  Copyright © 2017年 Chris. All rights reserved.
//

import UIKit
import Kingfisher

class TCVerticalButton: UIButton {
    
    var imgURL:String? {
        didSet {
            imageView?.kf.setImage(with: imgURL as! Resource)
        }
    }
    
    var textName:String? {
        didSet {
            titleLabel?.text = textName;
        }
    }
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        titleLabel?.textAlignment = .center
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        // 调整图片
        imageView?.x = 10
        imageView?.y = 0
        imageView?.width = self.width - 20
        imageView?.height = imageView!.width
        // 调整文字
        titleLabel?.x = 0
        titleLabel?.y = imageView!.height
        titleLabel?.width = self.width
        titleLabel?.height = self.height - self.titleLabel!.y
    }

}
