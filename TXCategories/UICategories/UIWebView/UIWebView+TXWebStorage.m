//
//  UIWebView+TXWebStorage.m
//  TXCategories (https://github.com/tlsion/TXCategories)
//
//  Created by 王-庭协 on 2016/12/14.
//  Copyright © 2017年 ApeStar. All rights reserved.
//

#import "UIWebView+TXWebStorage.h"

static NSString * const tx_kLocalStorageName = @"localStorage";
static NSString * const tx_kSessionStorageName = @"sessionStorage";


@implementation UIWebView (TXWebStorage)
#pragma mark - Local Storage

- (void)tx_setLocalStorageString:(NSString *)string forKey:(NSString *)key {
    [self tx_ip_setString:string forKey:key storage:tx_kLocalStorageName];
}

- (NSString *)tx_localStorageStringForKey:(NSString *)key {
    return [self tx_ip_stringForKey:key storage:tx_kLocalStorageName];
}

- (void)tx_removeLocalStorageStringForKey:(NSString *)key {
    [self tx_ip_removeStringForKey:key storage:tx_kLocalStorageName];
}

- (void)tx_clearLocalStorage {
    [self tx_ip_clearWithStorage:tx_kLocalStorageName];
}

#pragma mark - Session Storage

- (void)tx_setSessionStorageString:(NSString *)string forKey:(NSString *)key {
    [self tx_ip_setString:string forKey:key storage:tx_kSessionStorageName];
}

- (NSString *)tx_sessionStorageStringForKey:(NSString *)key {
    return [self tx_ip_stringForKey:key storage:tx_kSessionStorageName];
}

- (void)tx_removeSessionStorageStringForKey:(NSString *)key {
    [self tx_ip_removeStringForKey:key storage:tx_kSessionStorageName];
}

- (void)tx_clearSessionStorage {
    [self tx_ip_clearWithStorage:tx_kSessionStorageName];
}

#pragma mark - Helpers

- (void)tx_ip_setString:(NSString *)string forKey:(NSString *)key storage:(NSString *)storage {
    [self stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"%@.setItem('%@', '%@');", storage, key, string]];
}

- (NSString *)tx_ip_stringForKey:(NSString *)key storage:(NSString *)storage {
    return [self stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"%@.getItem('%@');", storage, key]];
}

- (void)tx_ip_removeStringForKey:(NSString *)key storage:(NSString *)storage {
    [self stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"%@.removeItem('%@');", storage, key]];
}

- (void)tx_ip_clearWithStorage:(NSString *)storage {
    [self stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"%@.clear();", storage]];
}
@end
