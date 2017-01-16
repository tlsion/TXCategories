//
//  NSString+TXSize.h
//  TXCategories (https://github.com/tlsion/TXCategories)
//
//  Created by 王-庭协 on 15/5/22.
//  Copyright (c) 2015年 www.skyfox.org. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface NSString (TXSize)
/**
 *  @brief 计算文字的宽度
 *
 *  @param font   字体(默认为系统字体)
 */
- (CGFloat)tx_widthWithFont:(UIFont *)font;

/**
 *  @brief 计算文字的高度
 *
 *  @param font  字体(默认为系统字体)
 *  @param width 约束宽度
 */
- (CGFloat)tx_heightWithFont:(UIFont *)font width:(CGFloat)width;

/**
 *  @brief 计算文字的大小
 *
 *  @param font   字体(默认为系统字体)
 *  @param size   约束宽高
 */
- (CGSize)tx_sizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size;

@end
