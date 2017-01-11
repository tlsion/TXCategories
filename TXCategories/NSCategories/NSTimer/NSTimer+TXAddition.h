//
//  NSTimer+TXAddition.h
//  TXCategories (https://github.com/tlsion/TXCategories)
//
//  Created by 王-庭协 on 14/12/15.
//  Copyright (c) 2014年 www.skyfox.org. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSTimer (TXAddition)
/**
 *  @brief  暂停NSTimer
 */
- (void)tx_pauseTimer;
/**
 *  @brief  开始NSTimer
 */
- (void)tx_resumeTimer;
/**
 *  @brief  延迟开始NSTimer
 */
- (void)tx_resumeTimerAfterTimeInterval:(NSTimeInterval)interval;
@end
