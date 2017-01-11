//
//  UITextField+Shake.m
//  UITextField+Shake
//
//  Created by Andrea Mazzini on 08/02/14.
//  Copyright (c) 2014 Fancy Pixel. All rights reserved.
//

#import "UITextField+TXShake.h"

@implementation UITextField (TXShake)

- (void)tx_shake {
    [self tx_shake:10 withDelta:5 completion:nil];
}

- (void)tx_shake:(int)times withDelta:(CGFloat)delta {
    [self tx_shake:times withDelta:delta completion:nil];
}

- (void)tx_shake:(int)times withDelta:(CGFloat)delta completion:(void(^)())handler {
    [self _tx_shake:times direction:1 currentTimes:0 withDelta:delta speed:0.03 shakeDirection:TXShakedDirectionHorizontal completion:handler];
}

- (void)tx_shake:(int)times withDelta:(CGFloat)delta speed:(NSTimeInterval)interval {
    [self tx_shake:times withDelta:delta speed:interval completion:nil];
}

- (void)tx_shake:(int)times withDelta:(CGFloat)delta speed:(NSTimeInterval)interval completion:(void(^)())handler {
    [self _tx_shake:times direction:1 currentTimes:0 withDelta:delta speed:interval shakeDirection:TXShakedDirectionHorizontal completion:handler];
}

- (void)tx_shake:(int)times withDelta:(CGFloat)delta speed:(NSTimeInterval)interval shakeDirection:(TXShakedDirection)shakeDirection {
    [self tx_shake:times withDelta:delta speed:interval shakeDirection:shakeDirection completion:nil];
}

- (void)tx_shake:(int)times withDelta:(CGFloat)delta speed:(NSTimeInterval)interval shakeDirection:(TXShakedDirection)shakeDirection completion:(void(^)())handler {
    [self _tx_shake:times direction:1 currentTimes:0 withDelta:delta speed:interval shakeDirection:shakeDirection completion:handler];
}

- (void)_tx_shake:(int)times direction:(int)direction currentTimes:(int)current withDelta:(CGFloat)delta speed:(NSTimeInterval)interval shakeDirection:(TXShakedDirection)shakeDirection completion:(void(^)())handler {
    [UIView animateWithDuration:interval animations:^{
        self.transform = (shakeDirection == TXShakedDirectionHorizontal) ? CGAffineTransformMakeTranslation(delta * direction, 0) : CGAffineTransformMakeTranslation(0, delta * direction);
    } completion:^(BOOL finished) {
        if(current >= times) {
            [UIView animateWithDuration:interval animations:^{
                self.transform = CGAffineTransformIdentity;
            } completion:^(BOOL finished) {
                if (handler) {
                    handler();
                }
            }];
            return;
        }
        [self _tx_shake:(times - 1)
           direction:direction * -1
        currentTimes:current + 1
           withDelta:delta
               speed:interval
      shakeDirection:shakeDirection
          completion:handler];
    }];
}

@end
