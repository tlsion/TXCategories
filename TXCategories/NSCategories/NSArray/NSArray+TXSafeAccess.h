//
//  NSArray+TXSafeAccess.h
//  TXCategories (https://github.com/tlsion/TXCategories)
//
//  Created by 王-庭协 on 2017/1/12.
//  Copyright © 2017年 ApeStar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSArray (TXSafeAccess)
-(id)tx_objectWithIndex:(NSUInteger)index;

- (NSString*)tx_stringWithIndex:(NSUInteger)index;

- (NSNumber*)tx_numberWithIndex:(NSUInteger)index;

- (NSDecimalNumber *)tx_decimalNumberWithIndex:(NSUInteger)index;

- (NSArray*)tx_arrayWithIndex:(NSUInteger)index;

- (NSDictionary*)tx_dictionaryWithIndex:(NSUInteger)index;

- (NSInteger)tx_integerWithIndex:(NSUInteger)index;

- (NSUInteger)tx_unsignedIntegerWithIndex:(NSUInteger)index;

- (BOOL)tx_boolWithIndex:(NSUInteger)index;

- (int16_t)tx_int16WithIndex:(NSUInteger)index;

- (int32_t)tx_int32WithIndex:(NSUInteger)index;

- (int64_t)tx_int64WithIndex:(NSUInteger)index;

- (char)tx_charWithIndex:(NSUInteger)index;

- (short)tx_shortWithIndex:(NSUInteger)index;

- (float)tx_floatWithIndex:(NSUInteger)index;

- (double)tx_doubleWithIndex:(NSUInteger)index;

- (NSDate *)tx_dateWithIndex:(NSUInteger)index dateFormat:(NSString *)dateFormat;
//CG
- (CGFloat)tx_CGFloatWithIndex:(NSUInteger)index;

- (CGPoint)tx_pointWithIndex:(NSUInteger)index;

- (CGSize)tx_sizeWithIndex:(NSUInteger)index;

- (CGRect)tx_rectWithIndex:(NSUInteger)index;
@end


#pragma --mark NSMutableArray setter

@interface NSMutableArray(TXSafeAccess)

-(void)tx_addObj:(id)i;

-(void)tx_addString:(NSString*)i;

-(void)tx_addBool:(BOOL)i;

-(void)tx_addInt:(int)i;

-(void)tx_addInteger:(NSInteger)i;

-(void)tx_addUnsignedInteger:(NSUInteger)i;

-(void)tx_addCGFloat:(CGFloat)f;

-(void)tx_addChar:(char)c;

-(void)tx_addFloat:(float)i;

-(void)tx_addPoint:(CGPoint)o;

-(void)tx_addSize:(CGSize)o;

-(void)tx_addRect:(CGRect)o;

-(void)tx_removeWithObject:(id)object;

-(void)tx_removeWithIndex:(NSUInteger)index;

@end
