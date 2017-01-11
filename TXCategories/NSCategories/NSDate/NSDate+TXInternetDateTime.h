//
//  NSDate+InternetDateTime.h
//  TXCategories (https://github.com/tlsion/TXCategories)
//
//  Created by 王-庭协 on 2017/1/12.
//  Copyright © 2017年 ApeStar. All rights reserved.
//

#import <Foundation/Foundation.h>

// Formatting hints
typedef enum {
    DateFormatHintNone, 
    DateFormatHintRFC822, 
    DateFormatHintRFC3339
} DateFormatHint;

// A category to parse internet date & time strings
@interface NSDate (TXInternetDateTime)

// Get date from RFC3339 or RFC822 string
// - A format/specification hint can be used to speed up, 
//   otherwise both will be attempted in order to get a date
+ (NSDate *)tx_dateFromInternetDateTimeString:(NSString *)dateString
                                formatHint:(DateFormatHint)hint;

// Get date from a string using a specific date specification
+ (NSDate *)tx_dateFromRFC3339String:(NSString *)dateString;
+ (NSDate *)tx_dateFromRFC822String:(NSString *)dateString;

@end
