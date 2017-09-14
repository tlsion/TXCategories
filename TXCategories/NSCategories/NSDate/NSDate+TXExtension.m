//
//  NSDate+Extension.m
//  TXCategories (https://github.com/tlsion/TXCategories)
//
//  Created by 王-庭协 on 2017/1/12.
//  Copyright © 2017年 ApeStar. All rights reserved.
//

#import "NSDate+TXExtension.h"
#import "NSDate+TXUtilities.h"

@implementation NSDate (TXExtension)

- (NSUInteger)tx_day {
    return [NSDate tx_day:self];
}

- (NSUInteger)tx_month {
    return [NSDate tx_month:self];
}

- (NSUInteger)tx_year {
    return [NSDate tx_year:self];
}

- (NSUInteger)tx_hour {
    return [NSDate tx_hour:self];
}

- (NSUInteger)tx_minute {
    return [NSDate tx_minute:self];
}

- (NSUInteger)tx_second {
    return [NSDate tx_second:self];
}

+ (NSUInteger)tx_day:(NSDate *)date {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    // NSDayCalendarUnit
    NSDateComponents *dayComponents = [calendar components:(NSCalendarUnitDay) fromDate:date];
#else
    NSDateComponents *dayComponents = [calendar components:(NSDayCalendarUnit) fromDate:date];
#endif
    
    return [dayComponents day];
}

+ (NSUInteger)tx_month:(NSDate *)date {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    // NSDayCalendarUnit
    NSDateComponents *dayComponents = [calendar components:(NSCalendarUnitMonth) fromDate:date];
#else
    NSDateComponents *dayComponents = [calendar components:(NSMonthCalendarUnit) fromDate:date];
#endif
    
    return [dayComponents month];
}

+ (NSUInteger)tx_year:(NSDate *)date {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    // NSDayCalendarUnit
    NSDateComponents *dayComponents = [calendar components:(NSCalendarUnitYear) fromDate:date];
#else
    NSDateComponents *dayComponents = [calendar components:(NSYearCalendarUnit) fromDate:date];
#endif
    
    return [dayComponents year];
}

+ (NSUInteger)tx_hour:(NSDate *)date {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    // NSDayCalendarUnit
    NSDateComponents *dayComponents = [calendar components:(NSCalendarUnitHour) fromDate:date];
#else
    NSDateComponents *dayComponents = [calendar components:(NSHourCalendarUnit) fromDate:date];
#endif
    
    return [dayComponents hour];
}

+ (NSUInteger)tx_minute:(NSDate *)date {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    // NSDayCalendarUnit
    NSDateComponents *dayComponents = [calendar components:(NSCalendarUnitMinute) fromDate:date];
#else
    NSDateComponents *dayComponents = [calendar components:(NSMinuteCalendarUnit) fromDate:date];
#endif
    
    return [dayComponents minute];
}

+ (NSUInteger)tx_second:(NSDate *)date {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    // NSDayCalendarUnit
    NSDateComponents *dayComponents = [calendar components:(NSCalendarUnitSecond) fromDate:date];
#else
    NSDateComponents *dayComponents = [calendar components:(NSSecondCalendarUnit) fromDate:date];
#endif
    
    return [dayComponents second];
}

- (NSUInteger)tx_daysInYear {
    return [NSDate tx_daysInYear:self];
}

+ (NSUInteger)tx_daysInYear:(NSDate *)date {
    return [self tx_isLeapYear:date] ? 366 : 365;
}

- (BOOL)tx_isLeapYear {
    return [NSDate tx_isLeapYear:self];
}

+ (BOOL)tx_isLeapYear:(NSDate *)date {
    NSUInteger year = [date tx_year];
    if ((year % 4  == 0 && year % 100 != 0) || year % 400 == 0) {
        return YES;
    }
    return NO;
}

- (NSString *)tx_formatYMD {
    return [NSDate tx_formatYMD:self];
}

