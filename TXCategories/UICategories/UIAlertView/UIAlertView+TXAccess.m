//
//  UIAlertView+TXAccess.m
//  TXCategoriesDemo
//
//  Created by Eton on 2017/5/12.
//  Copyright © 2017年 王-庭协. All rights reserved.
//

#import "UIAlertView+TXAccess.h"
#import "UIAlertView+TXBlock.h"
#import "UIApplication+TXOpen.h"
#import "UIApplication+TXAccess.h"

@implementation UIAlertView (TXAccess)

+ (BOOL)tx_accessCamera{
    BOOL isAccess = [UIApplication tx_accessCamera];
    if (!isAccess) {
        [UIAlertView tx_alertWithCallBackBlock:^(NSInteger buttonIndex) {
            if (buttonIndex == 1) {
                [[UIApplication sharedApplication] tx_openSettings];
            }
        } title:@"相机权限" message:@"请在iPhone的“设置-隐私-相机”选项中，允许此APP访问您的相机。" cancelButtonName:@"取消" otherButtonTitles:@"去设置", nil];
    }
    return isAccess;
}

+ (BOOL)tx_accessLibrary{
    BOOL isAccess = [UIApplication tx_accessLibrary];
    if (!isAccess) {
        [UIAlertView tx_alertWithCallBackBlock:^(NSInteger buttonIndex) {
            if (buttonIndex == 1) {
                [[UIApplication sharedApplication] tx_openSettings];
            }
        } title:@"相册权限" message:@"请在iPhone的“设置-隐私-照片”选项中，允许此APP访问您的手机相册。" cancelButtonName:@"取消" otherButtonTitles:@"去设置", nil];
    }
    return isAccess;
}


+ (BOOL)tx_accessLocation{
    
    BOOL isAccess = [UIApplication tx_accessLocation];
    if (!isAccess) {
        [UIAlertView tx_alertWithCallBackBlock:^(NSInteger buttonIndex) {
            if (buttonIndex == 1) {
                [[UIApplication sharedApplication] tx_openSettings];
            }
        } title:@"定位服务未开启" message:@"请在iPhone的“设置-隐私-照片”选项中，允许此APP确定您的位置。" cancelButtonName:@"取消" otherButtonTitles:@"去设置", nil];
    }
    return isAccess;
}

+ (BOOL)tx_accessNotification {
    
    BOOL isAccess = [UIApplication tx_accessNotification];
    if (!isAccess) {
        [UIAlertView tx_alertWithCallBackBlock:^(NSInteger buttonIndex) {
            if (buttonIndex == 1) {
                [[UIApplication sharedApplication] tx_openSettings];
            }
        } title:@"推送服务未开启" message:@"请在iPhone的“设置-推送”选项中，允许此APP开启推送服务。" cancelButtonName:@"取消" otherButtonTitles:@"去设置", nil];
    }
    return isAccess;
}
@end
