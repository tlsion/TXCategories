//
//  UIView+Shake.m
//  UIView+Shake
//
//  Created by Andrea Mazzini on 08/02/14.
//  Copyright (c) 2014 Fancy Pixel. All rights reserved.
//

#import "UIView+TXShake.h"

@implementation UIView (TXShake)

- (void)tx_shake {
    [self _tx_shake:10 direction:1 currentTimes:0 withDelta:5 speed:0.03 shakeDirection:TXShakeDirectionHorizontal completion:nil];
}

- (void)tx_shake:(int)times withDelta:(CGFloat)delta {
    [self _tx_shake:times direction:1 currentTimes:0 withDelta:delta speed:0.03 shakeDirection:TXShakeDirectionHorizontal completion:nil];
}

- (void)tx_shake:(int)times withDelta:(CGFloat)delta completion:(void(^)())handler {
    [self _tx_shake:times direction:1 currentTimes:0 withDelta:delta speed:0.03 shakeDirection:TXShakeDirectionHorizontal completion:handler];
}

- (void)tx_shake:(int)times withDelta:(CGFloat)delta speed:(NSTimeInterval)interval {
    [self _tx_shake:times direction:1 currentTimes:0 withDelta:delta speed:interval shakeDirection:TXShakeDirectionHorizontal completion:nil];
}

- (void)tx_shake:(int)times withDelta:(CGFloat)delta speed:(NSTimeInterval)interval completion:(void(^)())handler {
    [self _tx_shake:times direction:1 currentTimes:0 withDelta:delta speed:interval shakeDirection:TXShakeDirectionHorizontal completion:handler];
}

- (void)tx_shake:(int)times withDelta:(CGFloat)delta speed:(NSTimeInterval)interval shakeDirection:(TXShakeDirection)shakeDirection {
    [self _tx_shake:times direction:1 currentTimes:0 withDelta:delta speed:interval shakeDirection:shakeDirection completion:nil];
}

- (void)tx_shake:(int)times withDelta:(CGFloat)delta speed:(NSTimeInterval)interval shakeDirection:(TXShakeDirection)shakeDirection completion:(void (^)(void))completion {
    [self _tx_shake:times direction:1 currentTimes:0 withDelta:delta speed:interval shakeDirection:shakeDirection completion:completion];
}

- (void)_tx_shake:(int)times direction:(int)direction currentTimes:(int)current withDelta:(CGFloat)delta speed:(NSTimeInterval)interval shakeDirection:(TXShakeDirection)shakeDirection completion:(void (^)(void))completionHandler {
    [UIView animateWithDuration:interval animations:^{
        self.layer.affineTransform = (shakeDirection == TXShakeDirectionHorizontal) ? CGAffineTransformMakeTranslation(delta * direction, 0) : CGAffineTransformMakeTranslation(0, delta * direction);
    } completion:^(BOOL finished) {
        if(current >= times) {
            [UIView animateWithDuration:interval animations:^{
                self.layer.affineTransform = CGAffineTransformIdentity;
            } completion:^(BOOL finished){
                if (completionHandler != nil) {
                    completionHandler();
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
          completion:completionHandler];
    }];
}

@end
