//
//  UIView+UIView_BlockGesture.h
//  TXCategories (https://github.com/tlsion/TXCategories)
//
//  Created by 王-庭协 on 14/12/30.
//  Copyright (c) 2014年 www.skyfox.org. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^TXGestureActionBlock)(UIGestureRecognizer *gestureRecoginzer);

@interface UIView (TXBlockGesture)
/**
 *  @brief  添加tap手势
 *
 *  @param block 代码块
 */
- (void)tx_addTapActionWithBlock:(TXGestureActionBlock)block;
/**
 *  @brief  添加长按手势
 *
 *  @param block 代码块
 */
- (void)tx_addLongPressActionWithBlock:(TXGestureActionBlock)block;
@end
