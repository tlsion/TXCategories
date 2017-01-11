//
//  UIButton+Block.m
//  TXCategories (https://github.com/tlsion/TXCategories)
//
//  Created by 王-庭协 on 14/12/30.
//  Copyright (c) 2014年 www.skyfox.org. All rights reserved.
//

#import "UIButton+TXBlock.h"
#import <objc/runtime.h>
static const void *tx_UIButtonBlockKey = &tx_UIButtonBlockKey;

@implementation UIButton (tx_Block)
-(void)tx_addActionHandler:(TXTouchedButtonBlock)touchHandler{
    objc_setAssociatedObject(self, tx_UIButtonBlockKey, touchHandler, OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self addTarget:self action:@selector(tx_blockActionTouched:) forControlEvents:UIControlEventTouchUpInside];
}
-(void)tx_blockActionTouched:(UIButton *)btn{
    TXTouchedButtonBlock block = objc_getAssociatedObject(self, tx_UIButtonBlockKey);
    if (block) {
        block(btn.tag);
    }
}
@end

