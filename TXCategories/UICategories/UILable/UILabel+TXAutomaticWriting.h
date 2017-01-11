//
//  UILabel+AutomaticWriting.h
//  UILabel-AutomaticWriting
//
//  Created by alexruperez on 10/3/15.
//  Copyright (c) 2015 alexruperez. All rights reserved.
//  https://github.com/alexruperez/UILabel-AutomaticWriting

#import <UIKit/UIKit.h>

//! Project version number for UILabel-AutomaticWriting.
FOUNDATION_EXPORT double UILabelAutomaticWritingVersionNumber;

//! Project version string for UILabel-AutomaticWriting.
FOUNDATION_EXPORT const unsigned char UILabelAutomaticWritingVersionString[];

extern NSTimeInterval const UILabelAWDefaultDuration;

extern unichar const UILabelAWDefaultCharacter;

typedef NS_ENUM(NSInteger, UILabelTXlinkingMode)
{
    UILabelTXlinkingModeNone,
    UILabelTXlinkingModeUntilFinish,
    UILabelTXlinkingModeUntilFinishKeeping,
    UILabelTXlinkingModeWhenFinish,
    UILabelTXlinkingModeWhenFinishShowing,
    UILabelTXlinkingModeAlways
};

@interface UILabel (TXAutomaticWriting)

@property (strong, nonatomic) NSOperationQueue *tx_automaticWritingOperationQueue;
@property (assign, nonatomic) UIEdgeInsets tx_edgeInsets;

- (void)tx_setTextWithAutomaticWritingAnimation:(NSString *)text;

- (void)tx_setText:(NSString *)text automaticWritingAnimationWithBlinkingMode:(UILabelTXlinkingMode)blinkingMode;

- (void)tx_setText:(NSString *)text automaticWritingAnimationWithDuration:(NSTimeInterval)duration;

- (void)tx_setText:(NSString *)text automaticWritingAnimationWithDuration:(NSTimeInterval)duration blinkingMode:(UILabelTXlinkingMode)blinkingMode;

- (void)tx_setText:(NSString *)text automaticWritingAnimationWithDuration:(NSTimeInterval)duration blinkingMode:(UILabelTXlinkingMode)blinkingMode blinkingCharacter:(unichar)blinkingCharacter;

- (void)tx_setText:(NSString *)text automaticWritingAnimationWithDuration:(NSTimeInterval)duration blinkingMode:(UILabelTXlinkingMode)blinkingMode blinkingCharacter:(unichar)blinkingCharacter completion:(void (^)(void))completion;

@end
