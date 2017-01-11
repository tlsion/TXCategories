//
//  NSInvocation+Block.h
//  NSInvocation+Block
//
//  Created by 王-庭协 on 2017/1/12.
//  Copyright © 2017年 ApeStar. All rights reserved.
//
// NSInvocation category to create NSInvocation with block
//https://github.com/deput/NSInvocation-Block
#import <Foundation/Foundation.h>

@interface NSInvocation (TXBlock)
+ (instancetype)tx_invocationWithBlock:(id) block;
+ (instancetype)tx_invocationWithBlockAndArguments:(id) block ,...;
@end
