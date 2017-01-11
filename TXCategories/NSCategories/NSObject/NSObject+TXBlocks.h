//
//  NSObject+TXBlocks.h
//  PSFoundation
//
//  Created by Peter Steinberger on 24.10.10.
//  Copyright 2010 Peter Steinberger. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface NSObject (TXBlocks)
+ (id)tx_performBlock:(void (^)(void))block afterDelay:(NSTimeInterval)delay;
+ (id)tx_performBlock:(void (^)(id arg))block withObject:(id)anObject afterDelay:(NSTimeInterval)delay;
- (id)tx_performBlock:(void (^)(void))block afterDelay:(NSTimeInterval)delay;
- (id)tx_performBlock:(void (^)(id arg))block withObject:(id)anObject afterDelay:(NSTimeInterval)delay;
+ (void)tx_cancelBlock:(id)block;
+ (void)tx_cancelPreviousPerformBlock:(id)aWrappingBlockHandle __attribute__ ((deprecated));

@end
