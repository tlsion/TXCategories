//
//  UITableViewCell+TS_delaysContentTouches.m
//  tableViewCellDelaysContentTouches
//
//  Created by Nicholas Hodapp on 1/31/14.
//  Copyright (c) 2014 Nicholas Hodapp. All rights reserved.
//

#import "UITableViewCell+TXDelaysContentTouches.h"

@implementation UITableViewCell (TXDelaysContentTouches)

- (UIScrollView*) tx_scrollView
{
    id sv = self.contentView.superview;
    while ( ![sv isKindOfClass: [UIScrollView class]] && sv != self )
    {
        sv = [sv superview];
    }
    
    return sv == self ? nil : sv;
}

- (void) setTx_delaysContentTouches:(BOOL)delaysContentTouches
{
    [self willChangeValueForKey: @"tx_delaysContentTouches"];
    
    [[self tx_scrollView] setDelaysContentTouches: delaysContentTouches];
    
    [self didChangeValueForKey: @"tx_delaysContentTouches"];
}

- (BOOL) tx_delaysContentTouches
{
    return [[self tx_scrollView] delaysContentTouches];
}



@end
