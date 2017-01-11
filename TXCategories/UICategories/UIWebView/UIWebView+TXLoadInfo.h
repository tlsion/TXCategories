//
//  UIWebView+TXLoadInfo.h
//  TXCategories (https://github.com/tlsion/TXCategories)
//
//  Created by 王-庭协 on 2016/12/9.
//  Copyright © 2017年 ApeStar. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSUInteger, TXReadyState) {
    TXReadyState_uninitialized = 0, //还未开始载入
    TXReadyState_loading,      //载入中
    TXReadyState_interactive, //已加载，文档与用户可以开始交互
    TXReadyState_complete    //载入完成

};
typedef void(^tx_webViewLoadChangeBlock)(UIWebView *webView,float progress,CGSize contentSize);

@interface UIWebView (TXLoadInfo)<UIWebViewDelegate>
@property (nonatomic, readonly) float tx_progress; // 0.0..1.0
@property (nonatomic, readonly) CGSize tx_contentSize;
@property (nonatomic, readonly) TXReadyState tx_readyState;
@property (copy, nonatomic)     tx_webViewLoadChangeBlock tx_webViewLoadChangeBlock;

-(void)setTx_webViewLoadChangeBlock:(tx_webViewLoadChangeBlock)tx_webViewLoadChangeBlock;
@end
