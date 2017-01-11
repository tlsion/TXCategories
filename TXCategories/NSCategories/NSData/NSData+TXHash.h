//
//  NSData+TXHash.h
//  TXCategories (https://github.com/tlsion/TXCategories)
//
//  Created by 王-庭协 on 2017/1/12.
//  Copyright © 2017年 ApeStar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (TXHash)
/**
 *  @brief  md5 NSData / NSString
 */
@property (readonly) NSData *tx_md5Data;
@property (readonly) NSString *	tx_md5String;

/**
 *  @brief  sha1Data NSData
 */
@property (readonly) NSData *tx_sha1Data;
/**
 *  @brief  sha256Data NSData
 */
@property (readonly) NSData *tx_sha256Data;
/**
 *  @brief  sha512Data NSData
 */
@property (readonly) NSData *tx_sha512Data;

/**
 *  @brief  md5 NSData
 *
 *  @param key 密钥
 *
 *  @return 结果
 */
- (NSData *)tx_hmacMD5DataWithKey:(NSData *)key;
/**
 *  @brief  sha1Data NSData
 *
 *  @param key 密钥
 *
 *  @return 结果
 */
- (NSData *)tx_hmacSHA1DataWithKey:(NSData *)key;
/**
 *  @brief  sha256Data NSData
 *
 *  @param key 密钥
 *
 *  @return 结果
 */
- (NSData *)tx_hmacSHA256DataWithKey:(NSData *)key;
/**
 *  @brief  sha512Data NSData
 *
 *  @param key 密钥
 *
 *  @return 结果
 */
- (NSData *)tx_hmacSHA512DataWithKey:(NSData *)key;
@end
