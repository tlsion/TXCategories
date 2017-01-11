//
//  NSString+TXEncrypt.m
//  TXCategories (https://github.com/tlsion/TXCategories)
//
//  Created by 王-庭协 on 15/1/26.
//  Copyright (c) 2015年 www.skyfox.org. All rights reserved.
//

// 加密解密工具 http://tool.chacuo.net/cryptdes
#import "NSString+TXEncrypt.h"
#import "NSData+TXEncrypt.h"
#import "NSData+TXBase64.h"

@implementation NSString (TXEncrypt)
-(NSString*)tx_encryptedWithAESUsingKey:(NSString*)key andIV:(NSData*)iv {
    NSData *encrypted = [[self dataUsingEncoding:NSUTF8StringEncoding] tx_encryptedWithAESUsingKey:key andIV:iv];
    NSString *encryptedString = [encrypted tx_base64EncodedString];
    
    return encryptedString;
}

- (NSString*)tx_decryptedWithAESUsingKey:(NSString*)key andIV:(NSData*)iv {
    NSData *decrypted = [[NSData tx_dataWithBase64EncodedString:self] tx_decryptedWithAESUsingKey:key andIV:iv];
    NSString *decryptedString = [[NSString alloc] initWithData:decrypted encoding:NSUTF8StringEncoding];
    
    return decryptedString;
}

- (NSString*)tx_encryptedWithDESUsingKey:(NSString*)key andIV:(NSData*)iv {
    NSData *encrypted = [[self dataUsingEncoding:NSUTF8StringEncoding] tx_encryptedWithDESUsingKey:key andIV:iv];
    NSString *encryptedString = [encrypted tx_base64EncodedString];
    
    return encryptedString;
}

- (NSString*)tx_decryptedWithDESUsingKey:(NSString*)key andIV:(NSData*)iv {
    NSData *decrypted = [[NSData tx_dataWithBase64EncodedString:self] tx_decryptedWithDESUsingKey:key andIV:iv];
    NSString *decryptedString = [[NSString alloc] initWithData:decrypted encoding:NSUTF8StringEncoding];
    
    return decryptedString;
}

- (NSString*)tx_encryptedWith3DESUsingKey:(NSString*)key andIV:(NSData*)iv {
    NSData *encrypted = [[self dataUsingEncoding:NSUTF8StringEncoding] tx_encryptedWith3DESUsingKey:key andIV:iv];
    NSString *encryptedString = [encrypted tx_base64EncodedString];
    
    return encryptedString;
}

- (NSString*)tx_decryptedWith3DESUsingKey:(NSString*)key andIV:(NSData*)iv {
    NSData *decrypted = [[NSData tx_dataWithBase64EncodedString:self] tx_decryptedWith3DESUsingKey:key andIV:iv];
    NSString *decryptedString = [[NSString alloc] initWithData:decrypted encoding:NSUTF8StringEncoding];
    
    return decryptedString;
}

@end
