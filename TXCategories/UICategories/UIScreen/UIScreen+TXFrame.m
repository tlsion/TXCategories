//
//  UIScreen+TXFrame.m
//  TXCategories (https://github.com/tlsion/TXCategories)
//
//  Created by 王-庭协 on 15/5/22.
//  Copyright (c) 2015年 www.skyfox.org. All rights reserved.
//

#import "UIScreen+TXFrame.h"

@implementation UIScreen (TXFrame)
+ (CGSize)tx_size
{
    return [[UIScreen mainScreen] bounds].size;
}

+ (CGFloat)tx_width
{
    return [[UIScreen mainScreen] bounds].size.width;
}

+ (CGFloat)tx_height
{
    return [[UIScreen mainScreen] bounds].size.height;
}

+ (CGSize)tx_orientationSize
{
    CGFloat systemVersion = [[[UIDevice currentDevice] systemVersion]
                             doubleValue];
    BOOL isLand =   UIInterfaceOrientationIsLandscape([UIApplication sharedApplication].statusBarOrientation);
    return (systemVersion>8.0 && isLand) ? tx_SizeSWAP([UIScreen tx_size]) : [UIScreen tx_size];
}

+ (CGFloat)tx_orientationWidth
{
    return [UIScreen tx_orientationSize].width;
}

+ (CGFloat)tx_orientationHeight
{
    return [UIScreen tx_orientationSize].height;
}

+ (CGSize)tx_DPISize
{
    CGSize size = [[UIScreen mainScreen] bounds].size;
    CGFloat scale = [[UIScreen mainScreen] scale];
    return CGSizeMake(size.width * scale, size.height * scale);
}


/**
 *  交换高度与宽度
 */
static inline CGSize tx_SizeSWAP(CGSize size) {
    return CGSizeMake(size.height, size.width);
}
@end
