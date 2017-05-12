//
//  UIApplication+TXOpen.h
//  TXCategoriesDemo
//
//  Created by Eton on 2017/5/12.
//  Copyright © 2017年 王-庭协. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIApplication (TXOpen)

- (void)tx_openURL:(NSURL *)URL;

- (void)tx_openURL:(NSURL *)URL completionHandler:(void (^)(BOOL success))completion;

- (void)tx_openAppWithSchemes:(NSString *)schemes param:(NSString *)param;

- (void)tx_openTelWithPhone:(NSString *)phone;

- (void)tx_openSMSWithPhone:(NSString *)phone;

- (void)tx_openAppStoreWithAppID:(NSString *)appID;

- (void)tx_openSettings;
@end
