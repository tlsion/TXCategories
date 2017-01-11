//
//  NSString+TXPinyin.h
//  Snowball
//
//  Created by croath on 11/11/13.
//  Copyright (c) 2013 Snowball. All rights reserved.
//
// https://github.com/croath/NSString-Pinyin
//  the Chinese Pinyin string of the nsstring

#import <Foundation/Foundation.h>

@interface NSString (TXPinyin)

- (NSString*)tx_pinyinWithPhoneticSymbol;
- (NSString*)tx_pinyin;
- (NSArray*)tx_pinyinArray;
- (NSString*)tx_pinyinWithoutBlank;
- (NSArray*)tx_pinyinInitialsArray;
- (NSString*)tx_pinyinInitialsString;

@end
