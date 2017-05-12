//
//  UIApplication+TXOpen.m
//  TXCategoriesDemo
//
//  Created by Eton on 2017/5/12.
//  Copyright © 2017年 王-庭协. All rights reserved.
//

#import "UIApplication+TXOpen.h"

@implementation UIApplication (TXOpen)

- (void)tx_openURL:(NSURL *)URL{
    [self tx_openURL:URL completionHandler:nil];
}

- (void)tx_openURL:(NSURL *)URL completionHandler:(void (^)(BOOL success))completion{
    if (!URL) {
        if (completion) {
            completion(NO);
        }
    }
    if ([[UIApplication sharedApplication] respondsToSelector:@selector(openURL:options:completionHandler:)]) {
        [[UIApplication sharedApplication] openURL:URL options:@{}
                                 completionHandler:^(BOOL success) {
                                     if (completion) {
                                         completion(success);
                                     }
                                 }];
    } else {
        BOOL success = [[UIApplication sharedApplication] openURL:URL];
        if (completion) {
            completion(success);
        }
    }
}

- (void)tx_openAppWithSchemes:(NSString *)schemes param:(NSString *)param{
    if (!schemes) {
        return;
    }
    NSURL * URL = [NSURL URLWithString:[NSString stringWithFormat:@"%@://%@",schemes,param?:@""]];
    [self tx_openURL:URL];
}

- (void)tx_openTelWithPhone:(NSString *)phone{
    if (!phone) {
        return;
    }
    NSURL * URL = [NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",phone]];
    [self tx_openURL:URL];
}

- (void)tx_openSMSWithPhone:(NSString *)phone{
    if (!phone) {
        return;
    }
    NSURL * URL = [NSURL URLWithString:[NSString stringWithFormat:@"sms://%@",phone]];
    [self tx_openURL:URL];
}

- (void)tx_openAppStoreWithAppID:(NSString *)appID{
    if (!appID) {
        return;
    }
    NSURL * URL = [NSURL URLWithString:[NSString stringWithFormat:@"https://itunes.apple.com/cn/app/id%@",appID]];
    [self tx_openURL:URL];
}

- (void)tx_openSettings{
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
        // 无权限 引导去开启
        NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
        if ([[UIApplication sharedApplication] canOpenURL:url]) {
            [[UIApplication sharedApplication] openURL:url];
        }
    }
}

@end
