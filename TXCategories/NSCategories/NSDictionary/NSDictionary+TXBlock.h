//
//  NSDictionary+TXBlock.h
//  TXCategories (https://github.com/tlsion/TXCategories)
//
//  Created by 王-庭协 on 2017/1/12.
//  Copyright © 2017年 ApeStar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (TXBlock)

#pragma mark - RX
- (void)tx_each:(void (^)(id k, id v))block;
- (void)tx_eachKey:(void (^)(id k))block;
- (void)tx_eachValue:(void (^)(id v))block;
- (NSArray *)tx_map:(id (^)(id key, id value))block;
- (NSDictionary *)tx_pick:(NSArray *)keys;
- (NSDictionary *)tx_omit:(NSArray *)key;

@end
