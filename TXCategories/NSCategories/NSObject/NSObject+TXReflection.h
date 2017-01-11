//
//  NSObject+TXReflection.h
//  TXCategories (https://github.com/tlsion/TXCategories)
//
//  Created by 王-庭协 on 2017/1/12.
//  Copyright © 2017年 ApeStar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (TXReflection)
//类名
- (NSString *)tx_className;
+ (NSString *)tx_className;
//父类名称
- (NSString *)tx_superClassName;
+ (NSString *)tx_superClassName;

//实例属性字典
-(NSDictionary *)tx_propertyDictionary;

//属性名称列表
- (NSArray*)tx_propertyKeys;
+ (NSArray *)tx_propertyKeys;

//属性详细信息列表
- (NSArray *)tx_propertiesInfo;
+ (NSArray *)tx_propertiesInfo;

//格式化后的属性列表
+ (NSArray *)tx_propertiesWithCodeFormat;

//方法列表
-(NSArray*)tx_methodList;
+(NSArray*)tx_methodList;

-(NSArray*)tx_methodListInfo;

//创建并返回一个指向所有已注册类的指针列表
+ (NSArray *)tx_registedClassList;
//实例变量
+ (NSArray *)tx_instanceVariable;

//协议列表
-(NSDictionary *)tx_protocolList;
+ (NSDictionary *)tx_protocolList;


- (BOOL)tx_hasPropertyForKey:(NSString*)key;
- (BOOL)tx_hasIvarForKey:(NSString*)key;

@end
