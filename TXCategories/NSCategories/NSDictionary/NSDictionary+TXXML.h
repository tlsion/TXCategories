//
//  NSDictionary+TXXML.h
//  TXCategories (https://github.com/tlsion/TXCategories)
//
//  Created by 王-庭协 on 2017/1/12.
//  Copyright © 2017年 ApeStar. All rights reserved.
//

// 在线XML、JSON数据互转
// http://www.bejson.com/xml2json/

//XML 新手入门基础知识
//http://www.ibm.com/developerworks/cn/xml/x-newxml/
#import <Foundation/Foundation.h>

@interface NSDictionary (TXXML)
/**
 *  @brief  将NSDictionary转换成XML字符串 不带XML声明 不带根节点
 *
 *  @return XML 字符串
 */
- (NSString *)tx_XMLString;
/**
 *  @brief  将NSDictionary转换成XML字符串, 默认 <?xml version=\"1.0\" encoding=\"utf-8\"?> 声明   自定义根节点
 *
 *  @param rootElement 根节点
 *
 *  @return XML 字符串
 */
- (NSString *)tx_XMLStringDefaultDeclarationWithRootElement:(NSString*)rootElement;
/**
 *  @brief  将NSDictionary转换成XML字符串, 自定义根节点  自定义xml声明
 *
 *  @param rootElement 根节点
 *
 *  @param declaration xml声明
 *
 *  @return 标准合法 XML 字符串
 */
- (NSString *)tx_XMLStringWithRootElement:(NSString*)rootElement declaration:(NSString*)declaration;
/**
 *  @brief  将NSDictionary转换成Plist字符串
 *
 *  @return Plist 字符串
 */
- (NSString *)tx_plistString;
/**
 *  @brief  将NSDictionary转换成Plist data
 *
 *  @return Plist data
 */
- (NSData *)tx_plistData;

@end
