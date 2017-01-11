//
//  UIBarButtonItem+Badge.m
//  therichest
//
//  Created by Mike on 2014-05-05.
//  Copyright (c) 2014 Valnet Inc. All rights reserved.
//
#import <objc/runtime.h>
#import "UIBarButtonItem+TXBadge.h"

NSString const *tx_UIBarButtonItem_badgeKey = @"tx_UIBarButtonItem_badgeKey";

NSString const *tx_UIBarButtonItem_badgeBGColorKey = @"tx_UIBarButtonItem_badgeBGColorKey";
NSString const *tx_UIBarButtonItem_badgeTextColorKey = @"tx_UIBarButtonItem_badgeTextColorKey";
NSString const *tx_UIBarButtonItem_badgeFontKey = @"tx_UIBarButtonItem_badgeFontKey";
NSString const *tx_UIBarButtonItem_badgePaddingKey = @"tx_UIBarButtonItem_badgePaddingKey";
NSString const *tx_UIBarButtonItem_badgeMinSizeKey = @"tx_UIBarButtonItem_badgeMinSizeKey";
NSString const *tx_UIBarButtonItem_badgeOriginXKey = @"tx_UIBarButtonItem_badgeOriginXKey";
NSString const *tx_UIBarButtonItem_badgeOriginYKey = @"tx_UIBarButtonItem_badgeOriginYKey";
NSString const *tx_UIBarButtonItem_shouldHideBadgeAtZeroKey = @"tx_UIBarButtonItem_shouldHideBadgeAtZeroKey";
NSString const *tx_UIBarButtonItem_shouldAnimateBadgeKey = @"tx_UIBarButtonItem_shouldAnimateBadgeKey";
NSString const *tx_UIBarButtonItem_badgeValueKey = @"tx_UIBarButtonItem_badgeValueKey";

@implementation UIBarButtonItem (TXBadge)

@dynamic tx_badgeValue, tx_badgeBGColor, tx_badgeTextColor, tx_badgeFont;
@dynamic tx_badgePadding, tx_badgeMinSize, tx_badgeOriginX, tx_badgeOriginY;
@dynamic tx_shouldHideBadgeAtZero, tx_shouldAnimateBadge;

- (void)tx_badgeInit
{
    UIView *superview = nil;
    CGFloat defaultOriginX = 0;
    if (self.customView) {
        superview = self.customView;
        defaultOriginX = superview.frame.size.width - self.tx_badge.frame.size.width/2;
        // Avoids badge to be clipped when animating its scale
        superview.clipsToBounds = NO;
    } else if ([self respondsToSelector:@selector(view)] && [(id)self view]) {
        superview = [(id)self view];
        defaultOriginX = superview.frame.size.width - self.tx_badge.frame.size.width;
    }
    [superview addSubview:self.tx_badge];
    
    // Default design initialization
    self.tx_badgeBGColor   = [UIColor redColor];
    self.tx_badgeTextColor = [UIColor whiteColor];
    self.tx_badgeFont      = [UIFont systemFontOfSize:12.0];
    self.tx_badgePadding   = 6;
    self.tx_badgeMinSize   = 8;
    self.tx_badgeOriginX   = defaultOriginX;
    self.tx_badgeOriginY   = -4;
    self.tx_shouldHideBadgeAtZero = YES;
    self.tx_shouldAnimateBadge = YES;
}

#pragma mark - Utility methods

// Handle badge display when its properties have been changed (color, font, ...)
- (void)tx_refreshBadge
{
    // Change new attributes
    self.tx_badge.textColor        = self.tx_badgeTextColor;
    self.tx_badge.backgroundColor  = self.tx_badgeBGColor;
    self.tx_badge.font             = self.tx_badgeFont;
    
    if (!self.tx_badgeValue || [self.tx_badgeValue isEqualToString:@""] || ([self.tx_badgeValue isEqualToString:@"0"] && self.tx_shouldHideBadgeAtZero)) {
        self.tx_badge.hidden = YES;
    } else {
        self.tx_badge.hidden = NO;
        [self tx_updateBadgeValueAnimated:YES];
    }

}

- (CGSize)tx_badgeExpectedSize
{
    // When the value changes the badge could need to get bigger
    // Calculate expected size to fit new value
    // Use an intermediate label to get expected size thanks to sizeToFit
    // We don't call sizeToFit on the true label to avoid bad display
    UILabel *frameLabel = [self tx_duplicateLabel:self.tx_badge];
    [frameLabel sizeToFit];
    
    CGSize expectedLabelSize = frameLabel.frame.size;
    return expectedLabelSize;
}

