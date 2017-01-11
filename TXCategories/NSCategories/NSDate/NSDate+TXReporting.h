//
// NSDate+Reporting.h
//  TXCategories (https://github.com/tlsion/TXCategories)
//
//  Created by 王-庭协 on 2017/1/12.
//  Copyright © 2017年 ApeStar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface NSDate (TXReporting)

// Return a date with a specified year, month and day.
+ (NSDate *)tx_dateWithYear:(int)year month:(int)month day:(int)day;

// Return midnight on the specified date.
+ (NSDate *)tx_midnightOfDate:(NSDate *)date;

// Return midnight today.
+ (NSDate *)tx_midnightToday;

// Return midnight tomorrow.
+ (NSDate *)tx_midnightTomorrow;

// Returns a date that is exactly 1 day after the specified date. Does *not*
// zero out the time components. For example, if the specified date is
// April 15 2012 10:00 AM, the return value will be April 16 2012 10:00 AM.
+ (NSDate *)tx_oneDayAfter:(NSDate *)date;

// Returns midnight of the first day of the current, previous or next Month.
// Note: firstDayOfNextMonth returns midnight of the first day of next month,
// which is effectively the same as the "last moment" of the current month.
+ (NSDate *)tx_firstDayOfCurrentMonth;
+ (NSDate *)tx_firstDayOfPreviousMonth;
+ (NSDate *)tx_firstDayOfNextMonth;

// Returns midnight of the first day of the current, previous or next Quarter.
// Note: firstDayOfNextQuarter returns midnight of the first day of next quarter,
// which is effectively the same as the "last moment" of the current quarter.
+ (NSDate *)tx_firstDayOfCurrentQuarter;
+ (NSDate *)tx_firstDayOfPreviousQuarter;
+ (NSDate *)tx_firstDayOfNextQuarter;

// Returns midnight of the first day of the current, previous or next Year.
// Note: firstDayOfNextYear returns midnight of the first day of next year,
// which is effectively the same as the "last moment" of the current year.
+ (NSDate *)tx_firstDayOfCurrentYear;
+ (NSDate *)tx_firstDayOfPreviousYear;
+ (NSDate *)tx_firstDayOfNextYear;


- (NSDate *)tx_dateFloor;
- (NSDate *)tx_dateCeil;

- (NSDate *)tx_startOfWeek;
- (NSDate *)tx_endOfWeek;

- (NSDate *)tx_startOfMonth;
- (NSDate *)tx_endOfMonth;

- (NSDate *)tx_startOfYear;
- (NSDate *)tx_endOfYear;

- (NSDate *)tx_previousDay;
- (NSDate *)tx_nextDay;

- (NSDate *)tx_previousWeek;
- (NSDate *)tx_nextWeek;

- (NSDate *)tx_previousMonth;
- (NSDate *)tx_previousMonth:(NSUInteger) monthsToMove;
- (NSDate *)tx_nextMonth;
- (NSDate *)tx_nextMonth:(NSUInteger) monthsToMove;

#ifdef DEBUG
// For testing only. A helper function to format and display a date
// with an optional comment. For example:
//     NSDate *test = [NSDate firstDayOfCurrentMonth];
//     [test logWithComment:@"First day of current month: "];
- (void)tx_logWithComment:(NSString *)comment;
#endif

@end
