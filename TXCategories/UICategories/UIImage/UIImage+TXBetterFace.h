//
//  UIImage+BetterFace.h
//  bf
//
//  Created by liuyan on 13-11-25.
//  Copyright (c) 2013年 Croath. All rights reserved.
//
// https://github.com/croath/UIImageView-BetterFace
//  a UIImageView category to let the picture-cutting with faces showing better

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, TXAccuracy) {
    TXAccuracyLow = 0,
    TXAccuracyHigh,
};

@interface UIImage (TXBetterFace)

- (UIImage *)tx_betterFaceImageForSize:(CGSize)size
                           accuracy:(TXAccuracy)accurary;

@end
