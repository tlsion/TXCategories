//
//  UIBarButtonItem+Badge.h
//  therichest
//
//  Created by Mike on 2014-05-05.
//  Copyright (c) 2014 Valnet Inc. All rights reserved.
//  https://github.com/mikeMTOL/UIBarButtonItem-Badge

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (TXBadge)

@property (strong, atomic) UILabel *tx_badge;

// Badge value to be display
@property (nonatomic) NSString *tx_badgeValue;
// Badge background color
@property (nonatomic) UIColor *tx_badgeBGColor;
// Badge text color
@property (nonatomic) UIColor *tx_badgeTextColor;
// Badge font
@property (nonatomic) UIFont *tx_badgeFont;
// Padding value for the badge
@property (nonatomic) CGFloat tx_badgePadding;
// Minimum size badge to small
@property (nonatomic) CGFloat tx_badgeMinSize;
// Values for offseting the badge over the BarButtonItem you picked
@property (nonatomic) CGFloat tx_badgeOriginX;
@property (nonatomic) CGFloat tx_badgeOriginY;
// In case of numbers, remove the badge when reaching zero
@property BOOL tx_shouldHideBadgeAtZero;
// Badge has a bounce animation when value changes
@property BOOL tx_shouldAnimateBadge;

@end
