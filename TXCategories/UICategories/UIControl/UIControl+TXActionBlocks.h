//
//  UIControl+TXActionBlocks.h
//  TXCategories (https://github.com/tlsion/TXCategories)
//
//  Created by 王-庭协 on 15/5/23.
//  Copyright (c) 2015年 www.skyfox.org. All rights reserved.
//  https://github.com/lavoy/ALActionBlocks

#import <UIKit/UIKit.h>
typedef void (^UIControlTXActionBlock)(id weakSender);


@interface UIControlTXActionBlockWrapper : NSObject
@property (nonatomic, copy) UIControlTXActionBlock tx_actionBlock;
@property (nonatomic, assign) UIControlEvents tx_controlEvents;
- (void)tx_invokeBlock:(id)sender;
@end



@interface UIControl (TXActionBlocks)
- (void)tx_handleControlEvents:(UIControlEvents)controlEvents withBlock:(UIControlTXActionBlock)actionBlock;
- (void)tx_removeActionBlocksForControlEvents:(UIControlEvents)controlEvents;
@end
