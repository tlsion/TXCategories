//
//  NSString+Contains.h
//  TXCategories (https://github.com/tlsion/TXCategories)
//
//  Created by 符现超 on 15/5/9.
//  Copyright (c) 2015年 http://weibo.com/u/1655766025 All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (TXJudge)

- (BOOL)tx_notEmpty;//是否不为空

- (BOOL)tx_isContainChinese; //判断是否包含中文
- (BOOL)tx_isChinese; //判断是否纯中文

/**
 *  是否包含空格
 */
- (BOOL)tx_isContainBlank;

/**
 *  是否包含字符串
 */
- (BOOL)tx_containsaString:(NSString *)string;

/**
 *  号码判断
 */
- (BOOL)tx_isPhone;    // match phone
- (BOOL)tx_isTelephone;    // match telephone
- (BOOL)tx_isMobilephone;  // match mobilephone, 11 numberic

- (BOOL)tx_isEmail;
- (BOOL)tx_isUrl;
- (BOOL)tx_isIPAddress;

/**
 *  表达式 及 数组 匹配
 */
- (BOOL)tx_match:(NSString *)expression;
- (BOOL)tx_matchAnyOf:(NSArray *)array;
- (BOOL)tx_matchAnyOf:(NSArray *)array caseInsens:(BOOL)caseInsens;

@end
