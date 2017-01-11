//
//  NSArray+TXSafeAccess.m
//  TXCategories (https://github.com/tlsion/TXCategories)
//
//  Created by 王-庭协 on 2017/1/12.
//  Copyright © 2017年 ApeStar. All rights reserved.
//

#import "NSArray+TXSafeAccess.h"

@implementation NSArray (TXSafeAccess)
-(id)tx_objectWithIndex:(NSUInteger)index{
    if (index <self.count) {
        return self[index];
    }else{
        return nil;
    }
}

- (NSString*)tx_stringWithIndex:(NSUInteger)index
{
    id value = [self tx_objectWithIndex:index];
    if (value == nil || value == [NSNull null] || [[value description] isEqualToString:@"<null>"])
    {
        return nil;
    }
    if ([value isKindOfClass:[NSString class]]) {
        return (NSString*)value;
    }
    if ([value isKindOfClass:[NSNumber class]]) {
        return [value stringValue];
    }
    
    return nil;
}


- (NSNumber*)tx_numberWithIndex:(NSUInteger)index
{
    id value = [self tx_objectWithIndex:index];
    if ([value isKindOfClass:[NSNumber class]]) {
        return (NSNumber*)value;
    }
    if ([value isKindOfClass:[NSString class]]) {
        NSNumberFormatter * f = [[NSNumberFormatter alloc] init];
        [f setNumberStyle:NSNumberFormatterDecimalStyle];
        return [f numberFromString:(NSString*)value];
    }
    return nil;
}

- (NSDecimalNumber *)tx_decimalNumberWithIndex:(NSUInteger)index{
    id value = [self tx_objectWithIndex:index];
    
    if ([value isKindOfClass:[NSDecimalNumber class]]) {
        return value;
    } else if ([value isKindOfClass:[NSNumber class]]) {
        NSNumber * number = (NSNumber*)value;
        return [NSDecimalNumber decimalNumberWithDecimal:[number decimalValue]];
    } else if ([value isKindOfClass:[NSString class]]) {
        NSString * str = (NSString*)value;
        return [str isEqualToString:@""] ? nil : [NSDecimalNumber decimalNumberWithString:str];
    }
    return nil;
}

- (NSArray*)tx_arrayWithIndex:(NSUInteger)index
{
    id value = [self tx_objectWithIndex:index];
    if (value == nil || value == [NSNull null])
    {
        return nil;
    }
    if ([value isKindOfClass:[NSArray class]])
    {
        return value;
    }
    return nil;
}


- (NSDictionary*)tx_dictionaryWithIndex:(NSUInteger)index
{
    id value = [self tx_objectWithIndex:index];
    if (value == nil || value == [NSNull null])
    {
        return nil;
    }
    if ([value isKindOfClass:[NSDictionary class]])
    {
        return value;
    }
    return nil;
}

- (NSInteger)tx_integerWithIndex:(NSUInteger)index
{
    id value = [self tx_objectWithIndex:index];
    if (value == nil || value == [NSNull null])
    {
        return 0;
    }
    if ([value isKindOfClass:[NSString class]] || [value isKindOfClass:[NSNumber class]])
    {
        return [value integerValue];
    }
    return 0;
}
- (NSUInteger)tx_unsignedIntegerWithIndex:(NSUInteger)index
{
    id value = [self tx_objectWithIndex:index];
    if (value == nil || value == [NSNull null])
    {
        return 0;
    }
    if ([value isKindOfClass:[NSString class]] || [value isKindOfClass:[NSNumber class]])
    {
        return [value unsignedIntegerValue];
    }
    return 0;
}
- (BOOL)tx_boolWithIndex:(NSUInteger)index
{
    id value = [self tx_objectWithIndex:index];
    
    if (value == nil || value == [NSNull null])
    {
        return NO;
    }
    if ([value isKindOfClass:[NSNumber class]])
    {
        return [value boolValue];
    }
    if ([value isKindOfClass:[NSString class]])
    {
        return [value boolValue];
    }
    return NO;
}
- (int16_t)tx_int16WithIndex:(NSUInteger)index
{
    id value = [self tx_objectWithIndex:index];
    
    if (value == nil || value == [NSNull null])
    {
        return 0;
    }
    if ([value isKindOfClass:[NSNumber class]])
    {
        return [value shortValue];
    }
    if ([value isKindOfClass:[NSString class]])
    {
        return [value intValue];
    }
    return 0;
}
- (int32_t)tx_int32WithIndex:(NSUInteger)index
{
    id value = [self tx_objectWithIndex:index];
    
    if (value == nil || value == [NSNull null])
    {
        return 0;
    }
    if ([value isKindOfClass:[NSNumber class]] || [value isKindOfClass:[NSString class]])
    {
        return [value intValue];
    }
    return 0;
}
- (int64_t)tx_int64WithIndex:(NSUInteger)index
{
    id value = [self tx_objectWithIndex:index];
    
    if (value == nil || value == [NSNull null])
    {
        return 0;
    }
    if ([value isKindOfClass:[NSNumber class]] || [value isKindOfClass:[NSString class]])
    {
        return [value longLongValue];
    }
    return 0;
}

