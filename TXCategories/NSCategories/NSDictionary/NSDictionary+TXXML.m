//
//  NSDictionary+TXXML.m
//  TXCategories (https://github.com/tlsion/TXCategories)
//
//  Created by 王-庭协 on 15/8/7.
//  Copyright © 2017年 ApeStar. All rights reserved
//

#import "NSDictionary+TXXML.h"

@implementation NSDictionary (TXXML)
/**
 *  @brief  将NSDictionary转换成XML 字符串
 *
 *  @return XML 字符串
 */
- (NSString *)tx_XMLString {
   
    return [self  tx_XMLStringWithRootElement:nil declaration:nil];
}
- (NSString*)tx_XMLStringDefaultDeclarationWithRootElement:(NSString*)rootElement{
    return [self  tx_XMLStringWithRootElement:rootElement declaration:@"<?xml version=\"1.0\" encoding=\"utf-8\"?>"];

}
- (NSString*)tx_XMLStringWithRootElement:(NSString*)rootElement declaration:(NSString*)declaration{
    NSMutableString *xml = [[NSMutableString alloc] initWithString:@""];
    if (declaration) {
        [xml appendString:declaration];
    }
    if (rootElement) {
        [xml appendString:[NSString stringWithFormat:@"<%@>",rootElement]];
    }
    [self tx_convertNode:self withString:xml andTag:nil];
    if (rootElement) {
        [xml appendString:[NSString stringWithFormat:@"</%@>",rootElement]];
    }
    NSString *finalXML=[xml stringByReplacingOccurrencesOfString:@"&" withString:@"&amp;"];
    return finalXML;
}

- (void)tx_convertNode:(id)node withString:(NSMutableString *)xml andTag:(NSString *)tag{
    if ([node isKindOfClass:[NSDictionary class]] && !tag) {
        NSArray *keys = [node allKeys];
        for (NSString *key in keys) {
            [self tx_convertNode:[node objectForKey:key] withString:xml andTag:key];
        }
    }else if ([node isKindOfClass:[NSArray class]]) {
        for (id value in node) {
            [self tx_convertNode:value withString:xml andTag:tag];
        }
    }else {
        [xml appendString:[NSString stringWithFormat:@"<%@>", tag]];
        if ([node isKindOfClass:[NSString class]]) {
            [xml appendString:node];
        }else if ([node isKindOfClass:[NSDictionary class]]) {
            [self tx_convertNode:node withString:xml andTag:nil];
        }
        [xml appendString:[NSString stringWithFormat:@"</%@>", tag]];
    }
}

- (NSString *)tx_plistString{
    NSString *result = [[NSString alloc] initWithData:[self tx_plistData]  encoding:NSUTF8StringEncoding];
    return result;
}
- (NSData *)tx_plistData{
    //    return [NSPropertyListSerialization dataFromPropertyList:self format:NSPropertyListXMLFormat_v1_0   errorDescription:nil];
    NSError *error = nil;
    return [NSPropertyListSerialization dataWithPropertyList:self format:NSPropertyListXMLFormat_v1_0 options:0 error:&error];
}
@end
