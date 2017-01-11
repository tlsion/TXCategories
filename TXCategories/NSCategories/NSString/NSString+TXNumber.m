//
//  NSString+TXNumber.m
//  TXCategoriesDemo
//
//  Created by Eton on 2017/1/11.
//  Copyright © 2017年 王-庭协. All rights reserved.
//

#import "NSString+TXNumber.h"

@implementation NSString (TXNumber)

+ (NSString *)tx_valueOfInteger:(NSInteger)value
{
    NSString *str = [NSString stringWithFormat:@"%ld",(long)value];
    return str;
}

+ (NSString *)tx_valueOfFloat:(double)value
{
    NSString *str = [NSString stringWithFormat:@"%f",value];
    
    return str;
}

+ (NSString *)tx_valueOfFloat2:(double)value
{
    NSString *str = [NSString stringWithFormat:@"%.2f",value];
    
    return str;
}

+ (NSString*)tx_valueOfFloatZero:(double )value
{
    NSString * testNumber = [NSString stringWithFormat:@"%f",value];
    NSRange range = [testNumber rangeOfString:@"."]; //现获取要截取的字符串位置
    
    if (range.length>0) {
        NSString * s = nil;
        NSInteger offset = testNumber.length - 1;
        while (offset)
        {
            s = [testNumber substringWithRange:NSMakeRange(offset, 1)];
            if (offset >= range.location && ([s isEqualToString:@"0"] || [s isEqualToString:@"."]))
            {
                offset--;
            }
            else
            {
                break;
            }
        }
        testNumber = [testNumber substringToIndex:offset+1];
    }
    return testNumber;
}


+ (NSString *)tx_valueOfPrice:(double)value
{
    NSString *str = [NSString stringWithFormat:@"￥%.2f",value];
    
    return str;
}
@end
