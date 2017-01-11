//
//  UIApplication+TXNetworkActivityIndicator.m
//  NetworkActivityIndicator
//
//  Created by Matt Zanchelli on 1/10/14.
//  Copyright (c) 2014 Matt Zanchelli. All rights reserved.
//

#import "UIApplication+TXNetworkActivityIndicator.h"

#import <libkern/OSAtomic.h>

@implementation UIApplication (TXNetworkActivityIndicator)

static volatile int32_t numberOfActiveNetworkConnectionsxxx;

#pragma mark Public API

- (void)tx_beganNetworkActivity
{
	self.networkActivityIndicatorVisible = OSAtomicAdd32(1, &numberOfActiveNetworkConnectionsxxx) > 0;
}

- (void)tx_endedNetworkActivity
{
	self.networkActivityIndicatorVisible = OSAtomicAdd32(-1, &numberOfActiveNetworkConnectionsxxx) > 0;
}

@end