+ (NSString *)tx_formatYMD:(NSDate *)date {
    return [NSString stringWithFormat:@"%lu-%02lu-%02lu",[date tx_year],[date tx_month], [date tx_day]];
}

- (NSUInteger)tx_weeksOfMonth {
    return [NSDate tx_weeksOfMonth:self];
}

+ (NSUInteger)tx_weeksOfMonth:(NSDate *)date {
    return [[date tx_lastdayOfMonth] tx_weekOfYear] - [[date tx_begindayOfMonth] tx_weekOfYear] + 1;
}

- (NSUInteger)tx_weekOfYear {
    return [NSDate tx_weekOfYear:self];
}

+ (NSUInteger)tx_weekOfYear:(NSDate *)date {
    NSUInteger i;
    NSUInteger year = [date tx_year];
    
    NSDate *lastdate = [date tx_lastdayOfMonth];
    
    for (i = 1;[[lastdate tx_dateAfterDay:-7 * i] tx_year] == year; i++) {
        
    }
    
    return i;
}

- (NSDate *)tx_dateAfterDay:(NSUInteger)day {
    return [NSDate tx_dateAfterDate:self day:day];
}

+ (NSDate *)tx_dateAfterDate:(NSDate *)date day:(NSInteger)day {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *componentsToAdd = [[NSDateComponents alloc] init];
    [componentsToAdd setDay:day];
    
    NSDate *dateAfterDay = [calendar dateByAddingComponents:componentsToAdd toDate:date options:0];
    
    return dateAfterDay;
}

- (NSDate *)tx_dateAfterMonth:(NSUInteger)month {
    return [NSDate tx_dateAfterDate:self month:month];
}

+ (NSDate *)tx_dateAfterDate:(NSDate *)date month:(NSInteger)month {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *componentsToAdd = [[NSDateComponents alloc] init];
    [componentsToAdd setMonth:month];
    NSDate *dateAfterMonth = [calendar dateByAddingComponents:componentsToAdd toDate:date options:0];
    
    return dateAfterMonth;
}

- (NSDate *)tx_begindayOfMonth {
    return [NSDate tx_begindayOfMonth:self];
}

+ (NSDate *)tx_begindayOfMonth:(NSDate *)date {
    return [self tx_dateAfterDate:date day:-[date tx_day] + 1];
}

- (NSDate *)tx_lastdayOfMonth {
    return [NSDate tx_lastdayOfMonth:self];
}

+ (NSDate *)tx_lastdayOfMonth:(NSDate *)date {
    NSDate *lastDate = [self tx_begindayOfMonth:date];
    return [[lastDate tx_dateAfterMonth:1] tx_dateAfterDay:-1];
}

- (NSUInteger)tx_daysAgo {
    return [NSDate tx_daysAgo:self];
}

+ (NSUInteger)tx_daysAgo:(NSDate *)date {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    NSDateComponents *components = [calendar components:(NSCalendarUnitDay)
                                               fromDate:date
                                                 toDate:[NSDate date]
                                                options:0];
#else
    NSDateComponents *components = [calendar components:(NSDayCalendarUnit)
                                               fromDate:date
                                                 toDate:[NSDate date]
                                                options:0];
#endif
    
    return [components day];
}

- (NSInteger)tx_weekday {
    return [NSDate tx_weekday:self];
}

+ (NSInteger)tx_weekday:(NSDate *)date {
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *comps = [gregorian components:(NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear | NSCalendarUnitWeekday) fromDate:date];
    NSInteger weekday = [comps weekday];
    
    return weekday;
}

- (NSString *)tx_dayFromWeekday {
    return [NSDate tx_dayFromWeekday:self];
}

