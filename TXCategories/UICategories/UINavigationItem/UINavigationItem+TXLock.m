//
//  UINavigationItem+TXLock.m
//  TXCategories (https://github.com/tlsion/TXCategories)
//
//  Created by 王-庭协 on 15/5/22.
//  Copyright (c) 2015年 www.skyfox.org. All rights reserved.
//

#import "UINavigationItem+TXLock.h"

@implementation UINavigationItem (TXLock)
- (void)tx_lockRightItem:(BOOL)lock
{
    NSArray *rightBarItems = self.rightBarButtonItems;
    if (rightBarItems  && [rightBarItems count]>0) {
        [rightBarItems enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            if ([obj isKindOfClass:[UIBarButtonItem class]] ||
                [obj isMemberOfClass:[UIBarButtonItem class]])
            {
                UIBarButtonItem *barButtonItem = (UIBarButtonItem *)obj;
                barButtonItem.enabled = !lock;
            }
        }];
    }
}

- (void)tx_lockLeftItem:(BOOL)lock
{
    NSArray *leftBarItems = self.leftBarButtonItems;
    if (leftBarItems  && [leftBarItems count]>0) {
        [leftBarItems enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            if ([obj isKindOfClass:[UIBarButtonItem class]] ||
                [obj isMemberOfClass:[UIBarButtonItem class]])
            {
                UIBarButtonItem *barButtonItem = (UIBarButtonItem *)obj;
                barButtonItem.enabled = !lock;
            }
        }];
    }
}

@end
