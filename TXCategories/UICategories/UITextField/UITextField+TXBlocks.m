//
// UITextField+Blocks.m
// UITextFieldBlocks
//
// Created by Håkon Bogen on 19.10.13.
// Copyright (c) 2013 Håkon Bogen. All rights reserved.
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.
#import "UITextField+TXBlocks.h"
#import <objc/runtime.h>
typedef BOOL (^TXUITextFieldReturnBlock) (UITextField *textField);
typedef void (^TXUITextFieldVoidBlock) (UITextField *textField);
typedef BOOL (^TXUITextFieldCharacterChangeBlock) (UITextField *textField, NSRange range, NSString *replacementString);
@implementation UITextField (TXBlocks)
static const void *TXUITextFieldDelegateKey = &TXUITextFieldDelegateKey;
static const void *TXUITextFieldShouldBeginEditingKey = &TXUITextFieldShouldBeginEditingKey;
static const void *TXUITextFieldShouldEndEditingKey = &TXUITextFieldShouldEndEditingKey;
static const void *TXUITextFieldDidBeginEditingKey = &TXUITextFieldDidBeginEditingKey;
static const void *TXUITextFieldDidEndEditingKey = &TXUITextFieldDidEndEditingKey;
static const void *TXUITextFieldShouldChangeCharactersInRangeKey = &TXUITextFieldShouldChangeCharactersInRangeKey;
static const void *TXUITextFieldShouldClearKey = &TXUITextFieldShouldClearKey;
static const void *TXUITextFieldShouldReturnKey = &TXUITextFieldShouldReturnKey;
#pragma mark UITextField Delegate methods
+ (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    TXUITextFieldReturnBlock block = textField.tx_shouldBegindEditingBlock;
    if (block) {
        return block(textField);
    }
    id delegate = objc_getAssociatedObject(self, TXUITextFieldDelegateKey);
    if ([delegate respondsToSelector:@selector(textFieldShouldBeginEditing:)]) {
        return [delegate textFieldShouldBeginEditing:textField];
    }
    // return default value just in case
    return YES;
}
+ (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    TXUITextFieldReturnBlock block = textField.tx_shouldEndEditingBlock;
    if (block) {
        return block(textField);
    }
    id delegate = objc_getAssociatedObject(self, TXUITextFieldDelegateKey);
    if ([delegate respondsToSelector:@selector(textFieldShouldEndEditing:)]) {
        return [delegate textFieldShouldEndEditing:textField];
    }
    // return default value just in case
    return YES;
}
+ (void)textFieldDidBeginEditing:(UITextField *)textField
{
   TXUITextFieldVoidBlock block = textField.tx_didBeginEditingBlock;
    if (block) {
        block(textField);
    }
    id delegate = objc_getAssociatedObject(self, TXUITextFieldDelegateKey);
    if ([delegate respondsToSelector:@selector(textFieldDidBeginEditing:)]) {
        [delegate textFieldDidBeginEditing:textField];
    }
}
+ (void)textFieldDidEndEditing:(UITextField *)textField
{
    TXUITextFieldVoidBlock block = textField.tx_didEndEditingBlock;
    if (block) {
        block(textField);
    }
    id delegate = objc_getAssociatedObject(self, TXUITextFieldDelegateKey);
    if ([delegate respondsToSelector:@selector(textFieldDidEndEditing:)]) {
        [delegate textFieldDidBeginEditing:textField];
    }
}
+ (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    TXUITextFieldCharacterChangeBlock block = textField.tx_shouldChangeCharactersInRangeBlock;
    if (block) {
        return block(textField,range,string);
    }
    id delegate = objc_getAssociatedObject(self, TXUITextFieldDelegateKey);
    if ([delegate respondsToSelector:@selector(textField:shouldChangeCharactersInRange:replacementString:)]) {
        return [delegate textField:textField shouldChangeCharactersInRange:range replacementString:string];
    }
    return YES;
}
+ (BOOL)textFieldShouldClear:(UITextField *)textField
{
    TXUITextFieldReturnBlock block = textField.tx_shouldClearBlock;
    if (block) {
        return block(textField);
    }
    id delegate = objc_getAssociatedObject(self, TXUITextFieldDelegateKey);
    if ([delegate respondsToSelector:@selector(textFieldShouldClear:)]) {
        return [delegate textFieldShouldClear:textField];
    }
    return YES;
}
+ (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    TXUITextFieldReturnBlock block = textField.tx_shouldReturnBlock;
    if (block) {
        return block(textField);
    }
    id delegate = objc_getAssociatedObject(self, TXUITextFieldDelegateKey);
    if ([delegate respondsToSelector:@selector(textFieldShouldReturn:)]) {
        return [delegate textFieldShouldReturn:textField];
    }
    return YES;
}
#pragma mark Block setting/getting methods
- (BOOL (^)(UITextField *))tx_shouldBegindEditingBlock
{
    return objc_getAssociatedObject(self, TXUITextFieldShouldBeginEditingKey);
}
- (void)setTx_shouldBegindEditingBlock:(BOOL (^)(UITextField *))shouldBegindEditingBlock
{
    [self tx_setDelegateIfNoDelegateSet];
    objc_setAssociatedObject(self, TXUITextFieldShouldBeginEditingKey, shouldBegindEditingBlock, OBJC_ASSOCIATION_COPY);
}
- (BOOL (^)(UITextField *))tx_shouldEndEditingBlock
{
    return objc_getAssociatedObject(self, TXUITextFieldShouldEndEditingKey);
}
- (void)setTx_shouldEndEditingBlock:(BOOL (^)(UITextField *))shouldEndEditingBlock
{
    [self tx_setDelegateIfNoDelegateSet];
    objc_setAssociatedObject(self, TXUITextFieldShouldEndEditingKey, shouldEndEditingBlock, OBJC_ASSOCIATION_COPY);
}
- (void (^)(UITextField *))tx_didBeginEditingBlock
{
    return objc_getAssociatedObject(self, TXUITextFieldDidBeginEditingKey);
}
- (void)setTx_didBeginEditingBlock:(void (^)(UITextField *))didBeginEditingBlock
{
    [self tx_setDelegateIfNoDelegateSet];
    objc_setAssociatedObject(self, TXUITextFieldDidBeginEditingKey, didBeginEditingBlock, OBJC_ASSOCIATION_COPY);
}
- (void (^)(UITextField *))tx_didEndEditingBlock
{
    return objc_getAssociatedObject(self, TXUITextFieldDidEndEditingKey);
}
- (void)setTx_didEndEditingBlock:(void (^)(UITextField *))didEndEditingBlock
{
    [self tx_setDelegateIfNoDelegateSet];
    objc_setAssociatedObject(self, TXUITextFieldDidEndEditingKey, didEndEditingBlock, OBJC_ASSOCIATION_COPY);
}
- (BOOL (^)(UITextField *, NSRange, NSString *))tx_shouldChangeCharactersInRangeBlock
{
    return objc_getAssociatedObject(self, TXUITextFieldShouldChangeCharactersInRangeKey);
}
- (void)setTx_shouldChangeCharactersInRangeBlock:(BOOL (^)(UITextField *, NSRange, NSString *))shouldChangeCharactersInRangeBlock
{
    [self tx_setDelegateIfNoDelegateSet];
    objc_setAssociatedObject(self, TXUITextFieldShouldChangeCharactersInRangeKey, shouldChangeCharactersInRangeBlock, OBJC_ASSOCIATION_COPY);
}
- (BOOL (^)(UITextField *))tx_shouldReturnBlock
{
    return objc_getAssociatedObject(self, TXUITextFieldShouldReturnKey);
}
- (void)setTx_shouldReturnBlock:(BOOL (^)(UITextField *))shouldReturnBlock
{
    [self tx_setDelegateIfNoDelegateSet];
    objc_setAssociatedObject(self, TXUITextFieldShouldReturnKey, shouldReturnBlock, OBJC_ASSOCIATION_COPY);
}
- (BOOL (^)(UITextField *))tx_shouldClearBlock
{
    return objc_getAssociatedObject(self, TXUITextFieldShouldClearKey);
}
- (void)setTx_shouldClearBlock:(BOOL (^)(UITextField *textField))shouldClearBlock
{
    [self tx_setDelegateIfNoDelegateSet];
    objc_setAssociatedObject(self, TXUITextFieldShouldClearKey, shouldClearBlock, OBJC_ASSOCIATION_COPY);
}
#pragma mark control method
/*
 Setting itself as delegate if no other delegate has been set. This ensures the UITextField will use blocks if no delegate is set.
 */
- (void)tx_setDelegateIfNoDelegateSet
{
    if (self.delegate != (id<UITextFieldDelegate>)[self class]) {
        objc_setAssociatedObject(self, TXUITextFieldDelegateKey, self.delegate, OBJC_ASSOCIATION_ASSIGN);
        self.delegate = (id<UITextFieldDelegate>)[self class];
    }
}
@end
