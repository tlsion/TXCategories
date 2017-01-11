//
//  UIView+Recursion.h
//  TXCategories
//
//  Created by 王-庭协 on 15/6/23.
//  Copyright © 2017年 ApeStar. All rights reserved
//

#import <UIKit/UIKit.h>
typedef void (^TXSubviewBlock) (UIView* view);
typedef void (^TXSuperviewBlock) (UIView* superview);
@interface UIView (TXRecursion)

/**
 *  @brief  寻找子视图
 *
 *  @param recurse 回调
 *
 *  @return  Return YES from the block to recurse into the subview.
 Set stop to YES to return the subview.
 */
- (UIView*)tx_findViewRecursively:(BOOL(^)(UIView* subview, BOOL* stop))recurse;


-(void)tx_runBlockOnAllSubviews:(TXSubviewBlock)block;
-(void)tx_runBlockOnAllSuperviews:(TXSuperviewBlock)block;
-(void)tx_enableAllControlsInViewHierarchy;
-(void)tx_disableAllControlsInViewHierarchy;
@end
