//
//  UIImage+TXAsset.h
//  TXCategoriesDemo
//
//  Created by Eton on 2017/1/11.
//  Copyright © 2017年 王-庭协. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Photos/Photos.h>

//PHAsset 转 Image
@interface UIImage (TXAsset)

+ (void)imageFromPHAssets:(NSArray <PHAsset *> *)assets size:(CGSize )size resultHandler:(void (^ )(NSArray * images))resultHandler;

+ (void)imageDataFromPHAssets:(NSArray <PHAsset *> *)assets resultHandler:(void (^ )(NSArray * imageDatas))resultHandler;

+ (UIImage *)imageFromPHAsset:(PHAsset *)asset size:(CGSize )size;

+ (NSData *)imageDataFromPHAsset:(PHAsset *)asset;

@end
