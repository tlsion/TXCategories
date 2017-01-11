//
//  UIViewController+StoreKit.m
//  Picks
//
//  Created by Joe Fabisevich on 8/12/14.
//  Copyright (c) 2014 Snarkbots. All rights reserved.
//

#import "UIViewController+TXStoreKit.h"

#import <objc/runtime.h>

#import <StoreKit/StoreKit.h>

////////////////////////////////////////////////////////////////////////////////
#pragma mark - Constants

NSString* const tx_affiliateTokenKey = @"at";
NSString* const tx_campaignTokenKey = @"ct";
NSString* const tx_iTunesAppleString = @"itunes.apple.com";

////////////////////////////////////////////////////////////////////////////////
#pragma mark - Interface

@interface UIViewController (SKStoreProductViewControllerDelegate) <SKStoreProductViewControllerDelegate>

@end

////////////////////////////////////////////////////////////////////////////////
#pragma mark - Implementation

@implementation UIViewController (TXStoreKit)

- (void)tx_presentStoreKitItemWithIdentifier:(NSInteger)itemIdentifier
{
    SKStoreProductViewController* storeViewController = [[SKStoreProductViewController alloc] init];
    storeViewController.delegate = self;

    NSString* campaignToken = self.tx_campaignToken ?: @"";

    NSDictionary* parameters = @{
        SKStoreProductParameterITunesItemIdentifier : @(itemIdentifier),
        tx_affiliateTokenKey : tx_affiliateTokenKey,
        tx_campaignTokenKey : campaignToken,
    };

    if (self.tx_loadingStoreKitItemBlock) {
        self.tx_loadingStoreKitItemBlock();
    }
    [storeViewController loadProductWithParameters:parameters completionBlock:^(BOOL result, NSError* error) {
        if (self.tx_loadedStoreKitItemBlock) {
            self.tx_loadedStoreKitItemBlock();
        }

        if (result && !error)
        {
            [self presentViewController:storeViewController animated:YES completion:nil];
        }
    }];
}

////////////////////////////////////////////////////////////////////////////////
#pragma mark - Delegation - SKStoreProductViewControllerDelegate

- (void)tx_productViewControllerDidFinish:(SKStoreProductViewController*)viewController
{
    [viewController dismissViewControllerAnimated:YES completion:nil];
}

////////////////////////////////////////////////////////////////////////////////
#pragma mark - Public methods

+ (NSURL*)tx_appURLForIdentifier:(NSInteger)identifier
{
    NSString* appURLString = [NSString stringWithFormat:@"https://itunes.apple.com/app/id%li", (long)identifier];
    return [NSURL URLWithString:appURLString];
}

+ (void)tx_openAppReviewURLForIdentifier:(NSInteger)identifier
{
    NSString* reviewURLString = [NSString stringWithFormat:@"itms-apps://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=%li", (long)identifier];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:reviewURLString]];
}

+ (void)tx_openAppURLForIdentifier:(NSInteger)identifier
{
    NSString* appURLString = [NSString stringWithFormat:@"itms-apps://itunes.apple.com/app/id%li", (long)identifier];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:appURLString]];
}

+ (BOOL)tx_containsITunesURLString:(NSString*)URLString
{
    return ([URLString rangeOfString:tx_iTunesAppleString].location != NSNotFound);
}

+ (NSInteger)tx_IDFromITunesURL:(NSString*)URLString
{
    NSError* error;
    NSRegularExpression* regex = [NSRegularExpression regularExpressionWithPattern:@"id\\d+" options:0 error:&error];
    NSTextCheckingResult* match = [regex firstMatchInString:URLString options:0 range:NSMakeRange(0, URLString.length)];

    NSString* idString = [URLString substringWithRange:match.range];
    if (idString.length > 0) {
        idString = [idString stringByReplacingOccurrencesOfString:@"id" withString:@""];
    }

    return [idString integerValue];
}

////////////////////////////////////////////////////////////////////////////////
#pragma mark - Associated objects

- (void)setTx_campaignToken:(NSString*)campaignToken
{
    objc_setAssociatedObject(self, @selector(setTx_campaignToken:), campaignToken, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSString*)tx_campaignToken
{
    return objc_getAssociatedObject(self, @selector(setTx_campaignToken:));
}

- (void)setTx_loadingStoreKitItemBlock:(void (^)(void))loadingStoreKitItemBlock
{
    objc_setAssociatedObject(self, @selector(setTx_loadingStoreKitItemBlock:), loadingStoreKitItemBlock, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void (^)(void))tx_loadingStoreKitItemBlock
{
    return objc_getAssociatedObject(self, @selector(setTx_loadingStoreKitItemBlock:));
}

- (void)setTx_loadedStoreKitItemBlock:(void (^)(void))loadedStoreKitItemBlock
{
    objc_setAssociatedObject(self, @selector(setTx_loadedStoreKitItemBlock:), loadedStoreKitItemBlock, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void (^)(void))tx_loadedStoreKitItemBlock
{
    return objc_getAssociatedObject(self, @selector(setTx_loadedStoreKitItemBlock:));
}

@end
