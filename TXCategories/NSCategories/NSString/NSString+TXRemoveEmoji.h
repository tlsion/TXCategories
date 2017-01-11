//
//  NSString+TXRemoveEmoji.h
//  NSString+RemoveEmoji
//
//  Created by 王-庭协 on 15/5/13.
//  Copyright (c) 2015年 Jakey. All rights reserved.
//
#import <Foundation/Foundation.h>

@interface NSString (TXRemoveEmoji)
/**
 *  @brief  是否包含emoji
 *
 *  @return 是否包含emoji
 */
- (BOOL)tx_isIncludingEmoji;

/**
 *  @brief  删除掉包含的emoji
 *
 *  @return 清除后的string
 */
- (instancetype)tx_removedEmojiString;

@end
