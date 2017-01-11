//
//  NSObject+TXAssociatedObject.m
//  TXCategories (https://github.com/tlsion/TXCategories)
//
//  Created by 王-庭协 on 14/12/11.
//  Copyright (c) 2014年 www.skyfox.org. All rights reserved.
//

#import "NSObject+TXAssociatedObject.h"
#import  <objc/runtime.h>
@implementation NSObject (TXAssociatedObject)
/**
 *  @brief  附加一个stong对象
 *
 *  @param value 被附加的对象
 *  @param key   被附加对象的key
 */
- (void)tx_associateValue:(id)value withKey:(void *)key
{
    objc_setAssociatedObject(self, key, value, OBJC_ASSOCIATION_RETAIN);
}
/**
 *  @brief  附加一个weak对象
 *
 *  @param value 被附加的对象
 *  @param key   被附加对象的key
 */
- (void)tx_weaklyAssociateValue:(id)value withKey:(void *)key
{
    objc_setAssociatedObject(self, key, value, OBJC_ASSOCIATION_ASSIGN);
}
/**
 *  @brief  根据附加对象的key取出附加对象
 *
 *  @param key 附加对象的key
 *
 *  @return 附加对象
 */
- (id)tx_associatedValueForKey:(void *)key
{
    return objc_getAssociatedObject(self, key);
}
@end

