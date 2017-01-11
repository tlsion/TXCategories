//
//  UIImage+SuperCompress.h
//  TXCategories (https://github.com/tlsion/TXCategories)
//
//  Created by 王-庭协 on 16/1/22.
//  Copyright © 2017年 ApeStar. All rights reserved.
//  https://github.com/CompletionHandler/CYImageCompress

//usage      [UIImage compressImage:image toMaxLength:512*1024*8 maxWidth:1024];

#import <UIKit/UIKit.h>

@interface UIImage (TXSuperCompress)
/**
 *  压缩上传图片到指定字节
 *
 *  @param image     压缩的图片
 *  @param maxLength 压缩后最大字节大小
 *
 *  @return 压缩后图片的二进制
 */
+ (NSData *)tx_compressImage:(UIImage *)image toMaxLength:(NSInteger) maxLength;
+ (NSData *)tx_compressImage:(UIImage *)image toMaxLength:(NSInteger) maxLength maxWidth:(NSInteger)maxWidth;

/**
 *  获得指定size的图片
 *
 *  @param image   原始图片
 *  @param newSize 指定的size
 *
 *  @return 调整后的图片
 */
+ (UIImage *)tx_resizeImage:(UIImage *) image withNewSize:(CGSize) newSize;

/**
 *  通过指定图片最长边，获得等比例的图片size
 *
 *  @param image       原始图片
 *  @param imageLength 图片允许的最长宽度（高度）
 *
 *  @return 获得等比例的size
 */
+ (CGSize)tx_scaleImage:(UIImage *) image withLength:(CGFloat) imageLength;


+ (UIImage*)tx_resizableHalfImage:(NSString *)name;
@end
