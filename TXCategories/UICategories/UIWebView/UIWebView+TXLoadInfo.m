//
//  UIWebView+TXLoadStatus.m
//  TXCategories (https://github.com/tlsion/TXCategories)
//
//  Created by 王-庭协 on 2016/12/9.
//  Copyright © 2017年 ApeStar. All rights reserved.
//

#import "UIWebView+TXLoadInfo.h"
#import <objc/runtime.h>

static const void *k_tx_loadingCount = &k_tx_loadingCount;
static const void *k_tx_maxLoadCount = &k_tx_maxLoadCount;
static const void *k_tx_currentURL = &k_tx_currentURL;
static const void *k_tx_interactive = &k_tx_interactive;
static const void *k_tx_progress = &k_tx_progress;
static const void *k_tx_contentSize = &k_tx_contentSize;

static const void *k_tx_readyState = &k_tx_readyState;

static const void *k_tx_realDelegate = &k_tx_realDelegate;
static const void *k_tx_webViewLoadChangeBlock = &k_tx_webViewLoadChangeBlock;


NSString *tx_completeRPCURLPath = @"/TXwebviewprogressproxy/complete";

@implementation UIWebView (TXLoadStatus)
-(void)setTx_loadingCount:(NSUInteger)tx_loadingCount{
    NSNumber *number = [[NSNumber alloc]initWithInteger:tx_loadingCount];
    objc_setAssociatedObject(self,k_tx_loadingCount, number, OBJC_ASSOCIATION_ASSIGN);
}

-(NSUInteger)tx_loadingCount{
    return [objc_getAssociatedObject(self, k_tx_loadingCount) integerValue];
}

-(void)setTx_maxLoadCount:(NSUInteger)tx_maxLoadCount{
    NSNumber *number = [[NSNumber alloc]initWithInteger:tx_maxLoadCount];
    objc_setAssociatedObject(self,k_tx_maxLoadCount, number, OBJC_ASSOCIATION_ASSIGN);
}

-(NSUInteger)tx_maxLoadCount{
    return [objc_getAssociatedObject(self, k_tx_maxLoadCount) integerValue];
}

