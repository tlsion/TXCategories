//
//  NSUserDefaults+SafeAccess.h
//  TXCategories (https://github.com/tlsion/TXCategories)
//
//  Created by 王-庭协 on 15/5/23.
//  Copyright (c) 2015年 www.skyfox.org. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSUserDefaults (TXSafeAccess)

#pragma mark - WRITE FOR STANDARD

+ (void)tx_setObject:(id)value forKey:(NSString *)defaultName;

#pragma mark - READ ARCHIVE FOR STANDARD

+ (id)tx_arcObjectForKey:(NSString *)defaultName;

#pragma mark - WRITE ARCHIVE FOR STANDARD

+ (void)tx_setArcObject:(id)value forKey:(NSString *)defaultName;
@end
