//
//  UIScrollView+TXAddition.m
//  TXCategories (https://github.com/tlsion/TXCategories)
//
//  Created by 王-庭协 on 14/12/30.
//  Copyright (c) 2014年 www.skyfox.org. All rights reserved.
//

#import "UIScrollView+TXAddition.h"

@implementation UIScrollView (TXAddition)
//frame
- (CGFloat)tx_contentWidth {
    return self.contentSize.width;
}
- (void)setTx_contentWidth:(CGFloat)width {
    self.contentSize = CGSizeMake(width, self.frame.size.height);
}
- (CGFloat)tx_contentHeight {
    return self.contentSize.height;
}
- (void)setTx_contentHeight:(CGFloat)height {
    self.contentSize = CGSizeMake(self.frame.size.width, height);
}
- (CGFloat)tx_contentOffsetX {
    return self.contentOffset.x;
}
- (void)setTx_contentOffsetX:(CGFloat)x {
    self.contentOffset = CGPointMake(x, self.contentOffset.y);
}
- (CGFloat)tx_contentOffsetY {
    return self.contentOffset.y;
}
- (void)setTx_contentOffsetY:(CGFloat)y {
    self.contentOffset = CGPointMake(self.contentOffset.x, y);
}
//


- (CGPoint)tx_topContentOffset
{
    return CGPointMake(0.0f, -self.contentInset.top);
}
- (CGPoint)tx_bottomContentOffset
{
    return CGPointMake(0.0f, self.contentSize.height + self.contentInset.bottom - self.bounds.size.height);
}
- (CGPoint)tx_leftContentOffset
{
    return CGPointMake(-self.contentInset.left, 0.0f);
}
- (CGPoint)tx_rightContentOffset
{
    return CGPointMake(self.contentSize.width + self.contentInset.right - self.bounds.size.width, 0.0f);
}
- (TXScrollDirection)tx_ScrollDirection
{
    TXScrollDirection direction;
    
    if ([self.panGestureRecognizer translationInView:self.superview].y > 0.0f)
    {
        direction = TXScrollDirectionUp;
    }
    else if ([self.panGestureRecognizer translationInView:self.superview].y < 0.0f)
    {
        direction = TXScrollDirectionDown;
    }
    else if ([self.panGestureRecognizer translationInView:self].x < 0.0f)
    {
        direction = TXScrollDirectionLeft;
    }
    else if ([self.panGestureRecognizer translationInView:self].x > 0.0f)
    {
        direction = TXScrollDirectionRight;
    }
    else
    {
        direction = TXScrollDirectionWTF;
    }
    
    return direction;
}
- (BOOL)tx_isScrolledToTop
{
    return self.contentOffset.y <= [self tx_topContentOffset].y;
}
- (BOOL)tx_isScrolledToBottom
{
    return self.contentOffset.y >= [self tx_bottomContentOffset].y;
}
- (BOOL)tx_isScrolledToLeft
{
    return self.contentOffset.x <= [self tx_leftContentOffset].x;
}
- (BOOL)tx_isScrolledToRight
{
    return self.contentOffset.x >= [self tx_rightContentOffset].x;
}
- (void)tx_scrollToTopAnimated:(BOOL)animated
{
    [self setContentOffset:[self tx_topContentOffset] animated:animated];
}
- (void)tx_scrollToBottomAnimated:(BOOL)animated
{
    [self setContentOffset:[self tx_bottomContentOffset] animated:animated];
}
- (void)tx_scrollToLeftAnimated:(BOOL)animated
{
    [self setContentOffset:[self tx_leftContentOffset] animated:animated];
}
- (void)tx_scrollToRightAnimated:(BOOL)animated
{
    [self setContentOffset:[self tx_rightContentOffset] animated:animated];
}
- (NSUInteger)tx_verticalPageIndex
{
    return (self.contentOffset.y + (self.frame.size.height * 0.5f)) / self.frame.size.height;
}
- (NSUInteger)tx_horizontalPageIndex
{
    return (self.contentOffset.x + (self.frame.size.width * 0.5f)) / self.frame.size.width;
}
- (void)tx_scrollToVerticalPageIndex:(NSUInteger)pageIndex animated:(BOOL)animated
{
    [self setContentOffset:CGPointMake(0.0f, self.frame.size.height * pageIndex) animated:animated];
}
- (void)tx_scrollToHorizontalPageIndex:(NSUInteger)pageIndex animated:(BOOL)animated
{
    [self setContentOffset:CGPointMake(self.frame.size.width * pageIndex, 0.0f) animated:animated];
}


@end
