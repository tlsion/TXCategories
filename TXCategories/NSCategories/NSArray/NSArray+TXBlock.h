//
//  NSArray+Block.h
//  TXCategories (https://github.com/tlsion/TXCategories)
//
//  Created by 王-庭协 on 2017/1/12.
//  Copyright © 2017年 ApeStar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (TXBlock)
- (void)tx_each:(void (^)(id object))block;
- (void)tx_eachWithIndex:(void (^)(id object, NSUInteger index))block;
- (NSArray *)tx_map:(id (^)(id object))block;
- (NSArray *)tx_filter:(BOOL (^)(id object))block;
- (NSArray *)tx_reject:(BOOL (^)(id object))block;
- (id)tx_detect:(BOOL (^)(id object))block;
- (id)tx_reduce:(id (^)(id accumulator, id object))block;
- (id)tx_reduce:(id)initial withBlock:(id (^)(id accumulator, id object))block;
@end
