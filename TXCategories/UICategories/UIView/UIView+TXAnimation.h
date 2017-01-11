//
//  UIView+Animation.h
//  CoolUIViewAnimations
//
//  Created by Peter de Tagyos on 12/10/11.
//  Copyright (c) 2011 PT Software Solutions. All rights reserved.
//

#import <UIKit/UIKit.h>

float tx_radiansForDegrees(int degrees);

@interface UIView (TXAnimation)

// Moves
- (void)tx_moveTo:(CGPoint)destination duration:(float)secs option:(UIViewAnimationOptions)option;
- (void)tx_moveTo:(CGPoint)destination duration:(float)secs option:(UIViewAnimationOptions)option delegate:(id)delegate callback:(SEL)method;
- (void)tx_raceTo:(CGPoint)destination withSnapBack:(BOOL)withSnapBack;
- (void)tx_raceTo:(CGPoint)destination withSnapBack:(BOOL)withSnapBack delegate:(id)delegate callback:(SEL)method;

// Transforms
- (void)tx_rotate:(int)degrees secs:(float)secs delegate:(id)delegate callback:(SEL)method;
- (void)tx_scale:(float)secs x:(float)scaleX y:(float)scaleY delegate:(id)delegate callback:(SEL)method;
- (void)tx_spinClockwise:(float)secs;
- (void)tx_spinCounterClockwise:(float)secs;

// Transitions
- (void)tx_curlDown:(float)secs;
- (void)tx_curlUpAndAway:(float)secs;
- (void)tx_drainAway:(float)secs;

// Effects
- (void)tx_changeAlpha:(float)newAlpha secs:(float)secs;
- (void)tx_pulse:(float)secs continuously:(BOOL)continuously;

//add subview
- (void)tx_addSubviewWithFadeAnimation:(UIView *)subview;

@end