-(void)setTx_currentURL:(NSURL*)tx_currentURL{
    objc_setAssociatedObject(self,k_tx_currentURL, tx_currentURL, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(NSURL*)tx_currentURL{
    return objc_getAssociatedObject(self, k_tx_currentURL) ;
}

-(void)setTx_interactive:(BOOL)tx_interactive{
    NSNumber *number = [[NSNumber alloc]initWithBool:tx_interactive];
    objc_setAssociatedObject(self,k_tx_interactive, number, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(BOOL)tx_interactive{
    return [objc_getAssociatedObject(self, k_tx_interactive) boolValue];
}

-(void)setTx_progress:(float)tx_progress{
    NSNumber *number = [[NSNumber alloc]initWithFloat:tx_progress];
    objc_setAssociatedObject(self,k_tx_progress, number, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(BOOL)tx_progress{
    return [objc_getAssociatedObject(self, k_tx_progress) floatValue];
}

-(void)setTx_contentSize:(CGSize)tx_contentSize{
    objc_setAssociatedObject(self,k_tx_progress, NSStringFromCGSize(tx_contentSize), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(CGSize)tx_contentSize{
    return CGSizeFromString(objc_getAssociatedObject(self, k_tx_progress));
}

-(void)setTx_readyState:(TXReadyState)tx_readyState{
    objc_setAssociatedObject(self,k_tx_readyState, @(tx_readyState), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(TXReadyState)tx_readyState{
    return (TXReadyState)[objc_getAssociatedObject(self, k_tx_readyState) integerValue];
}

-(void)setTx_realDelegate:(id<UIWebViewDelegate>)tx_realDelegate{
    objc_setAssociatedObject(self,k_tx_realDelegate, tx_realDelegate, OBJC_ASSOCIATION_ASSIGN);
}

-(id<UIWebViewDelegate>)tx_realDelegate{
    return objc_getAssociatedObject(self, k_tx_realDelegate);
}

-(void (^)(UIWebView *, float))tx_webViewLoadChangeBlock{
    return objc_getAssociatedObject(self, k_tx_webViewLoadChangeBlock);
}

- (void)setTx_webViewLoadChangeBlock:(tx_webViewLoadChangeBlock)tx_webViewLoadChangeBlock
{
    [self tx_setDelegateIfNoDelegateSet];
    objc_setAssociatedObject(self, k_tx_webViewLoadChangeBlock, tx_webViewLoadChangeBlock, OBJC_ASSOCIATION_COPY);
}

#pragma mark --delegate

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    if ([request.URL.path isEqualToString:tx_completeRPCURLPath]) {
        [self tx_completeProgress];
        return NO;
    }
    
    BOOL ret = YES;
    if ([self.tx_realDelegate respondsToSelector:@selector(webView:shouldStartLoadWithRequest:navigationType:)]) {
        ret = [self.tx_realDelegate webView:webView shouldStartLoadWithRequest:request navigationType:navigationType];
    }
    
    BOOL isFragmentJump = NO;
    if (request.URL.fragment) {
        NSString *nonFragmentURL = [request.URL.absoluteString stringByReplacingOccurrencesOfString:[@"#" stringByAppendingString:request.URL.fragment] withString:@""];
        isFragmentJump = [nonFragmentURL isEqualToString:webView.request.URL.absoluteString];
    }
    
    BOOL isTopLevelNavigation = [request.mainDocumentURL isEqual:request.URL];
    
    BOOL isHTTPOrLocalFile = [request.URL.scheme isEqualToString:@"http"] || [request.URL.scheme isEqualToString:@"https"] || [request.URL.scheme isEqualToString:@"file"];
    if (ret && !isFragmentJump && isHTTPOrLocalFile && isTopLevelNavigation) {
        self.tx_currentURL = request.URL;
        [self tx_reset];
    }
    return ret;
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    self.tx_readyState = TXReadyState_loading;

    if ([self.tx_realDelegate respondsToSelector:@selector(webViewDidStartLoad:)]) {
        [self.tx_realDelegate webViewDidStartLoad:webView];
    }
    
    self.tx_loadingCount++;
    self.tx_maxLoadCount = fmax(self.tx_maxLoadCount, self.tx_loadingCount);
    [self tx_startProgress];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    if ([self.tx_realDelegate respondsToSelector:@selector(webViewDidFinishLoad:)]) {
        [self.tx_realDelegate webViewDidFinishLoad:webView];
    }
   
    self.tx_loadingCount--;
    [self tx_incrementProgress];
    
    NSString *readyState = [webView stringByEvaluatingJavaScriptFromString:@"document.readyState"];
    
    BOOL interactive = [readyState isEqualToString:@"interactive"];
    if (interactive) {
        self.tx_interactive = YES;
        self.tx_readyState = TXReadyState_interactive;
        
        NSString *waitForCompleteJS = [NSString stringWithFormat:@"window.addEventListener('load',function() { var iframe = document.createElement('iframe'); iframe.style.display = 'none'; iframe.src = '%@://%@%@'; document.body.appendChild(iframe);  }, false);", webView.request.mainDocumentURL.scheme, webView.request.mainDocumentURL.host, tx_completeRPCURLPath];
        [webView stringByEvaluatingJavaScriptFromString:waitForCompleteJS];
    }
    
    BOOL isNotRedirect = self.tx_currentURL && [self.tx_currentURL isEqual:webView.request.mainDocumentURL];
    BOOL complete = [readyState isEqualToString:@"complete"];
    if (complete && isNotRedirect) {
        [self tx_completeProgress];
    }
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    if ([self.tx_realDelegate respondsToSelector:@selector(webView:didFailLoadWithError:)]) {
        [self.tx_realDelegate webView:webView didFailLoadWithError:error];
    }
    
    self.tx_loadingCount--;
    [self tx_incrementProgress];
    
    NSString *readyState = [webView stringByEvaluatingJavaScriptFromString:@"document.readyState"];
    
    BOOL interactive = [readyState isEqualToString:@"interactive"];
    if (interactive) {
        self.tx_interactive = YES;
        NSString *waitForCompleteJS = [NSString stringWithFormat:@"window.addEventListener('load',function() { var iframe = document.createElement('iframe'); iframe.style.display = 'none'; iframe.src = '%@://%@%@'; document.body.appendChild(iframe);  }, false);", webView.request.mainDocumentURL.scheme, webView.request.mainDocumentURL.host, tx_completeRPCURLPath];
        [webView stringByEvaluatingJavaScriptFromString:waitForCompleteJS];
    }
    
    BOOL isNotRedirect = self.tx_currentURL && [self.tx_currentURL isEqual:webView.request.mainDocumentURL];
    BOOL complete = [readyState isEqualToString:@"complete"];
    if ((complete && isNotRedirect) || error) {
        [self tx_completeProgress];
    }
}

- (void)tx_startProgress
{
    if (self.tx_progress < 0.1) {
        [self tx_updateProgress:0.1];
    }
}
- (void)tx_incrementProgress
{
    float progress = self.tx_progress;
    float maxProgress = self.tx_interactive ? 0.9 : 0.5f;
    float remainPercent = (float)self.tx_loadingCount / (float)self.tx_maxLoadCount;
    float increment = (maxProgress - progress) * remainPercent;
    progress += increment;
    progress = fmin(progress, maxProgress);
    [self tx_updateProgress:progress];
}

- (void)tx_completeProgress
{
    self.tx_readyState = TXReadyState_complete;
    [self tx_updateProgress:1.0];
//    CGFloat webViewHeight= [[self stringByEvaluatingJavaScriptFromString: @"document.body.offsetHeight"]floatValue];
//    NSLog(@"body.offsetHeight:%lf",webViewHeight);
//    
//    CGFloat webViewHeight2=self.scrollView.contentSize.height;
//    NSLog(@"scrollView contentSize:%lf",webViewHeight2);
}

- (void)tx_updateProgress:(float)progress
{
    if (progress > self.tx_progress || progress == 0) {
        self.tx_progress = progress;
        if (self.tx_webViewLoadChangeBlock) {
           self.tx_webViewLoadChangeBlock(self,progress,self.scrollView.contentSize);
        }
    }
}
- (void)tx_reset
{
    self.tx_maxLoadCount = self.tx_loadingCount = 0;
    self.tx_interactive = NO;
    [self tx_updateProgress:0.0];
    self.tx_readyState = TXReadyState_uninitialized;
}
//会影响未包含头文件的webview
//-(void)awakeFromNib{
//    [super awakeFromNib];
//    [self tx_setDelegateIfNoDelegateSet];
//}
//
//- (instancetype)initWithFrame:(CGRect)frame
//{
//    self = [super initWithFrame:frame];
//    if (self) {
//        [self tx_setDelegateIfNoDelegateSet];
//    }
//    return self;
//}
#pragma mark - Delegate Forwarder
- (void)tx_setDelegateIfNoDelegateSet
{
    if (self.delegate != (id<UIWebViewDelegate>)self) {
        self.tx_realDelegate  = self.delegate;
        self.delegate = (id<UIWebViewDelegate>)self;
    }
}


//- (void)setDelegate:(id<UIWebViewDelegate>)delegate {
//    
//    if ([[[UIDevice currentDevice] systemVersion] floatValue]>=7.0){
//        // UIScrollView delegate keeps some flags that mark whether the delegate implements some methods (like scrollViewDidScroll:)
//        // setting *the same* delegate doesn't recheck the flags, so it's better to simply nil the previous delegate out
//        // we have to setup the realDelegate at first, since the flag check happens in setter
////        [super setDelegate:nil];
////        self.delegate = nil;
//        self.tx_realDelegate = delegate != self ? delegate : nil;
////        [super setDelegate:delegate ? self : nil];
//        self.delegate = delegate ? self : nil;
//        
//    }else {
////        [super setDelegate:delegate];
////        self.delegate = delegate;
//
//    }
//}

//- (BOOL)respondsToSelector:(SEL)selector {
//    return [super respondsToSelector:selector] || [self.tx_realDelegate respondsToSelector:selector];
//}
//- (id)forwardingTargetForSelector:(SEL)selector {
//    id delegate = self.tx_realDelegate;
//    return [delegate respondsToSelector:selector] ? delegate : [super forwardingTargetForSelector:selector];
//}
@end
