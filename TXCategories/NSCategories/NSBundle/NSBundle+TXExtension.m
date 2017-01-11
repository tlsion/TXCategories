//
//  NSBundle+TXExtension.m
//  TXCategories (https://github.com/tlsion/TXCategories)
//
//  Created by 王-庭协 on 2017/1/12.
//  Copyright © 2017年 ApeStar. All rights reserved.
//

#import "NSBundle+TXExtension.h"

@implementation NSBundle (TXExtension)

+ (NSString *)tx_fromResource:(NSString *)resName
{
    NSString *	extension = [resName pathExtension];
    NSString *	fullName = [resName substringToIndex:(resName.length - extension.length - 1)];
    
    NSString * path = [[NSBundle mainBundle] pathForResource:fullName ofType:extension];
    return [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:NULL];
}

@end
