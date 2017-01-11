//
//  NSRunLoop+PerformBlock.m
//  TXCategories
//
//  Created by 王-庭协 on 15/8/7.
//  Copyright © 2017年 ApeStar. All rights reserved
//

#import "NSRunLoop+TXPerformBlock.h"

NSString *const NSRunloopTimeoutException = @"NSRunloopTimeoutException";

@implementation NSRunLoop (TXPerformBlock)

- (void)tx_performBlockAndWait:(void (^)(BOOL *))block
{
    [self tx_performBlockAndWait:block timeoutInterval:10.0];
}

- (void)tx_performBlockAndWait:(void (^)(BOOL *))block timeoutInterval:(NSTimeInterval)timeoutInterval
{
    if (!block || timeoutInterval < 0.0) {
        [NSException raise:NSInvalidArgumentException format:@"%lf is invalid for timeout interval", timeoutInterval];
    }
    
    NSDate *startedDate = [NSDate date];
    BOOL finish = NO;
    
    block(&finish);
    
    while (!finish && [[NSDate date] timeIntervalSinceDate:startedDate] < timeoutInterval) {
        @autoreleasepool {
            [self runUntilDate:[NSDate dateWithTimeIntervalSinceNow:.1]];
        }
    }
    
    if (!finish) {
        [NSException raise:NSRunloopTimeoutException format:@"execution of block timed out in performBlockAndWait:."];
    }
}

@end