- (void)tx_updateBadgeFrame
{

    CGSize expectedLabelSize = [self tx_badgeExpectedSize];
    
    // Make sure that for small value, the badge will be big enough
    CGFloat minHeight = expectedLabelSize.height;
    
    // Using a const we make sure the badge respect the minimum size
    minHeight = (minHeight < self.tx_badgeMinSize) ? self.tx_badgeMinSize : expectedLabelSize.height;
    CGFloat minWidth = expectedLabelSize.width;
    CGFloat padding = self.tx_badgePadding;
    
    // Using const we make sure the badge doesn't get too smal
    minWidth = (minWidth < minHeight) ? minHeight : expectedLabelSize.width;
    self.tx_badge.layer.masksToBounds = YES;
    self.tx_badge.frame = CGRectMake(self.tx_badgeOriginX, self.tx_badgeOriginY, minWidth + padding, minHeight + padding);
    self.tx_badge.layer.cornerRadius = (minHeight + padding) / 2;
}

// Handle the badge changing value
- (void)tx_updateBadgeValueAnimated:(BOOL)animated
{
    // Bounce animation on badge if value changed and if animation authorized
    if (animated && self.tx_shouldAnimateBadge && ![self.tx_badge.text isEqualToString:self.tx_badgeValue]) {
        CABasicAnimation * animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
        [animation setFromValue:[NSNumber numberWithFloat:1.5]];
        [animation setToValue:[NSNumber numberWithFloat:1]];
        [animation setDuration:0.2];
        [animation setTimingFunction:[CAMediaTimingFunction functionWithControlPoints:.4f :1.3f :1.f :1.f]];
        [self.tx_badge.layer addAnimation:animation forKey:@"bounceAnimation"];
    }
    
    // Set the new value
    self.tx_badge.text = self.tx_badgeValue;
    
    // Animate the size modification if needed
    if (animated && self.tx_shouldAnimateBadge) {
        [UIView animateWithDuration:0.2 animations:^{
            [self tx_updateBadgeFrame];
        }];
    } else {
        [self tx_updateBadgeFrame];
    }
}

- (UILabel *)tx_duplicateLabel:(UILabel *)labelToCopy
{
    UILabel *duplicateLabel = [[UILabel alloc] initWithFrame:labelToCopy.frame];
    duplicateLabel.text = labelToCopy.text;
    duplicateLabel.font = labelToCopy.font;
    
    return duplicateLabel;
}

- (void)tx_removeBadge
{
    // Animate badge removal
    [UIView animateWithDuration:0.2 animations:^{
        self.tx_badge.transform = CGAffineTransformMakeScale(0, 0);
    } completion:^(BOOL finished) {
        [self.tx_badge removeFromSuperview];
        self.tx_badge = nil;
    }];
}

