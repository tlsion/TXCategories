//
//  NSDate+Extension.h
//  TXCategories (https://github.com/tlsion/TXCategories)
//
//  Created by 王-庭协 on 2017/1/12.
//  Copyright © 2017年 ApeStar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (TXExtension)


/**
 * 获取日、月、年、小时、分钟、秒
 */
- (NSUInteger)tx_day;
- (NSUInteger)tx_month;
- (NSUInteger)tx_year;
- (NSUInteger)tx_hour;
- (NSUInteger)tx_minute;
- (NSUInteger)tx_second;
+ (NSUInteger)tx_day:(NSDate *)date;
+ (NSUInteger)tx_month:(NSDate *)date;
+ (NSUInteger)tx_year:(NSDate *)date;
+ (NSUInteger)tx_hour:(NSDate *)date;
+ (NSUInteger)tx_minute:(NSDate *)date;
+ (NSUInteger)tx_second:(NSDate *)date;

/**
 * 获取一年中的总天数
 */
- (NSUInteger)tx_daysInYear;
+ (NSUInteger)tx_daysInYear:(NSDate *)date;

/**
 * 判断是否是润年
 * @return YES表示润年，NO表示平年
 */
- (BOOL)tx_isLeapYear;
+ (BOOL)tx_isLeapYear:(NSDate *)date;

/**
 * 获取该日期是该年的第几周
 */
- (NSUInteger)tx_weekOfYear;
+ (NSUInteger)tx_weekOfYear:(NSDate *)date;

/**
 * 获取格式化为YYYY-MM-dd格式的日期字符串
 */
- (NSString *)tx_formatYMD;
+ (NSString *)tx_formatYMD:(NSDate *)date;

/**
 * 返回当前月一共有几周(可能为4,5,6)
 */
- (NSUInteger)tx_weeksOfMonth;
+ (NSUInteger)tx_weeksOfMonth:(NSDate *)date;

/**
 * 获取该月的第一天的日期
 */
- (NSDate *)tx_begindayOfMonth;
+ (NSDate *)tx_begindayOfMonth:(NSDate *)date;

/**
 * 获取该月的最后一天的日期
 */
- (NSDate *)tx_lastdayOfMonth;
+ (NSDate *)tx_lastdayOfMonth:(NSDate *)date;

/**
 * 返回day天后的日期(若day为负数,则为|day|天前的日期)
 */
- (NSDate *)tx_dateAfterDay:(NSUInteger)day;
+ (NSDate *)tx_dateAfterDate:(NSDate *)date day:(NSInteger)day;

/**
 * 返回day天后的日期(若day为负数,则为|day|天前的日期)
 */
- (NSDate *)tx_dateAfterMonth:(NSUInteger)month;
+ (NSDate *)tx_dateAfterDate:(NSDate *)date month:(NSInteger)month;

/**
 * 返回numYears年后的日期
 */
- (NSDate *)tx_offsetYears:(int)numYears;
+ (NSDate *)tx_offsetYears:(int)numYears fromDate:(NSDate *)fromDate;

/**
 * 返回numMonths月后的日期
 */
- (NSDate *)tx_offsetMonths:(int)numMonths;
+ (NSDate *)tx_offsetMonths:(int)numMonths fromDate:(NSDate *)fromDate;

/**
 * 返回numDays天后的日期
 */
- (NSDate *)tx_offsetDays:(int)numDays;
+ (NSDate *)tx_offsetDays:(int)numDays fromDate:(NSDate *)fromDate;

/**
 * 返回numHours小时后的日期
 */
- (NSDate *)tx_offsetHours:(int)hours;
+ (NSDate *)tx_offsetHours:(int)numHours fromDate:(NSDate *)fromDate;

/**
 * 距离该日期前几天
 */
- (NSUInteger)tx_daysAgo;
+ (NSUInteger)tx_daysAgo:(NSDate *)date;

/**
 *  获取星期几
 *
 *  @return Return weekday number
 *  [1 - Sunday]
 *  [2 - Monday]
 *  [3 - Tuerday]
 *  [4 - Wednesday]
 *  [5 - Thursday]
 *  [6 - Friday]
 *  [7 - Saturday]
 */
- (NSInteger)tx_weekday;
+ (NSInteger)tx_weekday:(NSDate *)date;

/**
 *  获取星期几(名称)
 *
 *  @return Return weekday as a localized string
 *  [1 - Sunday]
 *  [2 - Monday]
 *  [3 - Tuerday]
 *  [4 - Wednesday]
 *  [5 - Thursday]
 *  [6 - Friday]
 *  [7 - Saturday]
 */
- (NSString *)tx_dayFromWeekday;
+ (NSString *)tx_dayFromWeekday:(NSDate *)date;

/**
 *  日期是否相等
 *
 *  @param anotherDate The another date to compare as NSDate
 *  @return Return YES if is same day, NO if not
 */
- (BOOL)tx_isSameDay:(NSDate *)anotherDate;

/**
 *  是否是今天
 *
 *  @return Return if self is today
 */
- (BOOL)tx_isToday;

/**
 *  Add days to self
 *
 *  @param days The number of days to add
 *  @return Return self by adding the gived days number
 */
- (NSDate *)tx_dateByAddingDays:(NSUInteger)days;

/**
 *  Get the month as a localized string from the given month number
 *
 *  @param month The month to be converted in string
 *  [1 - January]
 *  [2 - February]
 *  [3 - March]
 *  [4 - April]
 *  [5 - May]
 *  [6 - June]
 *  [7 - July]
 *  [8 - August]
 *  [9 - September]
 *  [10 - October]
 *  [11 - November]
 *  [12 - December]
 *
 *  @return Return the given month as a localized string
 */
+ (NSString *)tx_monthWithMonthNumber:(NSInteger)month;

/**
 * 根据日期返回字符串
 */
+ (NSString *)tx_stringWithDate:(NSDate *)date format:(NSString *)format;
- (NSString *)tx_stringWithFormat:(NSString *)format;
+ (NSDate *)tx_dateWithString:(NSString *)string format:(NSString *)format;

/**
 * 获取指定月份的天数
 */
- (NSUInteger)tx_daysInMonth:(NSUInteger)month;
+ (NSUInteger)tx_daysInMonth:(NSDate *)date month:(NSUInteger)month;

/**
 * 获取当前月份的天数
 */
- (NSUInteger)tx_daysInMonth;
+ (NSUInteger)tx_daysInMonth:(NSDate *)date;

/**
 * 返回刚刚/x分钟前/x小时前/昨天/x天前/x个月前/x年前
 */
- (NSString *)tx_timeInfo;
+ (NSString *)tx_timeInfoWithDate:(NSDate *)date;
+ (NSString *)tx_timeInfoWithDateString:(NSString *)dateString;

/**
 * 返回*年*月*天*小时*分钟*秒
 */
- (NSString *)tx_timeLeft;
+ (NSString *)tx_timeLeftWithDate:(NSDate *)date;
+ (NSString *)tx_timeLeftWithDateString:(NSString *)dateString;

/**
 * 分别获取yyyy-MM-dd/HH:mm:ss/yyyy-MM-dd HH:mm:ss格式的字符串
 */
- (NSString *)tx_ymdFormat;
- (NSString *)tx_hmsFormat;
- (NSString *)tx_ymdHmsFormat;
+ (NSString *)tx_ymdFormat;
+ (NSString *)tx_hmsFormat;
+ (NSString *)tx_ymdHmsFormat;

@end
