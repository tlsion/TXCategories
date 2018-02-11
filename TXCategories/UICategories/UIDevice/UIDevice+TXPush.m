//
//  UIDevice+TXPush.m
//  Motorcycle
//
//  Created by Eton on 2017/4/24.
//  Copyright © 2017年 王-庭协. All rights reserved.
//

#import "UIDevice+TXPush.h"
//#import <UserNotifications/UserNotifications.h>

@implementation UIDevice (TXPush)


+ (void)tx_allowNotification{
//    if (IS_GREATER_EQUAL_IOS(10.0)) {
//        //iOS10特有
//        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
//        // 必须写代理，不然无法监听通知的接收与点击
//        center.delegate = self;
//        [center requestAuthorizationWithOptions:(UNAuthorizationOptionAlert | UNAuthorizationOptionBadge | UNAuthorizationOptionSound) completionHandler:^(BOOL granted, NSError * _Nullable error) {
//            if (granted) {
//                // 点击允许
//                NSLog(@"注册成功");
//                [center getNotificationSettingsWithCompletionHandler:^(UNNotificationSettings * _Nonnull settings) {
//                    NSLog(@"%@", settings);
//                }];
//            } else {
//                // 点击不允许
//                NSLog(@"注册失败");
//            }
//        }];
//    }else
        if ([[[UIDevice currentDevice] systemVersion] floatValue] > 8.0){
        //iOS8 - iOS10
        [[UIApplication sharedApplication] registerForRemoteNotifications];
        
        [[UIApplication sharedApplication] registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert | UIUserNotificationTypeSound | UIUserNotificationTypeBadge categories:nil]];
    }else{
        //iOS8系统以下
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeSound];
    }
}

+ (BOOL)tx_isAllowedNotification {
    //iOS8 check if user allow notification
    if ([[[UIDevice currentDevice] systemVersion] floatValue] > 8.0) {// system is iOS8
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
