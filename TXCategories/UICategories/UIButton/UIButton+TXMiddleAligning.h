//
//  UIButton+MiddleAligning.h
//  TXCategories (https://github.com/tlsion/TXCategories)
//
//  Created by 王-庭协 on 2017/1/12.
//  Copyright © 2017年 ApeStar. All rights reserved.
//https://github.com/hcbarry/MiddleAlignedButton

#import <UIKit/UIKit.h>

/**
 A category on UIButton that provides a simple yet powerful interface to middle aligning imageView and titleLabel
 */
@interface UIButton (TXMiddleAligning)

/**
 @param spacing The middle spacing between imageView and titleLabel.
 @discussion The middle aligning method for imageView and titleLabel.
 */
- (void)tx_middleAlignButtonWithSpacing:(CGFloat)spacing;

@end
