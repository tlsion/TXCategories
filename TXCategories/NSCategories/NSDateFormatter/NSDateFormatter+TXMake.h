//
//  NSDateFormatter+Make.h
//  TXCategories (https://github.com/tlsion/TXCategories)
//
//  Created by 王-庭协 on 2017/1/12.
//  Copyright © 2017年 ApeStar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDateFormatter (TXMake)
+(NSDateFormatter *)tx_dateFormatterWithFormat:(NSString *)format;
+(NSDateFormatter *)tx_dateFormatterWithFormat:(NSString *)format timeZone:(NSTimeZone *)timeZone;
+(NSDateFormatter *)tx_dateFormatterWithFormat:(NSString *)format timeZone:(NSTimeZone *)timeZone locale:(NSLocale *)locale;
+(NSDateFormatter *)tx_dateFormatterWithDateStyle:(NSDateFormatterStyle)style;
+(NSDateFormatter *)tx_dateFormatterWithDateStyle:(NSDateFormatterStyle)style timeZone:(NSTimeZone *)timeZone;
+(NSDateFormatter *)tx_dateFormatterWithTimeStyle:(NSDateFormatterStyle)style;
+(NSDateFormatter *)tx_dateFormatterWithTimeStyle:(NSDateFormatterStyle)style timeZone:(NSTimeZone *)timeZone;
@end
