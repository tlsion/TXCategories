//
//  UIImage+Capture.h
//  TXCategories (https://github.com/tlsion/TXCategories)
//
//  Created by 王-庭协 on 15/1/10.
//  Copyright (c) 2015年 www.skyfox.org. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (TXCapture)
/**
 *  @brief  截图指定view成图片
 *
 *  @param view 一个view
 *
 *  @return 图片
 */
+ (UIImage *)tx_captureWithView:(UIView *)view;

+ (UIImage *)tx_getImageWithSize:(CGRect)myImageRect FromImage:(UIImage *)bigImage;

/**
 *  @author Jakey
 *
 *  @brief  截图一个view中所有视图 包括旋转缩放效果
 *
 *  @param aView    指定的view
 *  @param maxWidth 宽的大小 0为view默认大小
 *
 *  @return 截图
 */
+ (UIImage *)tx_screenshotWithView:(UIView *)aView limitWidth:(CGFloat)maxWidth;
@end
