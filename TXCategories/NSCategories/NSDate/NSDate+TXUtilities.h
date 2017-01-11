//
//  NSDate+Utilities.h
//  TXCategories (https://github.com/tlsion/TXCategories)
//
//  Created by 王-庭协 on 2017/1/12.
//  Copyright © 2017年 ApeStar. All rights reserved.
//
//
// https://github.com/erica/NSDate-Extensions
#import <Foundation/Foundation.h>
#define TX_D_SECOND	(1)
#define TX_D_MINUTE	(60 * TX_D_SECOND)
#define TX_D_HOUR	(60 * TX_D_MINUTE)
#define TX_D_DAY	(24 * TX_D_HOUR)
#define TX_D_WEEK	(7 * TX_D_DAY)
#define TX_D_MONTH	(30 * TX_D_DAY)
#define TX_D_YEAR	(12 * TX_D_MONTH)
@interface NSDate (TXUtilities)
+ (NSCalendar *)tx_currentCalendar; // avoid bottlenecks
#pragma mark ---- Decomposing dates 分解的日期
@property (readonly) NSInteger tx_nearestHour;
@property (readonly) NSInteger tx_hour;
@property (readonly) NSInteger tx_minute;
@property (readonly) NSInteger tx_seconds;
@property (readonly) NSInteger tx_day;
@property (readonly) NSInteger tx_month;
@property (readonly) NSInteger tx_week;
@property (readonly) NSInteger tx_weekday;
@property (readonly) NSInteger tx_nthWeekday; // e.g. 2nd Tuesday of the month == 2
@property (readonly) NSInteger tx_year;

#pragma mark ----short time 格式化的时间
@property (nonatomic, readonly) NSString *tx_shortString;
@property (nonatomic, readonly) NSString *tx_shortDateString;
@property (nonatomic, readonly) NSString *tx_shortTimeString;
@property (nonatomic, readonly) NSString *tx_mediumString;
@property (nonatomic, readonly) NSString *tx_mediumDateString;
@property (nonatomic, readonly) NSString *tx_mediumTimeString;
@property (nonatomic, readonly) NSString *tx_longString;
@property (nonatomic, readonly) NSString *tx_longDateString;
@property (nonatomic, readonly) NSString *tx_longTimeString;

///使用dateStyle timeStyle格式化时间
- (NSString *)tx_stringWithDateStyle:(NSDateFormatterStyle)dateStyle timeStyle:(NSDateFormatterStyle)timeStyle;
///给定format格式化时间
- (NSString *)tx_stringWithFormat:(NSString *)format;

#pragma mark ---- 从当前日期相对日期时间
///明天
+ (NSDate *)tx_dateTomorrow;
///昨天
+ (NSDate *)tx_dateYesterday;
///今天后几天
+ (NSDate *)tx_dateWithDaysFromNow:(NSInteger)days;
///今天前几天
+ (NSDate *)tx_dateWithDaysBeforeNow:(NSInteger)days;
///当前小时后dHours个小时
+ (NSDate *)tx_dateWithHoursFromNow:(NSInteger)dHours;
///当前小时前dHours个小时
+ (NSDate *)tx_dateWithHoursBeforeNow:(NSInteger)dHours;
///当前分钟后dMinutes个分钟
+ (NSDate *)tx_dateWithMinutesFromNow:(NSInteger)dMinutes;
///当前分钟前dMinutes个分钟
+ (NSDate *)tx_dateWithMinutesBeforeNow:(NSInteger)dMinutes;


#pragma mark ---- Comparing dates 比较时间
///比较年月日是否相等
- (BOOL)tx_isEqualToDateIgnoringTime:(NSDate *)aDate;
///是否是今天
- (BOOL)tx_isToday;
///是否是明天
- (BOOL)tx_isTomorrow;
///是否是昨天
- (BOOL)tx_isYesterday;

///是否是同一周
- (BOOL)tx_isSameWeekAsDate:(NSDate *)aDate;
///是否是本周
- (BOOL)tx_isThisWeek;
///是否是本周的下周
- (BOOL)tx_isNextWeek;
///是否是本周的上周
- (BOOL)tx_isLastWeek;

///是否是同一月
- (BOOL)tx_isSameMonthAsDate:(NSDate *)aDate;
///是否是本月
- (BOOL)tx_isThisMonth;
///是否是本月的下月
- (BOOL)tx_isNextMonth;
///是否是本月的上月
- (BOOL)tx_isLastMonth;

///是否是同一年
- (BOOL)tx_isSameYearAsDate:(NSDate *)aDate;
///是否是今年
- (BOOL)tx_isThisYear;
///是否是今年的下一年
- (BOOL)tx_isNextYear;
///是否是今年的上一年
- (BOOL)tx_isLastYear;

///是否提前aDate
- (BOOL)tx_isEarlierThanDate:(NSDate *)aDate;
///是否晚于aDate
- (BOOL)tx_isLaterThanDate:(NSDate *)aDate;
///是否晚是未来
- (BOOL)tx_isInFuture;
///是否晚是过去
- (BOOL)tx_isInPast;


///是否是工作日
- (BOOL)tx_isTypicallyWorkday;
///是否是周末
- (BOOL)tx_isTypicallyWeekend;

#pragma mark ---- Adjusting dates 调节时间
///增加dYears年
- (NSDate *)tx_dateByAddingYears:(NSInteger)dYears;
///减少dYears年
- (NSDate *)tx_dateBySubtractingYears:(NSInteger)dYears;
///增加dMonths月
- (NSDate *)tx_dateByAddingMonths:(NSInteger)dMonths;
///减少dMonths月
- (NSDate *)tx_dateBySubtractingMonths:(NSInteger)dMonths;
///增加dDays天
- (NSDate *)tx_dateByAddingDays:(NSInteger)dDays;
///减少dDays天
- (NSDate *)tx_dateBySubtractingDays:(NSInteger)dDays;
///增加dHours小时
- (NSDate *)tx_dateByAddingHours:(NSInteger)dHours;
///减少dHours小时
- (NSDate *)tx_dateBySubtractingHours:(NSInteger)dHours;
///增加dMinutes分钟
- (NSDate *)tx_dateByAddingMinutes:(NSInteger)dMinutes;
///减少dMinutes分钟
- (NSDate *)tx_dateBySubtractingMinutes:(NSInteger)dMinutes;


#pragma mark ---- 时间间隔
///比aDate晚多少分钟
- (NSInteger)tx_minutesAfterDate:(NSDate *)aDate;
///比aDate早多少分钟
- (NSInteger)tx_minutesBeforeDate:(NSDate *)aDate;
///比aDate晚多少小时
- (NSInteger)tx_hoursAfterDate:(NSDate *)aDate;
///比aDate早多少小时
- (NSInteger)tx_hoursBeforeDate:(NSDate *)aDate;
///比aDate晚多少天
- (NSInteger)tx_daysAfterDate:(NSDate *)aDate;
///比aDate早多少天
- (NSInteger)tx_daysBeforeDate:(NSDate *)aDate;

///与anotherDate间隔几天
- (NSInteger)tx_distanceDaysToDate:(NSDate *)anotherDate;
///与anotherDate间隔几月
- (NSInteger)tx_distanceMonthsToDate:(NSDate *)anotherDate;
///与anotherDate间隔几年
- (NSInteger)tx_distanceYearsToDate:(NSDate *)anotherDate;
@end
