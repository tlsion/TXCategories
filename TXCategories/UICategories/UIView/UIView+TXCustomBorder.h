//
//  UIView+CustomBorder.h
//  TXCategories (https://github.com/tlsion/TXCategories)
//
//  Created by 王-庭协 on 2017/1/12.
//  Copyright © 2017年 ApeStar. All rights reserved.
//
/**
 * 视图添加边框
 */

#import <UIKit/UIKit.h>

typedef NS_OPTIONS(NSUInteger, TXExcludePoint) {
    TXExcludeStartPoint = 1 << 0,
    TXExcludeEndPoint = 1 << 1,
    TXExcludeAllPoint = ~0UL
};


@interface UIView (TXCustomBorder)

- (void)tx_addTopBorderWithColor:(UIColor *)color width:(CGFloat) borderWidth;
- (void)tx_addLeftBorderWithColor: (UIColor *) color width:(CGFloat) borderWidth;
- (void)tx_addBottomBorderWithColor:(UIColor *)color width:(CGFloat) borderWidth;
- (void)tx_addRightBorderWithColor:(UIColor *)color width:(CGFloat) borderWidth;

- (void)tx_removeTopBorder;
- (void)tx_removeLeftBorder;
- (void)tx_removeBottomBorder;
- (void)tx_removeRightBorder;


- (void)tx_addTopBorderWithColor:(UIColor *)color width:(CGFloat) borderWidth excludePoint:(CGFloat)point edgeType:(TXExcludePoint)edge;
- (void)tx_addLeftBorderWithColor: (UIColor *) color width:(CGFloat) borderWidth excludePoint:(CGFloat)point edgeType:(TXExcludePoint)edge;
- (void)tx_addBottomBorderWithColor:(UIColor *)color width:(CGFloat) borderWidth excludePoint:(CGFloat)point edgeType:(TXExcludePoint)edge;
- (void)tx_addRightBorderWithColor:(UIColor *)color width:(CGFloat) borderWidth excludePoint:(CGFloat)point edgeType:(TXExcludePoint)edge;
@end
