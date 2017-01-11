// NSDate+CupertinoYankee.m
//  TXCategories (https://github.com/tlsion/TXCategories)
//
//  Created by 王-庭协 on 2017/1/12.
//  Copyright © 2017年 ApeStar. All rights reserved.
//

#import "NSDate+TXCupertinoYankee.h"
#import <UIKit/UIKit.h>
@implementation NSDate (TXCupertinoYankee)

- (NSDate *)tx_beginningOfDay {
    NSCalendar *calendar = [NSCalendar currentCalendar];
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_8_0
    NSDateComponents *components;
    if ([UIDevice currentDevice].systemVersion.floatValue >= 8.0f){
        components = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:self];
    }else{
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        components = [calendar components:NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit fromDate:self];
#pragma clang diagnostic pop
    }
#else
    NSDateComponents *components = [calendar components:NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit fromDate:self];
#endif
    
    return [calendar dateFromComponents:components];
}

- (NSDate *)tx_endOfDay {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setDay:1];
    
    return [[calendar dateByAddingComponents:components toDate:[self tx_beginningOfDay] options:0] dateByAddingTimeInterval:-1];
}

- (NSDate *)tx_beginningOfWeek {
    NSCalendar *calendar = [NSCalendar currentCalendar];
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_8_0
    NSDateComponents *components;
    if ([UIDevice currentDevice].systemVersion.floatValue >= 8.0f){
        components = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitWeekday|NSCalendarUnitDay fromDate:self];
    }else{
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        components = [calendar components:NSYearCalendarUnit | NSMonthCalendarUnit | NSWeekdayCalendarUnit|NSDayCalendarUnit fromDate:self];
#pragma clang diagnostic pop
    }
#else
    NSDateComponents *components = [calendar components:NSYearCalendarUnit | NSMonthCalendarUnit |NSWeekdayCalendarUnit| NSDayCalendarUnit fromDate:self];
#endif

    NSUInteger offset = ([components weekday] == [calendar firstWeekday]) ? 6 : [components weekday] - 2;
    [components setDay:[components day] - offset];

    return [calendar dateFromComponents:components];
}

- (NSDate *)tx_endOfWeek {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setWeekOfMonth:1];
    
    return [[calendar dateByAddingComponents:components toDate:[self tx_beginningOfWeek] options:0] dateByAddingTimeInterval:-1];}

- (NSDate *)tx_beginningOfMonth {
    NSCalendar *calendar = [NSCalendar currentCalendar];
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_8_0
    NSDateComponents *components;
    if ([UIDevice currentDevice].systemVersion.floatValue >= 8.0f){
        components = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth  fromDate:self];
    }else{
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        components = [calendar components:NSYearCalendarUnit | NSMonthCalendarUnit fromDate:self];
#pragma clang diagnostic pop
    }
#else
    NSDateComponents *components = [calendar components:NSYearCalendarUnit | NSMonthCalendarUnit fromDate:self];
#endif
    return [calendar dateFromComponents:components];
}

- (NSDate *)tx_endOfMonth {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setMonth:1];
    
    return [[calendar dateByAddingComponents:components toDate:[self tx_beginningOfMonth] options:0] dateByAddingTimeInterval:-1];
}

- (NSDate *)tx_beginningOfYear {
    NSCalendar *calendar = [NSCalendar currentCalendar];
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_8_0
    NSDateComponents *components;
    if ([UIDevice currentDevice].systemVersion.floatValue >= 8.0f){
        components = [calendar components:NSCalendarUnitYear   fromDate:self];
    }else{
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        components = [calendar components:NSYearCalendarUnit  fromDate:self];
#pragma clang diagnostic pop
    }
#else
    NSDateComponents *components = [calendar components:NSYearCalendarUnit  fromDate:self];
#endif
    return [calendar dateFromComponents:components];
}

- (NSDate *)tx_endOfYear {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setYear:1];
    
    return [[calendar dateByAddingComponents:components toDate:[self tx_beginningOfYear] options:0] dateByAddingTimeInterval:-1];
}

@end
