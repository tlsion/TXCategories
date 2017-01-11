//
//  UIScreen+TXFrame.h
//  TXCategories (https://github.com/tlsion/TXCategories)
//
//  Created by 王-庭协 on 15/5/22.
//  Copyright (c) 2015年 www.skyfox.org. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIScreen (TXFrame)
+ (CGSize)tx_size;
+ (CGFloat)tx_width;
+ (CGFloat)tx_height;

+ (CGSize)tx_orientationSize;
+ (CGFloat)tx_orientationWidth;
+ (CGFloat)tx_orientationHeight;
+ (CGSize)tx_DPISize;

@end
