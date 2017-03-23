//
//  NSDictionary+TXJSONString.h
//  TXCategories (https://github.com/tlsion/TXCategories)
//
//  Created by 王-庭协 on 2017/1/12.
//  Copyright © 2017年 ApeStar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (TXJSONString)
/**
 *  @brief NSDictionary转换成JSON字符串
 *
 *  @return  JSON字符串
 */
-(NSString *)tx_JSONString;

+ (NSDictionary *)dictionaryWithJsonString:(NSString *)JSONString;

@end
