//
//  PhotoManager.m
//  yueta
//
//  Created by David on 2017/4/27.
//  Copyright © 2017年 chase. All rights reserved.
//

#import "PhotoManager.h"
#import <MobileCoreServices/UTCoreTypes.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import <AVFoundation/AVFoundation.h>
#pragma mark -- 预定义 (define)

@interface PhotoManager()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (nonatomic,strong) UIViewController *currentVC;

@end

@implementation PhotoManager
#pragma mark -- 生命周期 (life cycle)=
+ (instancetype)sharedInstance
{
    static id sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

#pragma mark -- public
- (void)setShowVC:(UIViewController *)vc
{
    self.currentVC = vc;
}


-(void)showInVC:(UIViewController *)vc{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *photoAction = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self openCamera];
    }];
    UIAlertAction *albumAction = [UIAlertAction actionWithTitle:@"进入相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self openPhotoLibrary];
    }];
    [alertController addAction:cancelAction];
    [alertController addAction:photoAction];
    [alertController addAction:albumAction];
    
    self.currentVC = vc;
    
    [self.currentVC presentViewController:alertController animated:YES completion:nil];
}


#pragma mark -- 私有方法 (private methods)
- (void)openCamera
{
    AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if(status == AVAuthorizationStatusDenied)
    {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"警告" message:[NSString stringWithFormat:@"请在设置-隐私-相机中允许访问相机应用。"] preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            NSURL*url =[NSURL URLWithString:UIApplicationOpenSettingsURLString];
            [[UIApplication sharedApplication] openURL:url];
            
        }];
        [alert addAction:cancelAction];
        [alert addAction:okAction];
        [self.currentVC presentViewController:alert animated:YES completion:nil];
    }
    //检查相机模式是否可用
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        return;
    }
    //获得相机模式下支持的媒体类型
    NSArray* availableMediaTypes = [UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypeCamera];
    BOOL canTakePicture = NO;
    for (NSString* mediaType in availableMediaTypes)
    {
        if ([mediaType isEqualToString:(NSString*)kUTTypeImage])
        {
            //支持拍照
            canTakePicture = YES;
            break;
        }
    }
    
    //检查是否支持拍照
    if (!canTakePicture)
    {
        return;
    }
    //创建图像选取控制器
    UIImagePickerController* imagePickerController = [[UIImagePickerController alloc] init];
    //设置图像选取控制器的来源模式为相机模式
    imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
    //设置图像选取控制器的类型为静态图像
    imagePickerController.mediaTypes = [[NSArray alloc] initWithObjects:(NSString*)kUTTypeImage, nil];
    //允许用户进行编辑
    imagePickerController.allowsEditing = !self.editNoEnable;
    //设置委托对象
    imagePickerController.delegate = self;
    [self.currentVC presentViewController:imagePickerController animated:YES completion:nil];
    
}

- (void)openPhotoLibrary
{
    ALAuthorizationStatus author = [ALAssetsLibrary authorizationStatus];
    if (author == ALAuthorizationStatusRestricted || author ==ALAuthorizationStatusDenied)
    {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"警告" message:[NSString stringWithFormat:@"请在设置-隐私-照片中允许访问照片应用。"] preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            NSURL*url =[NSURL URLWithString:UIApplicationOpenSettingsURLString];
            [[UIApplication sharedApplication] openURL:url];
            
        }];
        [alert addAction:cancelAction];
        [alert addAction:okAction];
        [self.currentVC presentViewController:alert animated:YES completion:nil];
    }
    UIImagePickerController *imagePC = [[UIImagePickerController alloc] init];
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary] == YES)
    {
        imagePC.delegate = self;
        imagePC.allowsEditing = !self.editNoEnable;
        [self.currentVC presentViewController:imagePC animated:YES completion:nil];
    }
}

#pragma mark -- 数据源和代理方法 (DataSource Delegate)
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    
    //手动隐藏Nav
    if (self.isHideNavigationBar) {
//        [[NSNotificationCenter defaultCenter] postNotificationName:kNotification_SetNavigationBarHide object:nil];
    }
    
    [picker dismissViewControllerAnimated:YES completion:^(){
        
    }];
}

//返回选取的图片
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    //手动隐藏Nav
    if (self.isHideNavigationBar) {
//        [[NSNotificationCenter defaultCenter] postNotificationName:kNotification_SetNavigationBarHide object:nil];
    }
    
    UIImage *image;
    NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
    if ([mediaType isEqualToString:@"public.image"])
    {
        if (self.editNoEnable == YES) {
            image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
        }else{
            image = [info objectForKey:@"UIImagePickerControllerEditedImage"];
        }
        
        NSData *imageData = UIImageJPEGRepresentation(image, 0.1);
        UIImage *img = [[UIImage alloc] initWithData:imageData];
        
        [picker dismissViewControllerAnimated:YES completion:^{
            if ([self.delegate respondsToSelector:@selector(photoManager:didFinishPickedPhotoData:img:)])
            {
                [self.delegate photoManager:self didFinishPickedPhotoData:imageData img:img];
            }
        }];
    }
}

- (void)image:(UIImage*)image didFinishSavingWithError:(NSError*)error contextInfo:(void*)contextInfo{
    if (!error)
    {
        NSData *imageData = UIImageJPEGRepresentation(image, 0.1);
        UIImage *img = [[UIImage alloc] initWithData:imageData];
        if ([self.delegate respondsToSelector:@selector(photoManager:didFinishPickedPhotoData:img:)])
        {
             [self.delegate photoManager:self didFinishPickedPhotoData:imageData img:img];
        }
    }
}

#pragma mark -- getter and setter


@end
