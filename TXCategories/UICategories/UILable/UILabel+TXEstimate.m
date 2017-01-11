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
    CGSize size = [self tx_estimateSizeForWidth:CGFLOAT_MAX];
    return ceil(size.width);
}

- (CGFloat )tx_estimateHeightByWidth:(CGFloat )width{
    CGSize size = [self tx_estimateSizeForWidth:width];
    return ceil(size.height);
}

- (CGSize)tx_estimateSizeForWidth:(CGFloat)width {
    if (self.attributedText)
        return [self tx_estimateSizeForAttributedString:self.attributedText width:width];
    
	return [self tx_estimateSizeForString:self.text width:width];
}

- (CGSize)tx_estimateSizeForAttributedString:(NSAttributedString *)string width:(CGFloat)width {
    if (!string) {
        return CGSizeZero;
    }
    return [string boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:nil].size;
}

- (CGSize)tx_estimateSizeForString:(NSString *)string width:(CGFloat)width {
    if (!string) {
        return CGSizeZero;
    }
    return [self tx_estimateSizeForAttributedString:[[NSAttributedString alloc] initWithString:string attributes:@{NSFontAttributeName: self.font}] width:width];
}

@end
