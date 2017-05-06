//
//  NSMutableAttributedString+TXExtensions.m
//  TXCategoriesDemo
//
//  Created by Eton on 2017/3/23.
//  Copyright © 2017年 王-庭协. All rights reserved.
//

#import "NSMutableAttributedString+TXExtensions.h"
#import <CoreText/CoreText.h>

@implementation NSMutableAttributedString (TXExtensions)

- (void)addFont:(UIFont *)font range:(NSRange )range{
    CTFontRef mantissaFont = CTFontCreateWithName((__bridge CFStringRef)font.fontName, font.pointSize, NULL);
    [self addAttribute:(NSString *)kCTFontAttributeName value:(__bridge id)mantissaFont range:range];
}

- (void)addColor:(UIColor *)color range:(NSRange )range{
    [self addAttribute:NSForegroundColorAttributeName value:color range:range];
}

- (void)addImage:(UIImage *)image{
    
    NSTextAttachment *attch = [[NSTextAttachment alloc] init];
    
    attch.image = image;
    
    // 设置图片大小
    attch.bounds = CGRectMake(0, 0, image.size.width, image.size.height);
    
    // 创建带有图片的富文本
    NSAttributedString *string = [NSAttributedString attributedStringWithAttachment:attch];
    
    [self appendAttributedString:string];
}


@end
