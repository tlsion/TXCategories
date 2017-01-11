//
//  UIViewController+StoreKit.h
//  Picks
//
//  Created by Joe Fabisevich on 8/12/14.
//  Copyright (c) 2014 Snarkbots. All rights reserved.
//  https://github.com/mergesort/UIViewController-StoreKit

#import <UIKit/UIKit.h>

////////////////////////////////////////////////////////////////////////////////
#pragma mark - Constants

#define affiliateToken @"10laQX"

////////////////////////////////////////////////////////////////////////////////
#pragma mark - Interface

@interface UIViewController (TXStoreKit)

@property NSString *tx_campaignToken;
@property (nonatomic, copy) void (^tx_loadingStoreKitItemBlock)(void);
@property (nonatomic, copy) void (^tx_loadedStoreKitItemBlock)(void);

- (void)tx_presentStoreKitItemWithIdentifier:(NSInteger)itemIdentifier;

+ (NSURL*)tx_appURLForIdentifier:(NSInteger)identifier;

+ (void)tx_openAppURLForIdentifier:(NSInteger)identifier;
+ (void)tx_openAppReviewURLForIdentifier:(NSInteger)identifier;

+ (BOOL)tx_containsITunesURLString:(NSString*)URLString;
+ (NSInteger)tx_IDFromITunesURL:(NSString*)URLString;

@end
