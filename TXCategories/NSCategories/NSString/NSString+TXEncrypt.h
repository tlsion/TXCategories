//
//  NSString+TXEncrypt.h
//  TXCategories (https://github.com/tlsion/TXCategories)
//
//  Created by 王-庭协 on 15/1/26.
//  Copyright (c) 2015年 www.skyfox.org. All rights reserved.
//
// 加密解密工具 http://tool.chacuo.net/cryptdes

#import <Foundation/Foundation.h>

@interface NSString (TXEncrypt)
/**
 *  AES加密数据
 *
 *  @param key  key 长度一般为16（AES算法所能支持的密钥长度可以为128,192,256位（也即16，24，32个字节））
 *  @param iv  iv
 *
 *  @return data
 */
- (NSString*)tx_encryptedWithAESUsingKey:(NSString*)key andIV:(NSData*)iv;
/**
 *  AES解密数据
 *
 *  @param key key 长度一般为16
 *  @param iv  iv
 *
 *  @return data
 */
- (NSString*)tx_decryptedWithAESUsingKey:(NSString*)key andIV:(NSData*)iv;

/**
 *  DES加密数据
 *
 *  @param key key 长度一般为8
 *  @param iv  iv
 *
 *  @return data
 */
- (NSString*)tx_encryptedWithDESUsingKey:(NSString*)key andIV:(NSData*)iv;
/**
 *  DE解密数据
 *
 *  @param key key 长度一般为8
 *  @param iv  iv
 *
 *  @return data
 */
- (NSString*)tx_decryptedWithDESUsingKey:(NSString*)key andIV:(NSData*)iv;

/**
 *  3DES加密数据 
 *
 *  @param key key 长度一般为24
 *  @param iv  iv
 *
 *  @return data
 */
- (NSString*)tx_encryptedWith3DESUsingKey:(NSString*)key andIV:(NSData*)iv;
/**
 *  3DES解密数据
 *
 *  @param key key 长度一般为24
 *  @param iv  iv
 *
 *  @return data
 */
- (NSString*)tx_decryptedWith3DESUsingKey:(NSString*)key andIV:(NSData*)iv;

@end
