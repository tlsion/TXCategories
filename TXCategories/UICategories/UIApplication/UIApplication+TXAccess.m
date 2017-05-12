//
//  UIApplication+TXAccess.m
//  TXCategoriesDemo
//
//  Created by Eton on 2017/5/12.
//  Copyright © 2017年 王-庭协. All rights reserved.
//

#import "UIApplication+TXAccess.h"
#import <AVFoundation/AVFoundation.h>
#import <Photos/Photos.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import <CoreLocation/CoreLocation.h>
#import <UserNotifications/UserNotifications.h>

@implementation UIApplication (TXAccess)

+ (BOOL)tx_accessCamera{
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if (authStatus ==AVAuthorizationStatusRestricted ||//此应用程序没有被授权访问的照片数据。可能是家长控制权限
        authStatus ==AVAuthorizationStatusDenied)  //用户已经明确否认了这一照片数据的应用程序访问
    {
        return NO;
    }else{
        return YES;
    }
}

+ (BOOL)tx_accessLibrary{
    ALAuthorizationStatus author = [ALAssetsLibrary authorizationStatus];
    if (author == kCLAuthorizationStatusRestricted ||//此应用程序没有被授权访问的照片数据。可能是家长控制权限
        author == kCLAuthorizationStatusDenied)  //用户已经明确否认了这一照片数据的应用程序访问
    {
        return NO;
    }else{
        return YES;
    }
}


+ (BOOL)tx_accessLocation{
    
    BOOL ios8_locationServicesEnabled = YES;
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
        CLAuthorizationStatus status = [CLLocationManager authorizationStatus];
        NSLog(@"----------status:%d",status);
        if (status == kCLAuthorizationStatusRestricted || status == kCLAuthorizationStatusDenied) {
            ios8_locationServicesEnabled = NO;
        }else{
            ios8_locationServicesEnabled = YES;
        }
    }
    if (![CLLocationManager locationServicesEnabled] || !ios8_locationServicesEnabled) {
        return NO;
    }else {
        return YES;
    }
}

+ (BOOL)tx_accessNotification {
    //iOS8 check if user allow notification
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {// system is iOS8
        UIUserNotificationSettings *setting = [[UIApplication sharedApplication] currentUserNotificationSettings];
        if (UIUserNotificationTypeNone != setting.types) {
            return YES;
        }
    } else {//iOS7
        UIRemoteNotificationType type = [[UIApplication sharedApplication] enabledRemoteNotificationTypes];
        if(UIRemoteNotificationTypeNone != type)
            return YES;
    }
    return NO;
}
@end
