//
//  UIControl+TXActionBlocks.m
//  TXCategories (https://github.com/tlsion/TXCategories)
//
//  Created by 王-庭协 on 15/5/23.
//  Copyright (c) 2015年 www.skyfox.org. All rights reserved.
//

#import "UIControl+TXActionBlocks.h"
#import <objc/runtime.h>

static const void *UIControlTXActionBlockArray = &UIControlTXActionBlockArray;

@implementation UIControlTXActionBlockWrapper

- (void)tx_invokeBlock:(id)sender {
    if (self.tx_actionBlock) {
        self.tx_actionBlock(sender);
    }
}
@end


@implementation UIControl (TXActionBlocks)
-(void)tx_handleControlEvents:(UIControlEvents)controlEvents withBlock:(UIControlTXActionBlock)actionBlock {
    NSMutableArray *actionBlocksArray = [self tx_actionBlocksArray];
    
    UIControlTXActionBlockWrapper *blockActionWrapper = [[UIControlTXActionBlockWrapper alloc] init];
    blockActionWrapper.tx_actionBlock = actionBlock;
    blockActionWrapper.tx_controlEvents = controlEvents;
    [actionBlocksArray addObject:blockActionWrapper];
    
    [self addTarget:blockActionWrapper action:@selector(tx_invokeBlock:) forControlEvents:controlEvents];
}


- (void)tx_removeActionBlocksForControlEvents:(UIControlEvents)controlEvents {
    NSMutableArray *actionBlocksArray = [self tx_actionBlocksArray];
    NSMutableArray *wrappersToRemove = [NSMutableArray arrayWithCapacity:[actionBlocksArray count]];
    
    [actionBlocksArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        UIControlTXActionBlockWrapper *wrapperTmp = obj;
        if (wrapperTmp.tx_controlEvents == controlEvents) {
            [wrappersToRemove addObject:wrapperTmp];
            [self removeTarget:wrapperTmp action:@selector(tx_invokeBlock:) forControlEvents:controlEvents];
        }
    }];
    
    [actionBlocksArray removeObjectsInArray:wrappersToRemove];
}


- (NSMutableArray *)tx_actionBlocksArray {
    NSMutableArray *actionBlocksArray = objc_getAssociatedObject(self, UIControlTXActionBlockArray);
    if (!actionBlocksArray) {
        actionBlocksArray = [NSMutableArray array];
        objc_setAssociatedObject(self, UIControlTXActionBlockArray, actionBlocksArray, OBJC_ASSOCIATION_RETAIN);
    }
    return actionBlocksArray;
}
@end
