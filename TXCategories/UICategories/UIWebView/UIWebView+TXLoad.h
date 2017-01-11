//
//  UIWebView+loadURL.h
//  TXCategories (https://github.com/tlsion/TXCategories)
//
//  Created by 王-庭协 on 14/12/15.
//  Copyright (c) 2014年 www.skyfox.org. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIWebView (TXLoad)
/**
 *  @brief  读取一个网页地址
 *
 *  @param URLString 网页地址
 */
- (void)tx_loadURL:(NSString*)URLString;
/**
 *  @brief  读取bundle中的webview
 *
 *  @param htmlName 文件名称 xxx.html
 */
- (void)tx_loadLocalHtml:(NSString*)htmlName;
/**
 *
 *  读取bundle中的webview
 *
 *  @param htmlName htmlName 文件名称 xxx.html
 *  @param inBundle bundle
 */
- (void)tx_loadLocalHtml:(NSString*)htmlName inBundle:(NSBundle*)inBundle;

/**
 *  @brief  清空cookie
 */
- (void)tx_clearCookies;
@end
