//
//  PhotoManager.h
//  yueta
//
//  Created by David on 2017/4/27.
//  Copyright © 2017年 chase. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class PhotoManager;

@protocol PhotoManagerDelegate <NSObject>

@optional
- (void)photoManager:(PhotoManager *)manager didFinishPickedPhotoData:(NSData *)imageData img:(UIImage *)img;

@end

@interface PhotoManager : NSObject

+ (instancetype)sharedInstance;

@property (nonatomic,weak) id<PhotoManagerDelegate> delegate ;

- (void)showInVC:(UIViewController *)vc;
- (void)openPhotoLibrary;
- (void)setShowVC:(UIViewController *)vc;

@property (nonatomic,assign) BOOL editNoEnable;     //是否显示edit页面
@property (nonatomic,assign) BOOL isHideNavigationBar;  //是否隐藏nav bar

@end
