//
//  ViewController.swift
//  TCSwiftProjectDemo
//
//  Created by Chris on 2017/10/13.
//  Copyright © 2017年 Chris. All rights reserved.
//

import UIKit

class ViewController: UIViewController,PhotoManagerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let photoManager = PhotoManager()
        photoManager.show(inVC: self)
    }

    func photoManager(_ manager: PhotoManager!, didFinishPickedPhotoData imageData: Data!, img: UIImage!) {
        //update to oss
//        let oss = TCUpdateOSSUtil()
//        oss.setupOSS()
//        oss.updateImageToOSS(withImageArr: [img], completeBlcok: { (correctImagePathArr) in
//
//        }) { (error) in
//
//        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

