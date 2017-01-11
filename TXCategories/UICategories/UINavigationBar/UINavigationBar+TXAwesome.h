//
//  UINavigationBar+Awesome.h
//  LTNavigationBar
//
//  Created by ltebean on 15-2-15.
//  Copyright (c) 2015 ltebean. All rights reserved.
//  https://github.com/ltebean/LTNavigationBar

#import <UIKit/UIKit.h>

@interface UINavigationBar (TXAwesome)
- (void)tx_setBackgroundColor:(UIColor *)backgroundColor;
- (void)tx_setElementsAlpha:(CGFloat)alpha;
- (void)tx_setTranslationY:(CGFloat)translationY;
- (void)tx_reset;
@end
