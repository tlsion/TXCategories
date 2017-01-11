//
//  NSString+TXMatcher.h
//  Whyd
//
//  Created by Damien Romito on 29/01/15.
//  Copyright (c) 2015 Damien Romito. All rights reserved.
//
//https://github.com/damienromito/NSString-Matcher
#import <Foundation/Foundation.h>
@interface NSString(TXMatcher)
- (NSArray *)tx_matchWithRegex:(NSString *)regex;
- (NSString *)tx_matchWithRegex:(NSString *)regex atIndex:(NSUInteger)index;
- (NSString *)tx_firstMatchedGroupWithRegex:(NSString *)regex;
- (NSTextCheckingResult *)tx_firstMatchedResultWithRegex:(NSString *)regex;
@end
