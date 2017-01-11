//
//  UIImage+GIF.h
//  LBGIFImage
//
//  Created by Laurin Brandner on 06.01.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (TXGIF)

+ (UIImage *)tx_animatedGIFNamed:(NSString *)name;

+ (UIImage *)tx_animatedGIFWithData:(NSData *)data;

- (UIImage *)tx_animatedImageByScalingAndCroppingToSize:(CGSize)size;

@end
