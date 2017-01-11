//
//  UIView+TXRemove.m
//  TXCategoriesDemo
//
//  Created by Eton on 2017/1/11.
//  Copyright © 2017年 王-庭协. All rights reserved.
//

#import "UIView+TXRemove.h"

@implementation UIView (TXRemove)

- (void)tx_removeAllSubViews {
    while (self.subviews.count) {
        UIView* child = self.subviews.lastObject;
        [child removeFromSuperview];
    }
}

- (void)tx_removeSubviewsWithSubviewClass:(Class)cls
{
    NSInteger differentCount = self.subviews.count;
    while (differentCount > 0) {
        UIView* child = self.subviews.lastObject;
        if ([child isKindOfClass:cls]) {
            [child removeFromSuperview];
        }
        differentCount --;
    }
}
- (void)tx_removeSubviewsWithSubviewTag:(NSInteger)tag
{
    UIView *view = [self viewWithTag:tag];
    [view removeFromSuperview];
}

@end
