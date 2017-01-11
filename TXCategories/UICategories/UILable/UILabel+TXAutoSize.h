//
//  UILabel+AutoSize.h
//  TXCategories (https://github.com/tlsion/TXCategories)
//
//  Created by 王-庭协 on 15/5/22.
//  Copyright (c) 2015年 www.skyfox.org. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (TXAutoSize)
/**
 * 垂直方向固定获取动态宽度的UILabel的方法
 *
 * @return 原始UILabel修改过的Rect的UILabel(起始位置相同)
 */
- (UILabel *)tx_resizeLabelHorizontal;

/**
 *  水平方向固定获取动态宽度的UILabel的方法
 *
 *  @return 原始UILabel修改过的Rect的UILabel(起始位置相同)
 */
- (UILabel *)tx_resizeLabelVertical;

/**
 *  垂直方向固定获取动态宽度的UILabel的方法
 *
 *  @param minimumWidth minimum width
 *
 *  @return 原始UILabel修改过的Rect的UILabel(起始位置相同)
 */
- (UILabel *)tx_resizeLabelHorizontal:(CGFloat)minimumWidth;

/**
 *  水平方向固定获取动态宽度的UILabel的方法
 *
 *  @param minimumHeigh minimum height
 *
 *  @return 原始UILabel修改过的Rect的UILabel(起始位置相同)
 */
- (UILabel *)tx_resizeLabelVertical:(CGFloat)minimumHeigh;
@end
