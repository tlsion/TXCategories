//
//  UITextField+Blocks.h
//  TXCategories (https://github.com/tlsion/TXCategories)
//
//  Created by 王-庭协 on 14/12/15.
//  Copyright (c) 2014年 www.skyfox.org. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface UITextField (TXBlocks)
@property (copy, nonatomic) BOOL (^tx_shouldBegindEditingBlock)(UITextField *textField);
@property (copy, nonatomic) BOOL (^tx_shouldEndEditingBlock)(UITextField *textField);
@property (copy, nonatomic) void (^tx_didBeginEditingBlock)(UITextField *textField);
@property (copy, nonatomic) void (^tx_didEndEditingBlock)(UITextField *textField);
@property (copy, nonatomic) BOOL (^tx_shouldChangeCharactersInRangeBlock)(UITextField *textField, NSRange range, NSString *replacementString);
@property (copy, nonatomic) BOOL (^tx_shouldReturnBlock)(UITextField *textField);
@property (copy, nonatomic) BOOL (^tx_shouldClearBlock)(UITextField *textField);

- (void)setTx_shouldBegindEditingBlock:(BOOL (^)(UITextField *textField))shouldBegindEditingBlock;
- (void)setTx_shouldEndEditingBlock:(BOOL (^)(UITextField *textField))shouldEndEditingBlock;
- (void)setTx_didBeginEditingBlock:(void (^)(UITextField *textField))didBeginEditingBlock;
- (void)setTx_didEndEditingBlock:(void (^)(UITextField *textField))didEndEditingBlock;
- (void)setTx_shouldChangeCharactersInRangeBlock:(BOOL (^)(UITextField *textField, NSRange range, NSString *string))shouldChangeCharactersInRangeBlock;
- (void)setTx_shouldClearBlock:(BOOL (^)(UITextField *textField))shouldClearBlock;
- (void)setTx_shouldReturnBlock:(BOOL (^)(UITextField *textField))shouldReturnBlock;
@end
