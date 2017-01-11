//
//  UIView+TXConstraints.h
//  TXCategories (https://github.com/tlsion/TXCategories)
//
//  Created by 王-庭协 on 15/5/22.
//  Copyright (c) 2015年 www.skyfox.org. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (TXConstraints)
- (NSLayoutConstraint *)tx_constraintForAttribute:(NSLayoutAttribute)attribute;

- (NSLayoutConstraint *)tx_leftConstraint;
- (NSLayoutConstraint *)tx_rightConstraint;
- (NSLayoutConstraint *)tx_topConstraint;
- (NSLayoutConstraint *)tx_bottomConstraint;
- (NSLayoutConstraint *)tx_leadingConstraint;
- (NSLayoutConstraint *)tx_trailingConstraint;
- (NSLayoutConstraint *)tx_widthConstraint;
- (NSLayoutConstraint *)tx_heightConstraint;
- (NSLayoutConstraint *)tx_centerXConstraint;
- (NSLayoutConstraint *)tx_centerYConstraint;
- (NSLayoutConstraint *)tx_baseLineConstraint;
@end