+ (NSString *)tx_dayFromWeekday:(NSDate *)date {
    switch([date tx_weekday]) {
        case 1:
            return @"星期天";
            break;
        case 2:
            return @"星期一";
            break;
        case 3:
            return @"星期二";
            break;
        case 4:
            return @"星期三";
            break;
        case 5:
            return @"星期四";
            break;
        case 6:
            return @"星期五";
            break;
        case 7:
            return @"星期六";
            break;
        default:
            break;
    }
    return @"";
}

- (BOOL)tx_isSameDay:(NSDate *)anotherDate {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components1 = [calendar components:(NSCalendarUnitYear
                                                          | NSCalendarUnitMonth
                                                          | NSCalendarUnitDay)
                                                fromDate:self];
    NSDateComponents *components2 = [calendar components:(NSCalendarUnitYear
                                                          | NSCalendarUnitMonth
                                                          | NSCalendarUnitDay)
                                                fromDate:anotherDate];
    return ([components1 year] == [components2 year]
            && [components1 month] == [components2 month]
            && [components1 day] == [components2 day]);
}

- (BOOL)tx_isToday {
    return [self tx_isSameDay:[NSDate date]];
}

- (NSDate *)tx_dateByAddingDays:(NSUInteger)days {
    NSDateComponents *c = [[NSDateComponents alloc] init];
    c.day = days;
    return [[NSCalendar currentCalendar] dateByAddingComponents:c toDate:self options:0];
}

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
+ (NSString *)tx_monthWithMonthNumber:(NSInteger)month {
    switch(month) {
        case 1:
            return @"January";
            break;
        case 2:
            return @"February";
            break;
        case 3:
            return @"March";
            break;
        case 4:
            return @"April";
            break;
        case 5:
            return @"May";
            break;
        case 6:
            return @"June";
            break;
        case 7:
            return @"July";
            break;
        case 8:
            return @"August";
            break;
        case 9:
            return @"September";
            break;
        case 10:
            return @"October";
            break;
        case 11:
            return @"November";
            break;
        case 12:
            return @"December";
            break;
        default:
            break;
    }
    return @"";
}

+ (NSString *)tx_stringWithDate:(NSDate *)date format:(NSString *)format {
    return [date tx_stringWithFormat:format];
}

- (NSString *)tx_stringWithFormat:(NSString *)format {
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    [outputFormatter setDateFormat:format];
    
    NSString *retStr = [outputFormatter stringFromDate:self];
    
    return retStr;
}

+ (NSDate *)tx_dateWithString:(NSString *)string format:(NSString *)format {
    NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init];
    [inputFormatter setDateFormat:format];
    
    NSDate *date = [inputFormatter dateFromString:string];
    
    return date;
}

- (NSUInteger)tx_daysInMonth:(NSUInteger)month {
    return [NSDate tx_daysInMonth:self month:month];
}

+ (NSUInteger)tx_daysInMonth:(NSDate *)date month:(NSUInteger)month {
    switch (month) {
        case 1: case 3: case 5: case 7: case 8: case 10: case 12:
            return 31;
        case 2:
            return [date tx_isLeapYear] ? 29 : 28;
    }
    return 30;
}

- (NSUInteger)tx_daysInMonth {
    return [NSDate tx_daysInMonth:self];
}

+ (NSUInteger)tx_daysInMonth:(NSDate *)date {
    return [self tx_daysInMonth:date month:[date tx_month]];
}

- (NSString *)tx_timeInfo {
    return [NSDate tx_timeInfoWithDate:self];
}

+ (NSString *)tx_timeInfoWithDate:(NSDate *)date {
    return [self tx_timeInfoWithDateString:[self tx_stringWithDate:date format:[self tx_ymdHmsFormat]]];
}

