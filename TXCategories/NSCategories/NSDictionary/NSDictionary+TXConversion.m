//
//  NSDictionary+TXConversion.m
//  TXCategoriesDemo
//
//  Created by Eton on 2017/1/11.
//  Copyright © 2017年 王-庭协. All rights reserved.
//

#import "NSDictionary+TXConversion.h"
#import <objc/runtime.h>

@implementation NSDictionary (TXConversion)

+ (NSDictionary*)dictionaryWithObject:(NSObject *)obj {
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    unsigned int propsCount;
    
    objc_property_t *props = class_copyPropertyList([obj class], &propsCount);
    
    for(int i = 0;i < propsCount; i++) {
        
        objc_property_t prop = props[i];
        @try {
            NSString *propName = [NSString stringWithUTF8String:property_getName(prop)] ;
            id value = [obj valueForKey:propName];
            if(value) {
                value = [self objectWithInternal:value];
                [dic setValue:value forKey:propName];
            }
        }
        @catch (NSException *exception) {
            //[self logError:exception];
            NSLog(@"%@",exception);
        }
    }
    
    free(props);
    
    return dic;
}

+ (id)objectWithInternal:(id)obj {
    
    if([obj isKindOfClass:[NSString class]]
       ||
       [obj isKindOfClass:[NSNumber class]]
       ||
       [obj isKindOfClass:[NSNull class]]) {
        
        return obj;
        
    }
    if([obj isKindOfClass:[NSArray class]]) {
        
        NSArray *objarr = obj;
        if (objarr.count == 0) {
            return nil;
        }
        NSMutableArray *arr = [NSMutableArray arrayWithCapacity:objarr.count];
        
        for(int i = 0; i < objarr.count; i++) {
            
            [arr setObject:[self objectWithInternal:[objarr objectAtIndex:i]] atIndexedSubscript:i];
        }
        return arr;
    }
    if([obj isKindOfClass:[NSDictionary class]]) {
        
        NSDictionary *objdic = obj;
        if (objdic.allKeys.count == 0) {
            return nil;
        }
        NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithCapacity:[objdic count]];
        
        for(NSString *key in objdic.allKeys) {
            
            [dic setObject:[self objectWithInternal:[objdic objectForKey:key]] forKey:key];
        }
        return dic;
    }
    if([obj isKindOfClass:[NSObject class]]) {
        return [self dictionaryWithObject:obj];
    }
    return nil;
    
}

@end
