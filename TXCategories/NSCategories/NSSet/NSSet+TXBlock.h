//
//  NSSet+Block.h
//  TXCategories (https://github.com/tlsion/TXCategories)
//
//  Created by 王-庭协 on 14/12/15.
//  Copyright (c) 2014年 www.skyfox.org. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSSet (TXBlock)
- (void)tx_each:(void (^)(id))block;
- (void)tx_eachWithIndex:(void (^)(id, int))block;
- (NSArray *)tx_map:(id (^)(id object))block;
- (NSArray *)tx_select:(BOOL (^)(id object))block;
- (NSArray *)tx_reject:(BOOL (^)(id object))block;
- (NSArray *)tx_sort;
- (id)tx_reduce:(id(^)(id accumulator, id object))block;
- (id)tx_reduce:(id)initial withBlock:(id(^)(id accumulator, id object))block;
@end
