//
//  UIDevice+TXPush.h
//  Motorcycle
//
//  Created by Eton on 2017/4/24.
//  Copyright © 2017年 王-庭协. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIDevice (TXPush)

+ (void)tx_allowNotification;

+ (BOOL)tx_isAllowedNotification;


@end
