//
//  UIImage+TXAsset.m
//  TXCategoriesDemo
//
//  Created by Eton on 2017/1/11.
//  Copyright © 2017年 王-庭协. All rights reserved.
//

#import "UIImage+TXAsset.h"
#import "UIImage+TXGIF.h"

@implementation UIImage (TXAsset)

+ (void)imageFromPHAssets:(NSArray <PHAsset *> *)assets size:(CGSize )size resultHandler:(void (^ )(NSArray * images))resultHandler
{
    __block NSInteger count = assets.count;
    NSMutableArray * resultImages = [NSMutableArray array];
    for (PHAsset * asset in assets) {
        PHImageRequestOptions *options = [[PHImageRequestOptions alloc] init];
        options.deliveryMode = PHImageRequestOptionsDeliveryModeHighQualityFormat;
        
        // 是否要原图
        if (size.width == 0 || size.height == 0) {
            size = CGSizeMake(asset.pixelWidth, asset.pixelHeight);
        }else if (asset.pixelWidth < size.width || asset.pixelHeight < size.height){
            size = CGSizeMake(asset.pixelWidth, asset.pixelHeight);
        }
        
        // 从asset中获得图片
        [[PHImageManager defaultManager] requestImageForAsset:asset targetSize:size contentMode:PHImageContentModeAspectFill options:options resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
            
            count--;
            [resultImages addObject:result];
            if (count == 0) {
                resultHandler(resultImages);
            }
        }];
    }
}

+ (void)imageDataFromPHAssets:(NSArray <PHAsset *> *)assets resultHandler:(void (^ )(NSArray * imageDatas))resultHandler
{
    __block NSInteger count = assets.count;
    NSMutableArray * resultImages = [NSMutableArray array];
    for (PHAsset * asset in assets) {
        PHImageRequestOptions *options = [[PHImageRequestOptions alloc] init];
        options.deliveryMode = PHImageRequestOptionsDeliveryModeHighQualityFormat;
        
        [[PHImageManager defaultManager] requestImageDataForAsset:asset options:options resultHandler:^(NSData * _Nullable imageData, NSString * _Nullable dataUTI, UIImageOrientation orientation, NSDictionary * _Nullable info) {
            CGImageSourceRef source = CGImageSourceCreateWithData((__bridge CFDataRef)imageData, NULL);
            
            size_t imageCount = CGImageSourceGetCount(source);
            
            UIImage *animatedImage;
            
            if (imageCount <= 1) {
                animatedImage = [[UIImage alloc] initWithData:imageData];
            }else{
                animatedImage = [UIImage tx_animatedGIFWithData:imageData];
            }
            
            count--;
            [resultImages addObject:animatedImage];
            if (count == 0) {
                resultHandler(resultImages);
            }
            
        }];
    }
}

+ (UIImage *)imageFromPHAsset:(PHAsset *)asset size:(CGSize )size
{
    __block UIImage * resultImage = nil;
    PHImageRequestOptions *options = [[PHImageRequestOptions alloc] init];
    options.deliveryMode = PHImageRequestOptionsDeliveryModeHighQualityFormat;
    // 同步获得图片, 只会返回1张图片
    options.synchronous = YES;
    
    // 是否要原图
    if (size.width == 0 || size.height == 0) {
        size = CGSizeMake(asset.pixelWidth, asset.pixelHeight);
    }else if (asset.pixelWidth < size.width || asset.pixelHeight < size.height){
        size = CGSizeMake(asset.pixelWidth, asset.pixelHeight);
    }
    
    // 从asset中获得图片
    [[PHImageManager defaultManager] requestImageForAsset:asset targetSize:size contentMode:PHImageContentModeDefault options:options resultHandler:^(UIImage * result, NSDictionary * info) {
        resultImage = result;
    }];
    return resultImage;
}

+ (NSData *__nullable)imageDataFromPHAsset:(PHAsset *)asset
{
    __block NSData * resultData = nil;
    PHImageRequestOptions *options = [[PHImageRequestOptions alloc] init];
    options.deliveryMode = PHImageRequestOptionsDeliveryModeHighQualityFormat;
    // 同步获得图片, 只会返回1张图片
    options.synchronous = YES;
    
    [[PHImageManager defaultManager] requestImageDataForAsset:asset options:options resultHandler:^(NSData * imageData, NSString * dataUTI, UIImageOrientation orientation, NSDictionary * info) {
        resultData = imageData;
    }];
    return resultData;
}

@end