+ (NSString *)tx_timeInfoWithDateString:(NSString *)dateString {
    NSDate *date = [self tx_dateWithString:dateString format:[self tx_ymdHmsFormat]];
    
    NSDate *curDate = [NSDate date];
    NSTimeInterval time = -[date timeIntervalSinceDate:curDate];
    
    int month = (int)([curDate tx_month] - [date tx_month]);
    int year = (int)([curDate tx_year] - [date tx_year]);
    int day = (int)([curDate tx_day] - [date tx_day]);
    
    NSTimeInterval retTime = 1.0;
    if (time < 60)
    {
        return @"刚刚";
    }
    else if (time < 3600) { // 小于一小时
        retTime = time / 60;
        retTime = retTime <= 0.0 ? 1.0 : retTime;
        return [NSString stringWithFormat:@"%.0f分钟前", retTime];
    } else if (time < 3600 * 24) { // 小于一天，也就是今天
        retTime = time / 3600;
        retTime = retTime <= 0.0 ? 1.0 : retTime;
        return [NSString stringWithFormat:@"%.0f小时前", retTime];
    } else if (time < 3600 * 24 * 2 && [date tx_isYesterday]) {
        return @"昨天";
    }
    // 第一个条件是同年，且相隔时间在一个月内
    // 第二个条件是隔年，对于隔年，只能是去年12月与今年1月这种情况
    else if ((abs(year) == 0 && abs(month) <= 1)
             || (abs(year) == 1 && [curDate tx_month] == 1 && [date tx_month] == 12)) {
        int retDay = 0;
        if (year == 0) { // 同年
            if (month == 0) { // 同月
                retDay = day;
            }
        }
        
        if (retDay <= 0) {
            // 获取发布日期中，该月有多少天
            int totalDays = (int)[self tx_daysInMonth:date month:[date tx_month]];
            
            // 当前天数 + （发布日期月中的总天数-发布日期月中发布日，即等于距离今天的天数）
            retDay = (int)[curDate tx_day] + (totalDays - (int)[date tx_day]);
        }
        
        return [NSString stringWithFormat:@"%d天前", (abs)(retDay)];
    } else  {
        if (abs(year) <= 1) {
            if (year == 0) { // 同年
                return [NSString stringWithFormat:@"%d个月前", abs(month)];
            }
            
            // 隔年
            int month = (int)[curDate tx_month];
            int preMonth = (int)[date tx_month];
            if (month == 12 && preMonth == 12) {// 隔年，但同月，就作为满一年来计算
                return @"1年前";
            }
            return [NSString stringWithFormat:@"%d个月前", (abs)(12 - preMonth + month)];
        }
        
        return [NSString stringWithFormat:@"%d年前", abs(year)];
    }
    
    return @"1小时前";
}

/**
 * 返回*年*月*天*小时*分钟*秒
 */
- (NSString *)tx_timeLeft{
    return [NSDate tx_timeLeftWithDate:self];
}
    
+ (NSString *)tx_timeLeftWithDate:(NSDate *)date{
    return [self tx_timeLeftWithDateString:[self tx_stringWithDate:date format:[self tx_ymdHmsFormat]]];
}

+ (NSString *)tx_timeLeftWithDateString:(NSString *)dateString{
    NSDate *date = [self tx_dateWithString:dateString format:[self tx_ymdHmsFormat]];
    long int delta = lround( [date timeIntervalSinceDate:[NSDate date]] );
    
    NSMutableString * result = [NSMutableString string];
    
    if ( delta >= TX_D_YEAR )
    {
        NSInteger years = ( delta / TX_D_YEAR );
        [result appendFormat:@"%ld年", (long)years];
        delta -= years * TX_D_YEAR ;
    }
    
    if ( delta >= TX_D_MONTH )
    {
        NSInteger months = ( delta / TX_D_MONTH );
        [result appendFormat:@"%ld月", (long)months];
        delta -= months * TX_D_MONTH ;
    }
    
    if ( delta >= TX_D_DAY )
    {
        NSInteger days = ( delta / TX_D_DAY );
        [result appendFormat:@"%ld天", (long)days];
        delta -= days * TX_D_DAY ;
    }
    
    if ( delta >= TX_D_HOUR )
    {
        NSInteger hours = ( delta / TX_D_HOUR );
        [result appendFormat:@"%ld小时", (long)hours];
        delta -= hours * TX_D_HOUR ;
    }
    
    if ( delta >= TX_D_MINUTE )
    {
        NSInteger minutes = ( delta / TX_D_MINUTE );
        [result appendFormat:@"%ld分钟", (long)minutes];
        delta -= minutes * TX_D_MINUTE ;
    }
    
    NSInteger seconds = ( delta / TX_D_SECOND );
    [result appendFormat:@"%ld秒", (long)seconds];
    
    return result;
}

