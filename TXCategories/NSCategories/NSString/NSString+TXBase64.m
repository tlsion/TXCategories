//
//  NSString+TXBase64.m
//  TXCategories (https://github.com/tlsion/TXCategories)
//
//  Created by 王-庭协 on 15/2/8.
//  Copyright (c) 2015年 www.skyfox.org. All rights reserved.
//

#import "NSString+TXBase64.h"
#import "NSData+TXBase64.h"

@implementation NSString (Base64)
+ (NSString *)tx_stringWithBase64EncodedString:(NSString *)string
{
    NSData *data = [NSData tx_dataWithBase64EncodedString:string];
    if (data)
    {
        return [[self alloc] initWithData:data encoding:NSUTF8StringEncoding];
    }
    return nil;
}
- (NSString *)tx_base64EncodedStringWithWrapWidth:(NSUInteger)wrapWidth
{
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    return [data tx_base64EncodedStringWithWrapWidth:wrapWidth];
}
- (NSString *)tx_base64EncodedString
{
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    return [data tx_base64EncodedString];
}
- (NSString *)tx_base64DecodedString
{
    return [NSString tx_stringWithBase64EncodedString:self];
}
- (NSData *)tx_base64DecodedData
{
    return [NSData tx_dataWithBase64EncodedString:self];
}
@end
