//
//  UIView+Nib.h
//  TXCategories (https://github.com/tlsion/TXCategories)
//
//  Created by 王-庭协 on 14/12/15.
//  Copyright (c) 2014年 www.skyfox.org. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface UIView (TXNib)
+ (UINib *)tx_loadNib;
+ (UINib *)tx_loadNibNamed:(NSString*)nibName;
+ (UINib *)tx_loadNibNamed:(NSString*)nibName bundle:(NSBundle *)bundle;

+ (instancetype)tx_loadFromNib;
+ (instancetype)tx_loadFromNibWithName:(NSString *)nibName;
+ (instancetype)tx_loadFromNibWithName:(NSString *)nibName owner:(id)owner;
+ (instancetype)tx_loadFromNibWithName:(NSString *)nibName owner:(id)owner bundle:(NSBundle *)bundle;

@end
