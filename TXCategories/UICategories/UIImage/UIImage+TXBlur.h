//
//  UIImage+Blur.h
//  TXCategories (https://github.com/tlsion/TXCategories)
//
//  Created by 王-庭协 on 15/6/5.
//  Copyright (c) 2015年 www.skyfox.org. All rights reserved.
//

#import <UIKit/UIKit.h>
FOUNDATION_EXPORT double ImageEffectsVersionNumber;
FOUNDATION_EXPORT const unsigned char ImageEffectsVersionString[];
@interface UIImage (TXBlur)

- (UIImage *)tx_lightImage;
- (UIImage *)tx_extraLightImage;
- (UIImage *)tx_darkImage;
- (UIImage *)tx_tintedImageWithColor:(UIColor *)tintColor;

- (UIImage *)tx_blurredImageWithRadius:(CGFloat)blurRadius;
- (UIImage *)tx_blurredImageWithSize:(CGSize)blurSize;
- (UIImage *)tx_blurredImageWithSize:(CGSize)blurSize
                        tintColor:(UIColor *)tintColor
            saturationDeltaFactor:(CGFloat)saturationDeltaFactor
                        maskImage:(UIImage *)maskImage;
@end
