//
//  UILabel+TXEstimate.m
//  WordPress
//
//  Created by Eric J on 6/18/13.
//  Copyright (c) 2013 WordPress. All rights reserved.
//

#import "UILabel+TXEstimate.h"

@implementation UILabel (TXEstimate)

- (CGFloat )tx_estimateWidth{
    CGSize size = [self tx_estimateSizeByWidth:CGFLOAT_MAX];
    return ceil(size.width);
}

- (CGFloat )tx_estimateHeightByWidth:(CGFloat )width{
    CGSize size = [self tx_estimateSizeByWidth:width];
    return ceil(size.height);
}

- (CGSize)tx_estimateSizeByWidth:(CGFloat)width {
    NSString * string = [self text];
    if (!string) {
        return CGSizeZero;
    }
    return [string tx_sizeWithFont:[self font] constrainedToSize:CGSizeMake(CGFLOAT_MAX, width)];
}

@end
