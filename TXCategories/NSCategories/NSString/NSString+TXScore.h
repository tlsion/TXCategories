//
//  NSString+TXScore.h
//
//  Created by Nicholas Bruning on 5/12/11.
//  Copyright (c) 2011 Involved Pty Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_OPTIONS(NSUInteger, NSStringTXScoreOption) {
    NSStringTXScoreOptionNone = 1 << 0,
    NSStringTXScoreOptionFavorSmallerWords = 1 << 1,
    NSStringTXScoreOptionReducedLongStringPenalty = 1 << 2
};

//模糊匹配字符串 查找某两个字符串的相似程度
@interface NSString (TXScore)

- (CGFloat)tx_scoreAgainst:(NSString *)otherString;
- (CGFloat)tx_scoreAgainst:(NSString *)otherString fuzziness:(NSNumber *)fuzziness;
- (CGFloat)tx_scoreAgainst:(NSString *)otherString fuzziness:(NSNumber *)fuzziness options:(NSStringTXScoreOption)options;

@end
