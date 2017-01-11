//
//  NSString+TXBase64.h
//  TXCategories (https://github.com/tlsion/TXCategories)
//
//  Created by 王-庭协 on 15/2/8.
//  Copyright (c) 2015年 www.skyfox.org. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (TXBase64)
+ (NSString *)tx_stringWithBase64EncodedString:(NSString *)string;
- (NSString *)tx_base64EncodedStringWithWrapWidth:(NSUInteger)wrapWidth;
- (NSString *)tx_base64EncodedString;
- (NSString *)tx_base64DecodedString;
- (NSData *)tx_base64DecodedData;
@end
