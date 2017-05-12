//
//  UIImage+TXQRCode.h
//  TXCategoriesDemo
//
//  Created by Eton on 2017/5/12.
//  Copyright © 2017年 王-庭协. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (TXQRCode)

//生成二维码

+ (UIImage *)createCodeWithString:(NSString *)string size:(CGFloat)size;

//改变二维码大小

+ (UIImage *)createNonInterpolatedUIImageFormCIImage:(CIImage *)image withSize:(CGFloat) size;

@end