- (NSString *)tx_ymdFormat {
    return [NSDate tx_ymdFormat];
}

- (NSString *)tx_hmsFormat {
    return [NSDate tx_hmsFormat];
}

- (NSString *)tx_ymdHmsFormat {
    return [NSDate tx_ymdHmsFormat];
}

+ (NSString *)tx_ymdFormat {
    return @"yyyy-MM-dd";
}

+ (NSString *)tx_hmsFormat {
    return @"HH:mm:ss";
}

+ (NSString *)tx_ymdHmsFormat {
    return [NSString stringWithFormat:@"%@ %@", [self tx_ymdFormat], [self tx_hmsFormat]];
}

- (NSDate *)tx_offsetYears:(int)numYears {
    return [NSDate tx_offsetYears:numYears fromDate:self];
}

+ (NSDate *)tx_offsetYears:(int)numYears fromDate:(NSDate *)fromDate {
    if (fromDate == nil) {
        return nil;
    }
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    // NSDayCalendarUnit
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
#else
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSGregorianCalendar];
#endif
    
    
    NSDateComponents *offsetComponents = [[NSDateComponents alloc] init];
    [offsetComponents setYear:numYears];
    
    return [gregorian dateByAddingComponents:offsetComponents
                                      toDate:fromDate
                                     options:0];
}

- (NSDate *)tx_offsetMonths:(int)numMonths {
    return [NSDate tx_offsetMonths:numMonths fromDate:self];
}

+ (NSDate *)tx_offsetMonths:(int)numMonths fromDate:(NSDate *)fromDate {
    if (fromDate == nil) {
        return nil;
    }
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    // NSDayCalendarUnit
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
#else
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSGregorianCalendar];
#endif
    
    
    NSDateComponents *offsetComponents = [[NSDateComponents alloc] init];
    [offsetComponents setMonth:numMonths];
    
    return [gregorian dateByAddingComponents:offsetComponents
                                      toDate:fromDate
                                     options:0];
}

- (NSDate *)tx_offsetDays:(int)numDays {
    return [NSDate tx_offsetDays:numDays fromDate:self];
}

+ (NSDate *)tx_offsetDays:(int)numDays fromDate:(NSDate *)fromDate {
    if (fromDate == nil) {
        return nil;
    }
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    // NSDayCalendarUnit
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
#else
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSGregorianCalendar];
#endif
    
    
    NSDateComponents *offsetComponents = [[NSDateComponents alloc] init];
    [offsetComponents setDay:numDays];
    
    return [gregorian dateByAddingComponents:offsetComponents
                                      toDate:fromDate
                                     options:0];
}

- (NSDate *)tx_offsetHours:(int)hours {
    return [NSDate tx_offsetHours:hours fromDate:self];
}

+ (NSDate *)tx_offsetHours:(int)numHours fromDate:(NSDate *)fromDate {
    if (fromDate == nil) {
        return nil;
    }
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    // NSDayCalendarUnit
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
#else
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSGregorianCalendar];
#endif
    
    
    NSDateComponents *offsetComponents = [[NSDateComponents alloc] init];
    [offsetComponents setHour:numHours];
    
    return [gregorian dateByAddingComponents:offsetComponents
                                      toDate:fromDate
                                     options:0];
}
@end
