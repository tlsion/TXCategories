// NSDate+CupertinoYankee.h
//  TXCategories (https://github.com/tlsion/TXCategories)
//
//  Created by 王-庭协 on 2017/1/12.
//  Copyright © 2017年 ApeStar. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 
 */
@interface NSDate (TXCupertinoYankee)

///---------------------------------------
/// @name Calculate Beginning / End of Day
///---------------------------------------

/**
 
 */
- (NSDate *)tx_beginningOfDay;

/**
 
 */
- (NSDate *)tx_endOfDay;

///----------------------------------------
/// @name Calculate Beginning / End of Week
///----------------------------------------

/**
 
 */
- (NSDate *)tx_beginningOfWeek;

/**
 
 */
- (NSDate *)tx_endOfWeek;

///-----------------------------------------
/// @name Calculate Beginning / End of Month
///-----------------------------------------

/**
 
 */
- (NSDate *)tx_beginningOfMonth;

/**
 
 */
- (NSDate *)tx_endOfMonth;

///----------------------------------------
/// @name Calculate Beginning / End of Year
///----------------------------------------

/**
 
 */
- (NSDate *)tx_beginningOfYear;

/**
 
 */
- (NSDate *)tx_endOfYear;

@end
