//
//  NSObject+TXConversion.h
//  TXCategoriesDemo
//
//  Created by Eton on 2017/1/11.
//  Copyright © 2017年 王-庭协. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (TXConversion)

- (NSInteger)txInteger;
- (float)txFloat;
- (BOOL)txBool;

- (NSNumber *)txNSNumber;
- (NSString *)txNSString;
- (NSDate *)txNSDate;
- (NSData *)txNSData;
- (NSArray *)txNSArray;
- (NSMutableArray *)txNSMutableArray;
- (NSDictionary *)txNSDictionary;
- (NSMutableDictionary *)txNSMutableDictionary;

@end
