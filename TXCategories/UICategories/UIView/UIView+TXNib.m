//
//  UIView+Nib.m
//  TXCategories (https://github.com/tlsion/TXCategories)
//
//  Created by 王-庭协 on 14/12/15.
//  Copyright (c) 2014年 www.skyfox.org. All rights reserved.
//

#import "UIView+TXNib.h"

@implementation UIView (TXNib)
#pragma mark - Nibs
+ (UINib *)tx_loadNib
{
    return [self tx_loadNibNamed:NSStringFromClass([self class])];
}
+ (UINib *)tx_loadNibNamed:(NSString*)nibName
{
    return [self tx_loadNibNamed:nibName bundle:[NSBundle mainBundle]];
}
+ (UINib *)tx_loadNibNamed:(NSString*)nibName bundle:(NSBundle *)bundle
{
    return [UINib nibWithNibName:nibName bundle:bundle];
}
+ (instancetype)tx_loadFromNib
{
    return [self tx_loadFromNibWithName:NSStringFromClass([self class])];
}
+ (instancetype)tx_loadFromNibWithName:(NSString *)nibName
{
    return [self tx_loadFromNibWithName:nibName owner:nil];
}
+ (instancetype)tx_loadFromNibWithName:(NSString *)nibName owner:(id)owner
{
    return [self tx_loadFromNibWithName:nibName owner:owner bundle:[NSBundle mainBundle]];
}
+ (instancetype)tx_loadFromNibWithName:(NSString *)nibName owner:(id)owner bundle:(NSBundle *)bundle
{
    UIView *result = nil;
    NSArray* elements = [bundle loadNibNamed:nibName owner:owner options:nil];
    for (id object in elements)
    {
        if ([object isKindOfClass:[self class]])
        {
            result = object;
            break;
        }
    }
    return result;
}

@end
