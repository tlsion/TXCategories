//
//  UIScrollView+PlaceHolder.h
//  TXCategoriesDemo
//
//  Created by Eton on 2017/10/12.
//  Copyright © 2017年 王-庭协. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol UIScrollViewPlaceHolderDelegate <NSObject>

@required
/*!
 @brief  make an empty overlay view when the tableView is empty
 @return an empty overlay view
 */
- (UIView *)makePlaceHolderView;

@optional
/*!
 @brief enable tableView scroll when place holder view is showing, it is disabled by default.
 @attention There is no need to return  NO, it will be NO by default
 @return enable tableView scroll, you can only return YES
 */
- (BOOL)enableScrollWhenPlaceHolderViewShowing;

@end

@interface UIScrollView (PlaceHolder)

/**
 *  刷新列表、自动加载空界面、结束上下拉刷新
 */
- (void)tx_reloadData;


@end
