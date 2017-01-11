//
//  GON_NSIndexPath+Offset.m
//
//  Created by Nicolas Goutaland on 04/04/15.
//  Copyright 2015 Nicolas Goutaland. All rights reserved.
//

#import "NSIndexPath+TXOffset.h"

@interface NSIndexPath ()
@end

@implementation NSIndexPath (TXOffset)
#pragma mark - Offset
- (NSIndexPath *)tx_previousRow
{
    return [NSIndexPath indexPathForRow:self.row - 1
                              inSection:self.section];
}

- (NSIndexPath *)tx_nextRow
{
    return [NSIndexPath indexPathForRow:self.row + 1
                              inSection:self.section];
}

- (NSIndexPath *)tx_previousItem
{
    return [NSIndexPath indexPathForItem:self.item - 1
                               inSection:self.section];
}


- (NSIndexPath *)tx_nextItem
{
    return [NSIndexPath indexPathForItem:self.item + 1
                               inSection:self.section];
}


- (NSIndexPath *)tx_nextSection
{
    return [NSIndexPath indexPathForRow:self.row
                              inSection:self.section + 1];
}

- (NSIndexPath *)tx_previousSection
{
    return [NSIndexPath indexPathForRow:self.row
                              inSection:self.section - 1];
}

@end
