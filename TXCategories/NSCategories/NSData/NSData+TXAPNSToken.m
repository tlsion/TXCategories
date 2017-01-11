//
//  NSData+TXAPNSToken.m
//  TXCategories (https://github.com/tlsion/TXCategories)
//
//  Created by 王-庭协 on 2017/1/12.
//  Copyright © 2017年 ApeStar. All rights reserved.
//

#import "NSData+TXAPNSToken.h"

@implementation NSData (TXAPNSToken)
/**
 *  @brief  将APNS NSData类型token 格式化成字符串
 *
 *  @return 字符串token
 */
- (NSString *)tx_APNSToken {
    return [[[[self description]
              stringByReplacingOccurrencesOfString: @"<" withString: @""]
             stringByReplacingOccurrencesOfString: @">" withString: @""]
            stringByReplacingOccurrencesOfString: @" " withString: @""];
}

@end
