//
//  NSIndexPath+Offset.h
//
//  Created by Nicolas Goutaland on 04/04/15.
//  Copyright 2015 Nicolas Goutaland. All rights reserved.
//
#import <UIKit/UIKit.h>
@interface NSIndexPath (TXOffset)
/**
 *  @author TXCategories
 *
 *  Compute previous row indexpath
 *
 */
- (NSIndexPath *)tx_previousRow;
/**
 *  @author TXCategories
 *
 *  Compute next row indexpath
 *
 */
- (NSIndexPath *)tx_nextRow;
/**
 *  @author TXCategories
 *
 *  Compute previous item indexpath
 *
 */
- (NSIndexPath *)tx_previousItem;
/**
 *  @author TXCategories
 *
 *  Compute next item indexpath
 *
 */
- (NSIndexPath *)tx_nextItem;
/**
 *  @author TXCategories
 *
 *  Compute next section indexpath
 *
 */
- (NSIndexPath *)tx_nextSection;
/**
 *  @author TXCategories
 *
 *  Compute previous section indexpath
 *
 */
- (NSIndexPath *)tx_previousSection;

@end
