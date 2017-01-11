//
//  NSObject+TXConversion.m
//  TXCategoriesDemo
//
//  Created by Eton on 2017/1/11.
//  Copyright © 2017年 王-庭协. All rights reserved.
//

#import "NSObject+TXConversion.h"

@implementation NSObject (TXConversion)

- (NSInteger)txInteger
{
    return [[self txNSNumber] integerValue];
}

- (float)txFloat
{
    return [[self txNSNumber] floatValue];
}

- (BOOL)txBool
{
    return [[self txNSNumber] boolValue];
}

- (NSNumber *)txNSNumber
{
    if ( [self isKindOfClass:[NSNumber class]] )
    {
        return (NSNumber *)self;
    }
    else if ( [self isKindOfClass:[NSString class]] )
    {
        return [NSNumber numberWithFloat:[(NSString *)self floatValue]];
    }
    else if ( [self isKindOfClass:[NSDate class]] )
    {
        return [NSNumber numberWithDouble:[(NSDate *)self timeIntervalSince1970]];
    }
    else if ( [self isKindOfClass:[NSNull class]] )
    {
        return [NSNumber numberWithInteger:0];
    }
    
    return nil;
}

- (NSString *)txNSString
{
    if ( [self isKindOfClass:[NSNull class]] )
        return nil;
    
    if ( [self isKindOfClass:[NSString class]] )
    {
        return (NSString *)self;
    }
    else if ( [self isKindOfClass:[NSData class]] )
    {
        NSData * data = (NSData *)self;
        
        NSString * text = [[NSString alloc] initWithBytes:data.bytes length:data.length encoding:NSUTF8StringEncoding];
        if ( nil == text )
        {
            text = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            if ( nil == text )
            {
                text = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
            }
        }
        return text;
    }
    else
    {
        return [NSString stringWithFormat:@"%@", self];
    }
}

- (NSDate *)txNSDate
{
    if ( [self isKindOfClass:[NSDate class]] )
    {
        return (NSDate *)self;
    }
    else if ( [self isKindOfClass:[NSString class]] )
    {
        NSDate * date = nil;
        
        if ( nil == date )
        {
            static NSDateFormatter * formatter = nil;
            
            if ( nil == formatter )
            {
                formatter = [[NSDateFormatter alloc] init];
                [formatter setDateFormat:@"yyyy/MM/dd HH:mm:ss z"];
                [formatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
            }
            
            date = [formatter dateFromString:(NSString *)self];
        }
        
        if ( nil == date )
        {
            static NSDateFormatter * formatter = nil;
            
            if ( nil == formatter )
            {
                formatter = [[NSDateFormatter alloc] init];
                [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss z"];
                [formatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
            }
            
            date = [formatter dateFromString:(NSString *)self];
        }
        
        if ( nil == date )
        {
            static NSDateFormatter * formatter = nil;
            
            if ( nil == formatter )
            {
                formatter = [[NSDateFormatter alloc] init];
                [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
                [formatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
            }
            
            date = [formatter dateFromString:(NSString *)self];
        }
        
        if ( nil == date )
        {
            static NSDateFormatter * formatter = nil;
            
            if ( nil == formatter )
            {
                formatter = [[NSDateFormatter alloc] init];
                [formatter setDateFormat:@"yyyy/MM/dd HH:mm:ss"];
                [formatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
            }
            
            date = [formatter dateFromString:(NSString *)self];
        }
        
        return date;
        
        //		NSTimeZone * local = [NSTimeZone localTimeZone];
        //		return [NSDate dateWithTimeInterval:(3600 + [local secondsFromGMT])
        //								  sinceDate:[dateFormatter dateFromString:text]];
    }
    else
    {
        return [NSDate dateWithTimeIntervalSince1970:[self txNSNumber].doubleValue];
    }
    
    return nil;
}

- (NSData *)txNSData
{
    if ( [self isKindOfClass:[NSString class]] )
    {
        return [(NSString *)self dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    }
    else if ( [self isKindOfClass:[NSData class]] )
    {
        return (NSData *)self;
    }
    
    return nil;
}

- (NSArray *)txNSArray
{
    if ( [self isKindOfClass:[NSArray class]] )
    {
        return (NSArray *)self;
    }
    else
    {
        return [NSArray arrayWithObject:self];
    }
}

- (NSMutableArray *)txNSMutableArray
{
    if ( [self isKindOfClass:[NSMutableArray class]] )
    {
        return (NSMutableArray *)self;
    }
    
    return nil;
}

- (NSDictionary *)txNSDictionary
{
    if ( [self isKindOfClass:[NSDictionary class]] )
    {
        return (NSDictionary *)self;
    }
    
    return nil;
}

- (NSMutableDictionary *)txNSMutableDictionary
{
    if ( [self isKindOfClass:[NSMutableDictionary class]] )
    {
        return (NSMutableDictionary *)self;
    }
    
    NSDictionary * dict = [self txNSDictionary];
    if ( nil == dict )
        return nil;
    
    return [NSMutableDictionary dictionaryWithDictionary:dict];
}

@end
