//
//  UIView+draggable.m
//  UIView+draggable
//
//  Created by Andrea on 13/03/14.
//  Copyright (c) 2014 Fancy Pixel. All rights reserved.
//

#import "UIView+TXDraggable.h"
#import <objc/runtime.h>

@implementation UIView (TXDraggable)

- (void)setTx_panGesture:(UIPanGestureRecognizer*)panGesture
{
    objc_setAssociatedObject(self, @selector(tx_panGesture), panGesture, OBJC_ASSOCIATION_RETAIN);
}

- (UIPanGestureRecognizer*)tx_panGesture
{
    return objc_getAssociatedObject(self, @selector(tx_panGesture));
}

- (void)setTx_cagingArea:(CGRect)cagingArea
{
    if (CGRectEqualToRect(cagingArea, CGRectZero) ||
        CGRectContainsRect(cagingArea, self.frame)) {
        NSValue *cagingAreaValue = [NSValue valueWithCGRect:cagingArea];
        objc_setAssociatedObject(self, @selector(tx_cagingArea), cagingAreaValue, OBJC_ASSOCIATION_RETAIN);
    }
}

- (CGRect)tx_cagingArea
{
    NSValue *cagingAreaValue = objc_getAssociatedObject(self, @selector(tx_cagingArea));
    return [cagingAreaValue CGRectValue];
}

- (void)setTx_handle:(CGRect)handle
{
    CGRect relativeFrame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    if (CGRectContainsRect(relativeFrame, handle)) {
        NSValue *handleValue = [NSValue valueWithCGRect:handle];
        objc_setAssociatedObject(self, @selector(tx_handle), handleValue, OBJC_ASSOCIATION_RETAIN);
    }
}

- (CGRect)tx_handle
{
    NSValue *handleValue = objc_getAssociatedObject(self, @selector(tx_handle));
    return [handleValue CGRectValue];
}

- (void)setTx_shouldMoveAlongY:(BOOL)newShould
{
    NSNumber *shouldMoveAlongYBool = [NSNumber numberWithBool:newShould];
    objc_setAssociatedObject(self, @selector(tx_shouldMoveAlongY), shouldMoveAlongYBool, OBJC_ASSOCIATION_RETAIN );
}

- (BOOL)tx_shouldMoveAlongY
{
    NSNumber *moveAlongY = objc_getAssociatedObject(self, @selector(tx_shouldMoveAlongY));
    return (moveAlongY) ? [moveAlongY boolValue] : YES;
}

- (void)setTx_shouldMoveAlongX:(BOOL)newShould
{
    NSNumber *shouldMoveAlongXBool = [NSNumber numberWithBool:newShould];
    objc_setAssociatedObject(self, @selector(tx_shouldMoveAlongX), shouldMoveAlongXBool, OBJC_ASSOCIATION_RETAIN );
}

- (BOOL)tx_shouldMoveAlongX
{
    NSNumber *moveAlongX = objc_getAssociatedObject(self, @selector(tx_shouldMoveAlongX));
    return (moveAlongX) ? [moveAlongX boolValue] : YES;
}

- (void)setTx_draggingStartedBlock:(void (^)())draggingStartedBlock
{
    objc_setAssociatedObject(self, @selector(tx_draggingStartedBlock), draggingStartedBlock, OBJC_ASSOCIATION_RETAIN);
}

- (void (^)())tx_draggingStartedBlock
{
    return objc_getAssociatedObject(self, @selector(tx_draggingStartedBlock));
}

- (void)setTx_draggingEndedBlock:(void (^)())draggingEndedBlock
{
    objc_setAssociatedObject(self, @selector(tx_draggingEndedBlock), draggingEndedBlock, OBJC_ASSOCIATION_RETAIN);
}

- (void (^)())tx_draggingEndedBlock
{
    return objc_getAssociatedObject(self, @selector(tx_draggingEndedBlock));
}

- (void)tx_handlePan:(UIPanGestureRecognizer*)sender
{
    // Check to make you drag from dragging area
    CGPoint locationInView = [sender locationInView:self];
    if (!CGRectContainsPoint(self.tx_handle, locationInView)) {
        return;
    }
    
    [self tx_adjustAnchorPointForGestureRecognizer:sender];
    
    if (sender.state == UIGestureRecognizerStateBegan && self.tx_draggingStartedBlock) {
        self.tx_draggingStartedBlock();
    }
    
    if (sender.state == UIGestureRecognizerStateEnded && self.tx_draggingEndedBlock) {
        self.tx_draggingEndedBlock();
    }
    
    CGPoint translation = [sender translationInView:[self superview]];
    
    CGFloat newXOrigin = CGRectGetMinX(self.frame) + (([self tx_shouldMoveAlongX]) ? translation.x : 0);
    CGFloat newYOrigin = CGRectGetMinY(self.frame) + (([self tx_shouldMoveAlongY]) ? translation.y : 0);
    
    CGRect cagingArea = self.tx_cagingArea;
    
    CGFloat cagingAreaOriginX = CGRectGetMinX(cagingArea);
    CGFloat cagingAreaOriginY = CGRectGetMinY(cagingArea);
    
    CGFloat cagingAreaRightSide = cagingAreaOriginX + CGRectGetWidth(cagingArea);
    CGFloat cagingAreaBottomSide = cagingAreaOriginY + CGRectGetHeight(cagingArea);
    
    if (!CGRectEqualToRect(cagingArea, CGRectZero)) {
        
        // Check to make sure the view is still within the caging area
        if (newXOrigin <= cagingAreaOriginX ||
            newYOrigin <= cagingAreaOriginY ||
            newXOrigin + CGRectGetWidth(self.frame) >= cagingAreaRightSide ||
            newYOrigin + CGRectGetHeight(self.frame) >= cagingAreaBottomSide) {
            
            // Don't move
            newXOrigin = CGRectGetMinX(self.frame);
            newYOrigin = CGRectGetMinY(self.frame);
        }
    }
    
    [self setFrame:CGRectMake(newXOrigin,
                              newYOrigin,
                              CGRectGetWidth(self.frame),
                              CGRectGetHeight(self.frame))];
    
    [sender setTranslation:(CGPoint){0, 0} inView:[self superview]];
}

- (void)tx_adjustAnchorPointForGestureRecognizer:(UIGestureRecognizer *)gestureRecognizer
{
    if (gestureRecognizer.state == UIGestureRecognizerStateBegan) {
        UIView *piece = self;
        CGPoint locationInView = [gestureRecognizer locationInView:piece];
        CGPoint locationInSuperview = [gestureRecognizer locationInView:piece.superview];
        
        piece.layer.anchorPoint = CGPointMake(locationInView.x / piece.bounds.size.width, locationInView.y / piece.bounds.size.height);
        piece.center = locationInSuperview;
    }
}

- (void)tx_setDraggable:(BOOL)draggable
{
    [self.tx_panGesture setEnabled:draggable];
}

- (void)tx_enableDragging
{
    self.tx_panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(tx_handlePan:)];
    [self.tx_panGesture setMaximumNumberOfTouches:1];
    [self.tx_panGesture setMinimumNumberOfTouches:1];
    [self.tx_panGesture setCancelsTouchesInView:NO];
    [self setTx_handle:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    [self addGestureRecognizer:self.tx_panGesture];
}

@end
