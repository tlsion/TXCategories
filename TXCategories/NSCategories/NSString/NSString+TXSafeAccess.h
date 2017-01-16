//
//  NSString+TXSafeAccess.h
//  Youhu
//
//  Created by Eton on 2017/1/16.
//  Copyright © 2017年 ApeStar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (TXSafeAccess)

/**
 *  @brief  指定有值的范围
 *
 *   @param searchString 指定字段
 *
 *  @return 反转后字符串
 */
- (NSRange)tx_rangeOfString:(NSString *)searchString;

/**
 *  @brief  反转字符串
 *
 *  @return 反转后字符串
 */
- (NSString *)tx_reverseString;

/**
 *  @brief  整型
 */
- (NSString *)tx_integerValue;

/**
 *  @brief  浮点型
 */
- (NSString *)tx_floatValue;

/**
 *  @brief  小数点后两位字符串
 */
- (NSString *)tx_float2Value;

/**
 *  @brief 去掉小数点后多余的0
 */
- (NSString*)tx_floatZeroValue;

/**
 * @brief  价格型 例：￥9.80
 */
- (NSString *)tx_priceValue;


- (NSString *)tx_trim;
- (NSString *)tx_unwrap;
- (NSString *)tx_normalize;

@end
