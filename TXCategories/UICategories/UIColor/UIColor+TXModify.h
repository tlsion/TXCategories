//
//  UIColor+Modify.h
//  TXCategories (https://github.com/tlsion/TXCategories)
//
//  Created by 王-庭协 on 15/1/2.
//  Copyright (c) 2015年 www.skyfox.org. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (TXModify)
- (UIColor *)tx_invertedColor;
- (UIColor *)tx_colorForTranslucency;
- (UIColor *)tx_lightenColor:(CGFloat)lighten;
- (UIColor *)tx_darkenColor:(CGFloat)darken;
@end
