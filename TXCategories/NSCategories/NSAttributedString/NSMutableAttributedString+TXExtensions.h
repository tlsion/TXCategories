//
//  NSMutableAttributedString+TXExtensions.h
//  TXCategoriesDemo
//
//  Created by Eton on 2017/3/23.
//  Copyright © 2017年 王-庭协. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSMutableAttributedString (TXExtensions)

- (void)addFont:(UIFont *)font range:(NSRange )range;

- (void)addColor:(UIColor *)color range:(NSRange )range;

- (void)addImage:(UIImage *)image;



@end
