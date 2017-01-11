//
//  NSObject+TXAddProperty.m
//  TXCategories (https://github.com/tlsion/TXCategories)
//
//  Created by 王-庭协 on 14/12/15.
//  Copyright (c) 2014年 www.skyfox.org. All rights reserved.
//

#import "NSObject+TXAddProperty.h"
#import <objc/runtime.h>

//objc_getAssociatedObject和objc_setAssociatedObject都需要指定一个固定的地址，这个固定的地址值用来表示属性的key，起到一个常量的作用。
static const void *TXStringProperty = &TXStringProperty;
static const void *TXIntegerProperty = &TXIntegerProperty;
//static char IntegerProperty;
@implementation NSObject (TXAddProperty)

@dynamic tx_stringProperty;
@dynamic tx_integerProperty;

//set
/**
 *  @brief  catgory runtime实现get set方法增加一个字符串属性
 */
-(void)setTx_stringProperty:(NSString *)tx_stringProperty{
    //use that a static const as the key
    objc_setAssociatedObject(self, TXStringProperty, tx_stringProperty, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    //use that property's selector as the key:
    //objc_setAssociatedObject(self, @selector(stringProperty), stringProperty, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
//get
-(NSString *)tx_stringProperty{
    return objc_getAssociatedObject(self, TXStringProperty);
}

//set
/**
 *  @brief  catgory runtime实现get set方法增加一个NSInteger属性
 */
-(void)setTx_integerProperty:(NSInteger)tx_integerProperty{
    NSNumber *number = [[NSNumber alloc]initWithInteger:tx_integerProperty];
    objc_setAssociatedObject(self,TXIntegerProperty, number, OBJC_ASSOCIATION_ASSIGN);
}
//get
-(NSInteger)tx_integerProperty{
    return [objc_getAssociatedObject(self, TXIntegerProperty) integerValue];
}

@end
