
//
//  NSNumber+CGFloat.h
//
//  Created by Alexey Aleshkov on 16.02.14.
//  Copyright (c) 2014 Alexey Aleshkov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface NSNumber (TXCGFloat)

- (CGFloat)tx_CGFloatValue;

- (id)initWithTXCGFloat:(CGFloat)value;

+ (NSNumber *)tx_numberWithCGFloat:(CGFloat)value;

@end
