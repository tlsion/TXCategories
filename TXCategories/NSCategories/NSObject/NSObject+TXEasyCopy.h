//
//  NSObject+TXEasyCopy.h
//  TXCategories (https://github.com/tlsion/TXCategories)
//
//  Created by 王-庭协 on 2017/1/12.
//  Copyright © 2017年 ApeStar. All rights reserved.
//

#import <Foundation/Foundation.h>
// a copy category for NSObject 
@interface NSObject (TXEasyCopy)

/**
 *  浅复制目标的所有属性
 *
 *  @param instance 目标对象
 *
 *  @return BOOL—YES:复制成功,NO:复制失败
 */
- (BOOL)tx_easyShallowCopy:(NSObject *)instance;

/**
 *  深复制目标的所有属性
 *
 *  @param instance 目标对象
 *
 *  @return BOOL—YES:复制成功,NO:复制失败
 */
- (BOOL)tx_easyDeepCopy:(NSObject *)instance;

@end