- (char)tx_charWithIndex:(NSUInteger)index{
    
    id value = [self tx_objectWithIndex:index];
    
    if (value == nil || value == [NSNull null])
    {
        return 0;
    }
    if ([value isKindOfClass:[NSNumber class]] || [value isKindOfClass:[NSString class]])
    {
        return [value charValue];
    }
    return 0;
}

- (short)tx_shortWithIndex:(NSUInteger)index
{
    id value = [self tx_objectWithIndex:index];
    
    if (value == nil || value == [NSNull null])
    {
        return 0;
    }
    if ([value isKindOfClass:[NSNumber class]])
    {
        return [value shortValue];
    }
    if ([value isKindOfClass:[NSString class]])
    {
        return [value intValue];
    }
    return 0;
}
- (float)tx_floatWithIndex:(NSUInteger)index
{
    id value = [self tx_objectWithIndex:index];
    
    if (value == nil || value == [NSNull null])
    {
        return 0;
    }
    if ([value isKindOfClass:[NSNumber class]] || [value isKindOfClass:[NSString class]])
    {
        return [value floatValue];
    }
    return 0;
}
- (double)tx_doubleWithIndex:(NSUInteger)index
{
    id value = [self tx_objectWithIndex:index];
    
    if (value == nil || value == [NSNull null])
    {
        return 0;
    }
    if ([value isKindOfClass:[NSNumber class]] || [value isKindOfClass:[NSString class]])
    {
        return [value doubleValue];
    }
    return 0;
}

- (NSDate *)tx_dateWithIndex:(NSUInteger)index dateFormat:(NSString *)dateFormat {
    NSDateFormatter *formater = [[NSDateFormatter alloc]init];
    formater.dateFormat = dateFormat;
    id value = [self tx_objectWithIndex:index];
    
    if (value == nil || value == [NSNull null])
    {
        return nil;
    }
    
    if ([value isKindOfClass:[NSString class]] && ![value isEqualToString:@""] && !dateFormat) {
        return [formater dateFromString:value];
    }
    return nil;
}

//CG
- (CGFloat)tx_CGFloatWithIndex:(NSUInteger)index
{
    id value = [self tx_objectWithIndex:index];
    
    CGFloat f = [value doubleValue];
    
    return f;
}

- (CGPoint)tx_pointWithIndex:(NSUInteger)index
{
    id value = [self tx_objectWithIndex:index];

    CGPoint point = CGPointFromString(value);
    
    return point;
}
- (CGSize)tx_sizeWithIndex:(NSUInteger)index
{
    id value = [self tx_objectWithIndex:index];

    CGSize size = CGSizeFromString(value);
    
    return size;
}
- (CGRect)tx_rectWithIndex:(NSUInteger)index
{
    id value = [self tx_objectWithIndex:index];
    
    CGRect rect = CGRectFromString(value);
    
    return rect;
}
@end


#pragma --mark NSMutableArray setter
@implementation NSMutableArray (TXSafeAccess)
-(void)tx_addObj:(id)i{
    if (i!=nil) {
        [self addObject:i];
    }
}
-(void)tx_addString:(NSString*)i
{
    if (i!=nil) {
        [self addObject:i];
    }
}
-(void)tx_addBool:(BOOL)i
{
    [self addObject:@(i)];
}
-(void)tx_addInt:(int)i
{
    [self addObject:@(i)];
}
-(void)tx_addInteger:(NSInteger)i
{
    [self addObject:@(i)];
}
-(void)tx_addUnsignedInteger:(NSUInteger)i
{
    [self addObject:@(i)];
}
-(void)tx_addCGFloat:(CGFloat)f
{
   [self addObject:@(f)];
}
-(void)tx_addChar:(char)c
{
    [self addObject:@(c)];
}
-(void)tx_addFloat:(float)i
{
    [self addObject:@(i)];
}
-(void)tx_addPoint:(CGPoint)o
{
    [self addObject:NSStringFromCGPoint(o)];
}
-(void)tx_addSize:(CGSize)o
{
   [self addObject:NSStringFromCGSize(o)];
}
-(void)tx_addRect:(CGRect)o
{
    [self addObject:NSStringFromCGRect(o)];
}
-(void)tx_removeWithObject:(id)object{
    if ([self containsObject:object]) {
        NSInteger index = [self indexOfObject:object];
        [self removeObjectAtIndex:index];
    }
}
-(void)tx_removeWithIndex:(NSUInteger)index{
    if (self.count > index) {
        [self removeObjectAtIndex:index];
    }
}
@end

