//
//  UIScrollView+TXAddition.h
//  TXCategories (https://github.com/tlsion/TXCategories)
//
//  Created by 王-庭协 on 14/12/30.
//  Copyright (c) 2014年 www.skyfox.org. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, TXScrollDirection) {
    TXScrollDirectionUp,
    TXScrollDirectionDown,
    TXScrollDirectionLeft,
    TXScrollDirectionRight,
    TXScrollDirectionWTF
};

@interface UIScrollView (TXAddition)
@property(nonatomic) CGFloat tx_contentWidth;
@property(nonatomic) CGFloat tx_contentHeight;
@property(nonatomic) CGFloat tx_contentOffsetX;
@property(nonatomic) CGFloat tx_contentOffsetY;

- (CGPoint)tx_topContentOffset;
- (CGPoint)tx_bottomContentOffset;
- (CGPoint)tx_leftContentOffset;
- (CGPoint)tx_rightContentOffset;

- (TXScrollDirection)tx_ScrollDirection;

- (BOOL)tx_isScrolledToTop;
- (BOOL)tx_isScrolledToBottom;
- (BOOL)tx_isScrolledToLeft;
- (BOOL)tx_isScrolledToRight;
- (void)tx_scrollToTopAnimated:(BOOL)animated;
- (void)tx_scrollToBottomAnimated:(BOOL)animated;
- (void)tx_scrollToLeftAnimated:(BOOL)animated;
- (void)tx_scrollToRightAnimated:(BOOL)animated;

- (NSUInteger)tx_verticalPageIndex;
- (NSUInteger)tx_horizontalPageIndex;

- (void)tx_scrollToVerticalPageIndex:(NSUInteger)pageIndex animated:(BOOL)animated;
- (void)tx_scrollToHorizontalPageIndex:(NSUInteger)pageIndex animated:(BOOL)animated;
@end
