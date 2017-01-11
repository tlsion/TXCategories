//
//  UIView+UIView_BlockGesture.m
//  TXCategories (https://github.com/tlsion/TXCategories)
//
//  Created by 王-庭协 on 14/12/30.
//  Copyright (c) 2014年 www.skyfox.org. All rights reserved.
//

#import "UIView+TXBlockGesture.h"
#import <objc/runtime.h>
static char tx_kActionHandlerTapBlockKey;
static char tx_kActionHandlerTapGestureKey;
static char tx_kActionHandlerLongPressBlockKey;
static char tx_kActionHandlerLongPressGestureKey;

@implementation UIView (TXBlockGesture)
- (void)tx_addTapActionWithBlock:(TXGestureActionBlock)block
{
    UITapGestureRecognizer *gesture = objc_getAssociatedObject(self, &tx_kActionHandlerTapGestureKey);
    if (!gesture)
    {
        gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tx_handleActionForTapGesture:)];
        [self addGestureRecognizer:gesture];
        objc_setAssociatedObject(self, &tx_kActionHandlerTapGestureKey, gesture, OBJC_ASSOCIATION_RETAIN);
    }
    objc_setAssociatedObject(self, &tx_kActionHandlerTapBlockKey, block, OBJC_ASSOCIATION_COPY);
}
- (void)tx_handleActionForTapGesture:(UITapGestureRecognizer*)gesture
{
    if (gesture.state == UIGestureRecognizerStateRecognized)
    {
        TXGestureActionBlock block = objc_getAssociatedObject(self, &tx_kActionHandlerTapBlockKey);
        if (block)
        {
            block(gesture);
        }
    }
}
- (void)tx_addLongPressActionWithBlock:(TXGestureActionBlock)block
{
    UILongPressGestureRecognizer *gesture = objc_getAssociatedObject(self, &tx_kActionHandlerLongPressGestureKey);
    if (!gesture)
    {
        gesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(tx_handleActionForLongPressGesture:)];
        [self addGestureRecognizer:gesture];
        objc_setAssociatedObject(self, &tx_kActionHandlerLongPressGestureKey, gesture, OBJC_ASSOCIATION_RETAIN);
    }
    objc_setAssociatedObject(self, &tx_kActionHandlerLongPressBlockKey, block, OBJC_ASSOCIATION_COPY);
}
- (void)tx_handleActionForLongPressGesture:(UITapGestureRecognizer*)gesture
{
    if (gesture.state == UIGestureRecognizerStateRecognized)
    {
        TXGestureActionBlock block = objc_getAssociatedObject(self, &tx_kActionHandlerLongPressBlockKey);
        if (block)
        {
            block(gesture);
        }
    }
}
@end
