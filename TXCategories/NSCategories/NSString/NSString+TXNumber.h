//
//  NSString+TXNumber.h
//  TXCategoriesDemo
//
//  Created by Eton on 2017/1/11.
//  Copyright © 2017年 王-庭协. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (TXNumber)


/**
 *  整型
 */
+ (NSString *)tx_valueOfInteger:(NSInteger)value;

/**
 *  浮点型
 */
+ (NSString *)tx_valueOfFloat:(double)value;

/**
 *  小数点后两位字符串
 */
+ (NSString *)tx_valueOfFloat2:(double)value;

/**
 *  去掉小数点后多余的0
 */
+ (NSString*)tx_valueOfFloatZero:(double )value;

/**
 *  价格型 例：￥9.80
 */
+ (NSString *)tx_valueOfPrice:(double)value;

@end
