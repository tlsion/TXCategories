//
//  UIWebView+style.h
//  TXCategories
//
//  Created by 王-庭协 on 14-3-11.
//  Copyright (c) 2014年 www.skyfox.org. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIWebView (TXStyle)
/**
 *  @brief  是否显示阴影
 *
 *  @param hidden 是否显示阴影
 */
- (void)tx_shadowViewHidden:(BOOL)hidden;

/**
 *  @brief  是否显示水平滑动指示器
 *
 *  @param hidden 是否显示水平滑动指示器
 */
- (void)tx_showsHorizontalScrollIndicator:(BOOL)hidden;
/**
 *  @brief  是否显示垂直滑动指示器
 *
 *  @param hidden 是否显示垂直滑动指示器
 */
- (void)tx_showsVerticalScrollIndicator:(BOOL)hidden;

/**
 *  @brief  网页透明
 */
-(void)tx_makeTransparent;
/**
 *  @brief  网页透明移除+阴影
 */
-(void)tx_makeTransparentAndRemoveShadow;
@end
