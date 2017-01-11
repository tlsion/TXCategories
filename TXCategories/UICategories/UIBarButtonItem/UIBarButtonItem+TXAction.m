//
//  UIBarButtonItem+TXAction.m
//  TXCategories (https://github.com/tlsion/TXCategories)
//
//  Created by 王-庭协 on 15/5/22.
//  Copyright (c) 2015年 www.skyfox.org. All rights reserved.
//

char * const UIBarButtonItemTXActionBlock = "UIBarButtonItemTXActionBlock";
#import "UIBarButtonItem+TXAction.h"
#import <objc/runtime.h>

@implementation UIBarButtonItem (TXAction)

- (void)tx_performActionBlock {
    
    dispatch_block_t block = self.tx_actionBlock;
    
    if (block)
        block();
    
}

- (BarButtonTXActionBlock)tx_actionBlock {
    return objc_getAssociatedObject(self, UIBarButtonItemTXActionBlock);
}

- (void)setTx_actionBlock:(BarButtonTXActionBlock)actionBlock
 {
    
    if (actionBlock != self.tx_actionBlock) {
        [self willChangeValueForKey:@"tx_actionBlock"];
        
        objc_setAssociatedObject(self,
                                 UIBarButtonItemTXActionBlock,
                                 actionBlock,
                                 OBJC_ASSOCIATION_COPY);
        
        // Sets up the action.
        [self setTarget:self];
        [self setAction:@selector(tx_performActionBlock)];
        
        [self didChangeValueForKey:@"tx_actionBlock"];
    }
}
@end
