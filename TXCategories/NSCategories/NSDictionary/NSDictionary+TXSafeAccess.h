//
//  NSDictionary+TXSafeAccess.h
//  TXCategories (https://github.com/tlsion/TXCategories)
//
//  Created by 王-庭协 on 2017/1/12.
//  Copyright © 2017年 ApeStar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSDictionary (TXSafeAccess)
- (BOOL)tx_hasKey:(NSString *)key;

- (NSString*)tx_stringForKey:(id)key;

- (NSNumber*)tx_numberForKey:(id)key;

- (NSDecimalNumber *)tx_decimalNumberForKey:(id)key;

- (NSArray*)tx_arrayForKey:(id)key;

- (NSDictionary*)tx_dictionaryForKey:(id)key;

- (NSInteger)tx_integerForKey:(id)key;

- (NSUInteger)tx_unsignedIntegerForKey:(id)key;

- (BOOL)tx_boolForKey:(id)key;

- (int16_t)tx_int16ForKey:(id)key;

- (int32_t)tx_int32ForKey:(id)key;

- (int64_t)tx_int64ForKey:(id)key;

- (char)tx_charForKey:(id)key;

- (short)tx_shortForKey:(id)key;

- (float)tx_floatForKey:(id)key;

- (double)tx_doubleForKey:(id)key;

- (long long)tx_longLongForKey:(id)key;

- (unsigned long long)tx_unsignedLongLongForKey:(id)key;

- (NSDate *)tx_dateForKey:(id)key dateFormat:(NSString *)dateFormat;

//CG
- (CGFloat)tx_CGFloatForKey:(id)key;

- (CGPoint)tx_pointForKey:(id)key;

- (CGSize)tx_sizeForKey:(id)key;

- (CGRect)tx_rectForKey:(id)key;
@end

#pragma --mark NSMutableDictionary setter

@interface NSMutableDictionary(SafeAccess)

-(void)tx_setObj:(id)i forKey:(NSString*)key;

-(void)tx_setString:(NSString*)i forKey:(NSString*)key;

-(void)tx_setBool:(BOOL)i forKey:(NSString*)key;

-(void)tx_setInt:(int)i forKey:(NSString*)key;

-(void)tx_setInteger:(NSInteger)i forKey:(NSString*)key;

-(void)tx_setUnsignedInteger:(NSUInteger)i forKey:(NSString*)key;

-(void)tx_setCGFloat:(CGFloat)f forKey:(NSString*)key;

-(void)tx_setChar:(char)c forKey:(NSString*)key;

-(void)tx_setFloat:(float)i forKey:(NSString*)key;

-(void)tx_setDouble:(double)i forKey:(NSString*)key;

-(void)tx_setLongLong:(long long)i forKey:(NSString*)key;

-(void)tx_setPoint:(CGPoint)o forKey:(NSString*)key;

-(void)tx_setSize:(CGSize)o forKey:(NSString*)key;

-(void)tx_setRect:(CGRect)o forKey:(NSString*)key;
@end
