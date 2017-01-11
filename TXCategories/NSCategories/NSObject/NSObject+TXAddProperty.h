//
//  NSObject+TXAddProperty.h
//  TXCategories (https://github.com/tlsion/TXCategories)
//
//  Created by 王-庭协 on 14/12/15.
//  Copyright (c) 2014年 www.skyfox.org. All rights reserved.
//

#import <Foundation/Foundation.h>
//objc_getAssociatedObject和objc_setAssociatedObject都需要指定一个固定的地址，这个固定的地址值用来表示属性的key，起到一个常量的作用。
//static const void *TXStringProperty = &TXStringProperty;
//static char IntegerProperty;
//@selector(methodName:)

@interface NSObject (TXAddProperty)
/**
 *  @brief  catgory runtime实现get set方法增加一个字符串属性
 */
@property (nonatomic,strong) NSString *tx_stringProperty;
/**
 *  @brief  catgory runtime实现get set方法增加一个NSInteger属性
 */
@property (nonatomic,assign) NSInteger tx_integerProperty;
@end
