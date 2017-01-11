//
//  UINavigationItem+TXLock.h
//  TXCategories (https://github.com/tlsion/TXCategories)
//
//  Created by 王-庭协 on 15/5/22.
//  Copyright (c) 2015年 www.skyfox.org. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationItem (TXLock)
/**
 *  @brief  锁定RightItem
 *
 *  @param lock 是否锁定
 */
- (void)tx_lockRightItem:(BOOL)lock;
/**
 *  @brief  锁定LeftItem
 *
 *  @param lock 是否锁定
 */
- (void)tx_lockLeftItem:(BOOL)lock;
@end
