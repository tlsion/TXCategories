//
//  NSDictionary+TXMerge.h
//  TXCategories (https://github.com/tlsion/TXCategories)
//
//  Created by 王-庭协 on 2017/1/12.
//  Copyright © 2017年 ApeStar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (TXMerge)
/**
 *  @brief  合并两个NSDictionary
 *
 *  @param dict1 NSDictionary
 *  @param dict2 NSDictionary
 *
 *  @return 合并后的NSDictionary
 */
+ (NSDictionary *)tx_dictionaryByMerging:(NSDictionary *)dict1 with:(NSDictionary *)dict2;
/**
 *  @brief  并入一个NSDictionary
 *
 *  @param dict NSDictionary
 *
 *  @return 增加后的NSDictionary
 */
- (NSDictionary *)tx_dictionaryByMergingWith:(NSDictionary *)dict;

#pragma mark - Manipulation
- (NSDictionary *)tx_dictionaryByAddingEntriesFromDictionary:(NSDictionary *)dictionary;
- (NSDictionary *)tx_dictionaryByRemovingEntriesWithKeys:(NSSet *)keys;

@end
