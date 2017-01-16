//
//  NSString+TXSafeAccess.m
//  Youhu
//
//  Created by Eton on 2017/1/16.
//  Copyright © 2017年 ApeStar. All rights reserved.
//

#import "NSString+TXSafeAccess.h"

@implementation NSString (TXSafeAccess)

- (NSRange)tx_rangeOfString:(NSString *)searchString{
    NSRange range = [self rangeOfString:searchString];
    if (range.length > 0) {
        return range;
    }
    return NSMakeRange(0, 0);
}

- (NSString *)tx_reverseString
{
    NSMutableString* reverseString = [[NSMutableString alloc] init];
    NSInteger charIndex = [self length];
    while (charIndex > 0) {
        charIndex --;
        NSRange subStrRange = NSMakeRange(charIndex, 1);
        [reverseString appendString:[self substringWithRange:subStrRange]];
    }
    return reverseString;
}

- (NSString *)tx_integerValue{
    return [NSString tx_valueOfInteger:[self integerValue]];
}

- (NSString *)tx_floatValue{
    return [NSString tx_valueOfFloat:[self doubleValue]];
}

- (NSString *)tx_float2Value{
    return [NSString tx_valueOfFloat2:[self doubleValue]];
}

- (NSString*)tx_floatZeroValue{
    return [NSString tx_valueOfFloatZero:[self doubleValue]];
}

- (NSString *)tx_priceValue{
    return [NSString tx_valueOfPrice:[self doubleValue]];
}


- (NSString *)tx_trim
{
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

- (NSString *)tx_unwrap
{
    if ( self.length >= 2 )
    {
        if ( [self hasPrefix:@"\""] && [self hasSuffix:@"\""] )
        {
            return [self substringWithRange:NSMakeRange(1, self.length - 2)];
        }
        
        if ( [self hasPrefix:@"'"] && [self hasSuffix:@"'"] )
        {
            return [self substringWithRange:NSMakeRange(1, self.length - 2)];
        }
    }
    
    return self;
}

- (NSString *)tx_normalize
{
    return [self stringByReplacingOccurrencesOfString:@"//" withString:@"/"];
}
@end
