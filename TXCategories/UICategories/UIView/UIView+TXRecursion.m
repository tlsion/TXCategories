//
//  UIView+Recursion.m
//  TXCategories
//
//  Created by 王-庭协 on 15/6/23.
//  Copyright © 2017年 ApeStar. All rights reserved
//

#import "UIView+TXRecursion.h"

@implementation UIView (TXRecursion)
/**
 *  @brief  寻找子视图
 *
 *  @param recurse 回调
 *
 *  @return  Return YES from the block to recurse into the subview.
 Set stop to YES to return the subview.
 */
- (UIView*)tx_findViewRecursively:(BOOL(^)(UIView* subview, BOOL* stop))recurse
{
    for( UIView* subview in self.subviews ) {
        BOOL stop = NO;
        if( recurse( subview, &stop ) ) {
            return [subview tx_findViewRecursively:recurse];
        } else if( stop ) {
            return subview;
        }
    }
    
    return nil;
}


-(void)tx_runBlockOnAllSubviews:(TXSubviewBlock)block
{
    block(self);
    for (UIView* view in [self subviews])
    {
        [view tx_runBlockOnAllSubviews:block];
    }
}

-(void)tx_runBlockOnAllSuperviews:(TXSuperviewBlock)block
{
    block(self);
    if (self.superview)
    {
        [self.superview tx_runBlockOnAllSuperviews:block];
    }
}

-(void)tx_enableAllControlsInViewHierarchy
{
    [self tx_runBlockOnAllSubviews:^(UIView *view) {
        
        if ([view isKindOfClass:[UIControl class]])
        {
            [(UIControl *)view setEnabled:YES];
        }
        else if ([view isKindOfClass:[UITextView class]])
        {
            [(UITextView *)view setEditable:YES];
        }
    }];
}

-(void)tx_disableAllControlsInViewHierarchy
{
    [self tx_runBlockOnAllSubviews:^(UIView *view) {
        
        if ([view isKindOfClass:[UIControl class]])
        {
            [(UIControl *)view setEnabled:NO];
        }
        else if ([view isKindOfClass:[UITextView class]])
        {
            [(UITextView *)view setEditable:NO];
        }
    }];
}
@end
