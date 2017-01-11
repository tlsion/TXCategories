//
//  UITextView+TXInputLimit.h
//  TXCategories (https://github.com/tlsion/TXCategories)
//
//  Created by 王-庭协 on 2016/11/29.
//  Copyright © 2017年 ApeStar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextView (TXInputLimit)
@property (assign, nonatomic)  NSInteger tx_maxLength;//if <=0, no limit
@end