#pragma mark - getters/setters
-(UILabel*)tx_badge {
    UILabel* lbl = objc_getAssociatedObject(self, &tx_UIBarButtonItem_badgeKey);
    if(lbl==nil) {
        lbl = [[UILabel alloc] initWithFrame:CGRectMake(self.tx_badgeOriginX, self.tx_badgeOriginY, 20, 20)];
        [self setTx_badge:lbl];
        [self tx_badgeInit];
        [self.customView addSubview:lbl];
        lbl.textAlignment = NSTextAlignmentCenter;
    }
    return lbl;
}
-(void)setTx_badge:(UILabel *)badgeLabel
{
    objc_setAssociatedObject(self, &tx_UIBarButtonItem_badgeKey, badgeLabel, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

// Badge value to be display
-(NSString *)tx_badgeValue {
    return objc_getAssociatedObject(self, &tx_UIBarButtonItem_badgeValueKey);
}
-(void)setTx_vadgeValue:(NSString *)badgeValue
{
    objc_setAssociatedObject(self, &tx_UIBarButtonItem_badgeValueKey, badgeValue, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    // When changing the badge value check if we need to remove the badge
    [self tx_updateBadgeValueAnimated:YES];
    [self tx_refreshBadge];
}

// Badge background color
-(UIColor *)badgeBGColor {
    return objc_getAssociatedObject(self, &tx_UIBarButtonItem_badgeBGColorKey);
}
-(void)setBadgeBGColor:(UIColor *)badgeBGColor
{
    objc_setAssociatedObject(self, &tx_UIBarButtonItem_badgeBGColorKey, badgeBGColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if (self.tx_badge) {
        [self tx_refreshBadge];
    }
}

// Badge text color
-(UIColor *)badgeTextColor {
    return objc_getAssociatedObject(self, &tx_UIBarButtonItem_badgeTextColorKey);
}
-(void)setBadgeTextColor:(UIColor *)badgeTextColor
{
    objc_setAssociatedObject(self, &tx_UIBarButtonItem_badgeTextColorKey, badgeTextColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if (self.tx_badge) {
        [self tx_refreshBadge];
    }
}

// Badge font
-(UIFont *)badgeFont {
    return objc_getAssociatedObject(self, &tx_UIBarButtonItem_badgeFontKey);
}
-(void)setBadgeFont:(UIFont *)badgeFont
{
    objc_setAssociatedObject(self, &tx_UIBarButtonItem_badgeFontKey, badgeFont, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if (self.tx_badge) {
        [self tx_refreshBadge];
    }
}

// Padding value for the badge
-(CGFloat) badgePadding {
    NSNumber *number = objc_getAssociatedObject(self, &tx_UIBarButtonItem_badgePaddingKey);
    return number.floatValue;
}
-(void) setBadgePadding:(CGFloat)badgePadding
{
    NSNumber *number = [NSNumber numberWithDouble:badgePadding];
    objc_setAssociatedObject(self, &tx_UIBarButtonItem_badgePaddingKey, number, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if (self.tx_badge) {
        [self tx_updateBadgeFrame];
    }
}

// Minimum size badge to small
-(CGFloat)tx_badgeMinSize {
    NSNumber *number = objc_getAssociatedObject(self, &tx_UIBarButtonItem_badgeMinSizeKey);
    return number.floatValue;
}
-(void) setTx_badgeMinSize:(CGFloat)badgeMinSize
{
    NSNumber *number = [NSNumber numberWithDouble:badgeMinSize];
    objc_setAssociatedObject(self, &tx_UIBarButtonItem_badgeMinSizeKey, number, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if (self.tx_badge) {
        [self tx_updateBadgeFrame];
    }
}

// Values for offseting the badge over the BarButtonItem you picked
-(CGFloat)tx_badgeOriginX {
    NSNumber *number = objc_getAssociatedObject(self, &tx_UIBarButtonItem_badgeOriginXKey);
    return number.floatValue;
}
-(void) setTx_badgeOriginX:(CGFloat)badgeOriginX
{
    NSNumber *number = [NSNumber numberWithDouble:badgeOriginX];
    objc_setAssociatedObject(self, &tx_UIBarButtonItem_badgeOriginXKey, number, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if (self.tx_badge) {
        [self tx_updateBadgeFrame];
    }
}

-(CGFloat)tx_badgeOriginY {
    NSNumber *number = objc_getAssociatedObject(self, &tx_UIBarButtonItem_badgeOriginYKey);
    return number.floatValue;
}
-(void) setTx_badgeOriginY:(CGFloat)badgeOriginY
{
    NSNumber *number = [NSNumber numberWithDouble:badgeOriginY];
    objc_setAssociatedObject(self, &tx_UIBarButtonItem_badgeOriginYKey, number, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if (self.tx_badge) {
        [self tx_updateBadgeFrame];
    }
}

// In case of numbers, remove the badge when reaching zero
-(BOOL) shouldHideBadgeAtZero {
    NSNumber *number = objc_getAssociatedObject(self, &tx_UIBarButtonItem_shouldHideBadgeAtZeroKey);
    return number.boolValue;
}
- (void)setShouldHideBadgeAtZero:(BOOL)shouldHideBadgeAtZero
{
    NSNumber *number = [NSNumber numberWithBool:shouldHideBadgeAtZero];
    objc_setAssociatedObject(self, &tx_UIBarButtonItem_shouldHideBadgeAtZeroKey, number, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if(self.tx_badge) {
        [self tx_refreshBadge];
    }
}

// Badge has a bounce animation when value changes
-(BOOL) tx_shouldAnimateBadge {
    NSNumber *number = objc_getAssociatedObject(self, &tx_UIBarButtonItem_shouldAnimateBadgeKey);
    return number.boolValue;
}
- (void)setTx_shouldAnimateBadge:(BOOL)shouldAnimateBadge
{
    NSNumber *number = [NSNumber numberWithBool:shouldAnimateBadge];
    objc_setAssociatedObject(self, &tx_UIBarButtonItem_shouldAnimateBadgeKey, number, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if(self.tx_badge) {
        [self tx_refreshBadge];
    }
}


@end
