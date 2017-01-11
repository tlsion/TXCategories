//
//  UITextField+TXInputLimit.m
//  TXCategories (https://github.com/tlsion/TXCategories)
//
//  Created by 王-庭协 on 2016/11/29.
//  Copyright © 2017年 ApeStar. All rights reserved.
//

#import "UITextField+TXInputLimit.h"
#import <objc/runtime.h>

static const void *TXTextFieldInputLimitMaxLength = &TXTextFieldInputLimitMaxLength;
@implementation UITextField (TXInputLimit)

- (NSInteger)tx_maxLength {
    return [objc_getAssociatedObject(self, TXTextFieldInputLimitMaxLength) integerValue];
}
- (void)setTx_maxLength:(NSInteger)maxLength {
    objc_setAssociatedObject(self, TXTextFieldInputLimitMaxLength, @(maxLength), OBJC_ASSOCIATION_ASSIGN);
    [self addTarget:self action:@selector(tx_textFieldTextDidChange) forControlEvents:UIControlEventEditingChanged];
}
- (void)tx_textFieldTextDidChange {
    NSString *toBeString = self.text;
    //获取高亮部分
    UITextRange *selectedRange = [self markedTextRange];
    UITextPosition *position = [self positionFromPosition:selectedRange.start offset:0];
    
    //没有高亮选择的字，则对已输入的文字进行字数统计和限制
    //在iOS7下,position对象总是不为nil
    if ( (!position ||!selectedRange) && (self.tx_maxLength > 0 && toBeString.length > self.tx_maxLength))
    {
        NSRange rangeIndex = [toBeString rangeOfComposedCharacterSequenceAtIndex:self.tx_maxLength];
        if (rangeIndex.length == 1)
        {
            self.text = [toBeString substringToIndex:self.tx_maxLength];
        }
        else
        {
            NSRange rangeRange = [toBeString rangeOfComposedCharacterSequencesForRange:NSMakeRange(0, self.tx_maxLength)];
            NSInteger tmpLength;
            if (rangeRange.length > self.tx_maxLength) {
                tmpLength = rangeRange.length - rangeIndex.length;
            }else{
                tmpLength = rangeRange.length;
            }
            self.text = [toBeString substringWithRange:NSMakeRange(0, tmpLength)];
        }
    }
}
@end
