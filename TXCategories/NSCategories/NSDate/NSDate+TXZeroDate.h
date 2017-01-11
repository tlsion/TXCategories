//
//  NSDate+TXZeroDate.h
//  TXCategories (https://github.com/tlsion/TXCategories)
//
//  Created by 王-庭协 on 2017/1/12.
//  Copyright © 2017年 ApeStar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (TXZeroDate)
+ (NSDate *)tx_zeroTodayDate;
+ (NSDate *)tx_zero24TodayDate;

- (NSDate *)tx_zeroDate;
- (NSDate *)tx_zero24Date;
@end
