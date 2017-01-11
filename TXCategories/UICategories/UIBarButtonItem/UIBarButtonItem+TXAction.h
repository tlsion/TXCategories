//
//  UIBarButtonItem+TXAction.h
//  TXCategories (https://github.com/tlsion/TXCategories)
//
//  Created by 王-庭协 on 15/5/22.
//  Copyright (c) 2015年 www.skyfox.org. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^BarButtonTXActionBlock)();

@interface UIBarButtonItem (TXAction)

/// A block that is run when the UIBarButtonItem is tapped.
//@property (nonatomic, copy) dispatch_block_t actionBlock;
- (void)setTx_actionBlock:(BarButtonTXActionBlock)actionBlock;

@end
