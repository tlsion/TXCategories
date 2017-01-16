//
//  NSObject+TXNull.m
//  Youhu
//
//  Created by Eton on 2017/1/16.
//  Copyright © 2017年 ApeStar. All rights reserved.
//

#import "NSObject+TXNull.h"

@implementation NSObject (TXNull)

- (BOOL)tx_isNotNull
{
    if ([self isEqual:[NSNull null]]) {
        return NO;
    }
    else if ([self isKindOfClass:[NSNull class]])
    {
        return NO;
    }
    else if (self==nil){
        return NO;
    }
    else {
        if ([self isKindOfClass:[NSString class]]) {
            NSString *str = (NSString *)self;
            if ([str isEqualToString:@""]) {
                return NO;
            }
            return YES;
        }
        else if([self isKindOfClass:[NSArray class]]){
            NSArray *arr = (NSArray *)self;
            if (![arr count]) {
                return NO;
            }
            return YES;
        }
        else if([self isKindOfClass:[NSDictionary class]]){
            NSDictionary *dic = (NSDictionary *)self;
            if (![dic count]) {
                return NO;
            }
        }else if([self isKindOfClass:[NSNumber class]]){
            NSNumber *num = (NSNumber *)self;
            if (num.doubleValue == 0) {
                return NO;
            }
        }
        return YES;
    }
    return YES;
}

@end
