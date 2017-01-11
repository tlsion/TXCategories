//
//  UIView+TXRemove.h
//  TXCategoriesDemo
//
//  Created by Eton on 2017/1/11.
//  Copyright © 2017年 王-庭协. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (TXRemove)

/**
 *  删除所有的子类视图
 */
- (void)tx_removeAllSubViews;
/**
 *  删除视图中特定类别的子类视图
 *
 *  @param cls 制定类别
 */
- (void)tx_removeSubviewsWithSubviewClass:(Class)cls;
/**
 *  删除视图中特定Tag的子类视图
 *
 *  @param tag zilei
 */
- (void)tx_removeSubviewsWithSubviewTag:(NSInteger)tag;

@end
