//
//  UIImageView+BetterFace.h
//  bf
//
//  Created by croath on 13-10-22.
//  Copyright (c) 2013年 Croath. All rights reserved.
//
// https://github.com/croath/UIImageView-BetterFace
//  a UIImageView category to let the picture-cutting with faces showing better

#import <UIKit/UIKit.h>

@interface UIImageView (TXBetterFace)

@property (nonatomic) BOOL tx_needsBetterFace;
@property (nonatomic) BOOL tx_fast;

void tx_hack_uiimageview_bf();
- (void)tx_setBetterFaceImage:(UIImage *)image;

@end
