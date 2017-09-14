//
//  NSString+TXSize.m
//  TXCategories (https://github.com/tlsion/TXCategories)
//
//  Created by 王-庭协 on 15/5/22.
//  Copyright (c) 2015年 www.skyfox.org. All rights reserved.
//

#import "NSString+TXSize.h"

@implementation NSString (TXSize)

/**
 *  @brief 计算文字的宽度
 *
 *  @param font   字体(默认为系统字体)
 */
- (CGFloat)tx_widthWithFont:(UIFont *)font
{
    CGSize size = [self tx_sizeWithFont:font constrainedToSize:CGSizeMake(CGFLOAT_MAX, 0)];
    return size.width;
}

/**
 *  @brief 计算文字的高度
 *
 *  @param font  字体(默认为系统字体)
 *  @param width 约束宽度
 */
- (CGFloat)tx_heightWithFont:(UIFont *)font width:(CGFloat)width
{
    CGSize size = [self tx_sizeWithFont:font constrainedToSize:CGSizeMake(width, CGFLOAT_MAX)];
    return size.height;
}

/**
 *  @brief 计算文字的大小
 *
 *  @param font   字体(默认为系统字体)
 *  @param size   约束宽高
 */
- (CGSize)tx_sizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size{
    
    UIFont *textFont = font ? font : [UIFont systemFontOfSize:[UIFont systemFontSize]];
    
    CGSize textSize;
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED < 70000
    if ([self respondsToSelector:@selector(boundingRectWithSize:options:attributes:context:)]) {
        NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
        paragraph.lineBreakMode = NSLineBreakByWordWrapping;
        NSDictionary *attributes = @{NSFontAttributeName: textFont,
                                     NSParagraphStyleAttributeName: paragraph};
        textSize = [self boundingRectWithSize:size
                                      options:(NSStringDrawingUsesLineFragmentOrigin |
                                               NSStringDrawingTruncatesLastVisibleLine)
                                   attributes:attributes
                                      context:nil].size;
    } else {
        textSize = [self sizeWithFont:textFont
                    constrainedToSize:CGSizeMake(CGFLOAT_MAX, height)
                        lineBreakMode:NSLineBreakByWordWrapping];
    }
#else
    NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
    paragraph.lineBreakMode = NSLineBreakByWordWrapping;
    NSDictionary *attributes = @{NSFontAttributeName: textFont,
                                 NSParagraphStyleAttributeName: paragraph};
    textSize = [self boundingRectWithSize:size
                                  options:(NSStringDrawingUsesLineFragmentOrigin |
                                           NSStringDrawingTruncatesLastVisibleLine)
                               attributes:attributes
                                  context:nil].size;
#endif
    
    return CGSizeMake(ceil(textSize.width), ceil(textSize.height));
}

@end
