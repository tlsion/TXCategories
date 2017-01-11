//
//  UIWebView+Blocks.m
//
//  Created by Shai Mishali on 1/1/13.
//  Copyright (c) 2013 Shai Mishali. All rights reserved.
//

#import "UIWebView+TXBlocks.h"

static void (^__tx_loadedBlock)(UIWebView *webView);
static void (^__tx_failureBlock)(UIWebView *webView, NSError *error);
static void (^__tx_loadStartedBlock)(UIWebView *webView);
static BOOL (^__tx_shouldLoadBlock)(UIWebView *webView, NSURLRequest *request, UIWebViewNavigationType navigationType);

static uint __tx_loadedWebItems;

@implementation UIWebView (TXBlock)

#pragma mark - UIWebView+Blocks

+(UIWebView *)tx_loadRequest:(NSURLRequest *)request
                   loaded:(void (^)(UIWebView *webView))loadedBlock
                   failed:(void (^)(UIWebView *webView, NSError *error))failureBlock{

    return [self tx_loadRequest:request loaded:loadedBlock failed:failureBlock loadStarted:nil shouldLoad:nil];
}

+(UIWebView *)tx_loadHTMLString:(NSString *)htmlString
                      loaded:(void (^)(UIWebView *webView))loadedBlock
                      failed:(void (^)(UIWebView *webView, NSError *error))failureBlock{
    
    return [self tx_loadHTMLString:htmlString loaded:loadedBlock failed:failureBlock loadStarted:nil shouldLoad:nil];
}

+(UIWebView *)tx_loadHTMLString:(NSString *)htmlString
                      loaded:(void (^)(UIWebView *))loadedBlock
                      failed:(void (^)(UIWebView *, NSError *))failureBlock
                 loadStarted:(void (^)(UIWebView *webView))loadStartedBlock
                  shouldLoad:(BOOL (^)(UIWebView *webView, NSURLRequest *request, UIWebViewNavigationType navigationType))shouldLoadBlock{
    __tx_loadedWebItems = 0;
    __tx_loadedBlock = loadedBlock;
    __tx_failureBlock = failureBlock;
    __tx_loadStartedBlock = loadStartedBlock;
    __tx_shouldLoadBlock = shouldLoadBlock;
    
    UIWebView *webView = [[UIWebView alloc] init];
    webView.delegate = (id)[self class];
    [webView loadHTMLString:htmlString baseURL:nil];
    
    return webView;
}

+(UIWebView *)tx_loadRequest:(NSURLRequest *)request
                   loaded:(void (^)(UIWebView *webView))loadedBlock
                   failed:(void (^)(UIWebView *webView, NSError *error))failureBlock
              loadStarted:(void (^)(UIWebView *webView))loadStartedBlock
               shouldLoad:(BOOL (^)(UIWebView *webView, NSURLRequest *request, UIWebViewNavigationType navigationType))shouldLoadBlock{
    __tx_loadedWebItems    = 0;
    
    __tx_loadedBlock       = loadedBlock;
    __tx_failureBlock      = failureBlock;
    __tx_loadStartedBlock  = loadStartedBlock;
    __tx_shouldLoadBlock   = shouldLoadBlock;
    
    UIWebView *webView  = [[UIWebView alloc] init];
    webView.delegate    = (id) [self class];
    
    [webView loadRequest: request];
    
    return webView;
}

#pragma mark - Private Static delegate
+(void)webViewDidFinishLoad:(UIWebView *)webView{
    __tx_loadedWebItems--;
    
    if(__tx_loadedBlock && (!TRUE_END_REPORT || __tx_loadedWebItems == 0)){
        __tx_loadedWebItems = 0;
        __tx_loadedBlock(webView);
    }
}

+(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{    
    __tx_loadedWebItems--;
    
    if(__tx_failureBlock)
        __tx_failureBlock(webView, error);
}

+(void)webViewDidStartLoad:(UIWebView *)webView{    
    __tx_loadedWebItems++;
    
    if(__tx_loadStartedBlock && (!TRUE_END_REPORT || __tx_loadedWebItems > 0))
        __tx_loadStartedBlock(webView);
}

+(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    if(__tx_shouldLoadBlock)
        return __tx_shouldLoadBlock(webView, request, navigationType);
    
    return YES;
}

@end
