//
//  NSString+TXPinyin.m
//  Snowball
//
//  Created by croath on 11/11/13.
//  Copyright (c) 2013 Snowball. All rights reserved.
//

#import "NSString+TXPinyin.h"

@implementation NSString (TXPinyin)

- (NSString*)tx_pinyinWithPhoneticSymbol{
    NSMutableString *pinyin = [NSMutableString stringWithString:self];
    CFStringTransform((__bridge CFMutableStringRef)(pinyin), NULL, kCFStringTransformMandarinLatin, NO);
    return pinyin;
}

- (NSString*)tx_pinyin{
    NSMutableString *pinyin = [NSMutableString stringWithString:[self tx_pinyinWithPhoneticSymbol]];
    CFStringTransform((__bridge CFMutableStringRef)(pinyin), NULL, kCFStringTransformStripCombiningMarks, NO);
    return pinyin;
}

- (NSArray*)tx_pinyinArray{
    NSArray *array = [[self tx_pinyin] componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    return array;
}

- (NSString*)tx_pinyinWithoutBlank{
    NSMutableString *string = [NSMutableString stringWithString:@""];
    for (NSString *str in [self tx_pinyinArray]) {
        [string appendString:str];
    }
    return string;
}

- (NSArray*)tx_pinyinInitialsArray{
    NSMutableArray *array = [NSMutableArray array];
    for (NSString *str in [self tx_pinyinArray]) {
        if ([str length] > 0) {
            [array addObject:[str substringToIndex:1]];
        }
    }
    return array;
}

- (NSString*)tx_pinyinInitialsString{
    NSMutableString *pinyin = [NSMutableString stringWithString:@""];
    for (NSString *str in [self tx_pinyinArray]) {
        if ([str length] > 0) {
            [pinyin appendString:[str substringToIndex:1]];
        }
    }
    return pinyin;
}

@end
