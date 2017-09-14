//
//  UILabel+TXEstimate.m
//  WordPress
//
//  Created by Eric J on 6/18/13.
//  Copyright (c) 2013 WordPress. All rights reserved.
//

#import "UILabel+TXEstimate.h"
#import "NSString+TXSize.h"

@implementation UILabel (TXEstimate)

- (CGFloat )tx_estimateWidth{
    NSString * string = [self text];
    if (!string) {
        return 0;
    }
    CGSize size = [string tx_sizeWithFont:[self font] constrainedToSize:CGSizeMake(CGFLOAT_MAX, self.frame.size.height)];
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
    return [string tx_sizeWithFont:[self font] constrainedToSize:CGSizeMake(width, CGFLOAT_MAX)];
}

@end
