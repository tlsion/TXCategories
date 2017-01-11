//
//  UIImage+RemoteSize.h
//  TXCategories (https://github.com/tlsion/TXCategories)
//
//  Created by 王-庭协 on 15/1/27.
//  Copyright (c) 2015年 www.skyfox.org. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^TXUIImageSizeRequestCompleted) (NSURL* imgURL, CGSize size);

@interface UIImage (TXRemoteSize)
/**
 *  @brief 获取远程图片的大小
 *
 *  @param imgURL     图片url
 *  @param completion 完成回调
 */
+ (void)tx_requestSizeNoHeader:(NSURL*)imgURL completion:(TXUIImageSizeRequestCompleted)completion;
/**
 *  @brief  从header中获取远程图片的大小 (服务器必须支持)
 *
 *  @param imgURL     图片url
 *  @param completion 完成回调
 */
//+ (void)requestSizeWithHeader:(NSURL*)imgURL completion:(UIImageSizeRequestCompleted)completion;

@end
