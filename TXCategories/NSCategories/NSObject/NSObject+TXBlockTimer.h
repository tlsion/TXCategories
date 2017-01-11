//
//  NSObject+MKBlockTimer.h
//  MKBlockTimerDemo
//
//  Created by Mugunth Kumar (@mugunthkumar) on 4/4/13
//  Copyright (C) 2011-2020 by Steinlogic Consulting And Training Pte Ltd.

#import <Foundation/Foundation.h>

@interface NSObject (TXBlockTimer)
-(void)tx_logTimeTakenToRunBlock:(void (^)(void)) block withPrefix:(NSString*) prefixString;
@end
