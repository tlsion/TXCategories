//
//  UIView+Find.h
//  TXCategories (https://github.com/tlsion/TXCategories)
//
//  Created by 王-庭协 on 2017/1/12.
//  Copyright © 2017年 ApeStar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (TXFind)
/**
 *  @brief  找到指定类名的SubVie对象
 *
 *  @param clazz SubVie类名
 *
 *  @return view对象
 */
- (id)tx_findSubViewWithSubViewClass:(Class)clazz;
/**
 *  @brief  找到指定类名的SuperView对象
 *
 *  @param clazz SuperView类名
 *
 *  @return view对象
 */
- (id)tx_findSuperViewWithSuperViewClass:(Class)clazz;

/**
 *  @brief  找到并且resign第一响应者
 *
 *  @return 结果
 */
- (BOOL)tx_findAndResignFirstResponder;
/**
 *  @brief  找到第一响应者
 *
 *  @return 第一响应者
 */
- (UIView *)tx_findFirstResponder;

/**
 *  @brief  找到当前view所在的viewcontroler
 */
@property (readonly) UIViewController *tx_viewController;
@end
