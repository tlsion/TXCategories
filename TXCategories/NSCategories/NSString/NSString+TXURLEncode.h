//
//  NSString+UrlEncode.h
//  TXCategories (https://github.com/tlsion/TXCategories)
//
//  Created by 王-庭协 on 14/12/15.
//  Copyright (c) 2014年 www.skyfox.org. All rights reserved.
//


#import <Foundation/Foundation.h>

@interface NSString (TXURLEncode)
@property (nonatomic, readonly) NSURL *   URL;

/**
 *  @brief  urlEncode
 *
 *  @return urlEncode 后的字符串
 */
- (NSString *)tx_urlEncode;
/**
 *  @brief  urlEncode
 *
 *  @param encoding encoding模式
 *
 *  @return urlEncode 后的字符串
 */
- (NSString *)tx_urlEncodeUsingEncoding:(NSStringEncoding)encoding;
/**
 *  @brief  urlDecode
 *
 *  @return urlDecode 后的字符串
 */
- (NSString *)tx_urlDecode;
/**
 *  @brief  urlDecode
 *
 *  @param encoding encoding模式
 *
 *  @return urlDecode 后的字符串
 */
- (NSString *)tx_urlDecodeUsingEncoding:(NSStringEncoding)encoding;

/**
 *  @brief  url query转成NSDictionary
 *
 *  @return NSDictionary
 */
- (NSDictionary *)tx_dictionaryFromURLParameters;

/**
 *  @brief  Unicode编码的字符串转成NSString
 *
 *  @return Unicode编码的字符串转成NSString
 */
- (NSString *)tx_makeUnicodeToString;
@end
