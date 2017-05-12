//
//  UIApplication+TXAccess.h
//  TXCategoriesDemo
//
//  Created by Eton on 2017/5/12.
//  Copyright © 2017年 王-庭协. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIApplication (TXAccess)

+ (BOOL)tx_accessCamera;

+ (BOOL)tx_accessLibrary;

+ (BOOL)tx_accessLocation;

+ (BOOL)tx_accessNotification;

@end
