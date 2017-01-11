//
//  UIControl+TXBlock.h
//  FXCategories
//
//  Created by fox softer on 15/2/23.
//  Copyright (c) 2015年 foxsofter. All rights reserved.
//  https://github.com/foxsofter/FXCategories
//  http://stackoverflow.com/questions/2437875/target-action-uicontrolevents
#import <UIKit/UIKit.h>

@interface UIControl (TXBlock)

- (void)tx_touchDown:(void (^)(void))eventBlock;
- (void)tx_touchDownRepeat:(void (^)(void))eventBlock;
- (void)tx_touchDragInside:(void (^)(void))eventBlock;
- (void)tx_touchDragOutside:(void (^)(void))eventBlock;
- (void)tx_touchDragEnter:(void (^)(void))eventBlock;
- (void)tx_touchDragExit:(void (^)(void))eventBlock;
- (void)tx_touchUpInside:(void (^)(void))eventBlock;
- (void)tx_touchUpOutside:(void (^)(void))eventBlock;
- (void)tx_touchCancel:(void (^)(void))eventBlock;
- (void)tx_valueChanged:(void (^)(void))eventBlock;
- (void)tx_editingDidBegin:(void (^)(void))eventBlock;
- (void)tx_editingChanged:(void (^)(void))eventBlock;
- (void)tx_editingDidEnd:(void (^)(void))eventBlock;
- (void)tx_editingDidEndOnExit:(void (^)(void))eventBlock;

@end
