//
//  UIColor+HEX.h
//  TXCategories (https://github.com/tlsion/TXCategories)
//
//  Created by 王-庭协 on 14/12/15.
//  Copyright (c) 2014年 www.skyfox.org. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (TXHEX)
+ (UIColor *)tx_colorWithHex:(UInt32)hex;
+ (UIColor *)tx_colorWithHex:(UInt32)hex andAlpha:(CGFloat)alpha;
+ (UIColor *)tx_colorWithHexString:(NSString *)hexString;
- (NSString *)tx_HEXString;
///值不需要除以255.0
+ (UIColor *)tx_colorWithWholeRed:(CGFloat)red
                         green:(CGFloat)green
                          blue:(CGFloat)blue
                         alpha:(CGFloat)alpha;
///值不需要除以255.0
+ (UIColor *)tx_colorWithWholeRed:(CGFloat)red
                         green:(CGFloat)green
                          blue:(CGFloat)blue;
@end
