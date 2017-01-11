//
//  UIWebView+TXWebStorage.h
//  TXCategories (https://github.com/tlsion/TXCategories)
//
//  Created by 王-庭协 on 2016/12/14.
//  Copyright © 2017年 ApeStar. All rights reserved.
//  https://github.com/cprime/UIWebView-WebStorage

#import <UIKit/UIKit.h>

@interface UIWebView (TXWebStorage)
#pragma mark - Local Storage

- (void)tx_setLocalStorageString:(NSString *)string forKey:(NSString *)key;

- (NSString *)tx_localStorageStringForKey:(NSString *)key;

- (void)tx_removeLocalStorageStringForKey:(NSString *)key;

- (void)tx_clearLocalStorage;

#pragma mark - Session Storage

- (void)tx_setSessionStorageString:(NSString *)string forKey:(NSString *)key;

- (NSString *)tx_sessionStorageStringForKey:(NSString *)key;

- (void)tx_removeSessionStorageStringForKey:(NSString *)key;

- (void)tx_clearSessionStorage;

@end
