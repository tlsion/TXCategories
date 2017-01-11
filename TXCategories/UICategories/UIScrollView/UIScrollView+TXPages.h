//
//  UIScrollView+TXPages.h
//  TXCategories (https://github.com/tlsion/TXCategories)
//
//  Created by 王-庭协 on 14/12/30.
//  Copyright (c) 2014年 www.skyfox.org. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIScrollView (TXPages)
- (NSInteger)tx_pages;
- (NSInteger)tx_currentPage;
- (CGFloat)tx_scrollPercent;

- (CGFloat)tx_pagesY;
- (CGFloat)tx_pagesX;
- (CGFloat)tx_currentPageY;
- (CGFloat)tx_currentPageX;
- (void)tx_setPageY:(CGFloat)page;
- (void)tx_setPageX:(CGFloat)page;
- (void)tx_setPageY:(CGFloat)page animated:(BOOL)animated;
- (void)tx_setPageX:(CGFloat)page animated:(BOOL)animated;
@end
