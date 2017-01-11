//
//  UIImage+TXOrientation.h
//  TXCategories (https://github.com/tlsion/TXCategories)
//
//  Created by 王-庭协 on 15/1/4.
//  Copyright (c) 2015年 www.skyfox.org. All rights reserved.
//

#import <UIKit/UIKit.h>
//CGFloat DegreesToRadiansForOrientation(CGFloat degrees) {return degrees * M_PI / 180;};
//CGFloat RadiansToDegreesForOrientation(CGFloat radians) {return radians * 180/M_PI;};
@interface UIImage (TXOrientation)
/**
 *  @brief  修正图片的方向
 *
 *  @return 修正方向后的图片
 */
- (UIImage *)tx_fixOrientation;
/**
 *  @brief  旋转图片
 *
 *  @param degrees 角度
 *
 *  @return 旋转后图片
 */
- (UIImage *)tx_imageRotatedByDegrees:(CGFloat)degrees;

/**
 *  @brief  旋转图片
 *
 *  @param degrees 弧度
 *
 *  @return 旋转后图片
 */
- (UIImage *)tx_imageRotatedByRadians:(CGFloat)radians;

/**
 *  @brief  垂直翻转
 *
 *  @return  翻转后的图片
 */
- (UIImage *)tx_flipVertical;
/**
 *  @brief  水平翻转
 *
 *  @return 翻转后的图片
 */
- (UIImage *)tx_flipHorizontal;

/**
 *  @brief  角度转弧度
 *
 *  @param degrees 角度
 *
 *  @return 弧度
 */
+(CGFloat)tx_degreesToRadians:(CGFloat)degrees;
/**
 *  @brief  弧度转角度
 *
 *  @param radians 弧度
 *
 *  @return 角度
 */
+(CGFloat)tx_radiansToDegrees:(CGFloat)radians;

@end
