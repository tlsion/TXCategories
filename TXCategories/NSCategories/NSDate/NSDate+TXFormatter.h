//
//  NSDate+Formatter.h
//  TXCategories (https://github.com/tlsion/TXCategories)
//
//  Created by 王-庭协 on 2017/1/12.
//  Copyright © 2017年 ApeStar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (TXFormatter)

+(NSDateFormatter *)tx_formatter;
+(NSDateFormatter *)tx_formatterWithoutTime;
+(NSDateFormatter *)tx_formatterWithoutDate;

-(NSString *)tx_formatWithUTCTimeZone;
-(NSString *)tx_formatWithLocalTimeZone;
-(NSString *)tx_formatWithTimeZoneOffset:(NSTimeInterval)offset;
-(NSString *)tx_formatWithTimeZone:(NSTimeZone *)timezone;

-(NSString *)tx_formatWithUTCTimeZoneWithoutTime;
-(NSString *)tx_formatWithLocalTimeZoneWithoutTime;
-(NSString *)tx_formatWithTimeZoneOffsetWithoutTime:(NSTimeInterval)offset;
-(NSString *)tx_formatWithTimeZoneWithoutTime:(NSTimeZone *)timezone;

-(NSString *)tx_formatWithUTCWithoutDate;
-(NSString *)tx_formatWithLocalTimeWithoutDate;
-(NSString *)tx_formatWithTimeZoneOffsetWithoutDate:(NSTimeInterval)offset;
-(NSString *)tx_formatTimeWithTimeZone:(NSTimeZone *)timezone;


+ (NSString *)tx_currentDateStringWithFormat:(NSString *)format;
+ (NSDate *)tx_dateWithSecondsFromNow:(NSInteger)seconds;
+ (NSDate *)tx_dateWithYear:(NSInteger)year month:(NSUInteger)month day:(NSUInteger)day;
+ (NSDate *)tx_dateFromString:(NSString *)dateString andDateWithFormat:(NSString *)format;

- (NSString *)tx_stringWithDateFormat:(NSString *)format;

@end
