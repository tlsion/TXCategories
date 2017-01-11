//
//  UIAlertView+Block.h
//  TXCategories (https://github.com/tlsion/TXCategories)
//
//  Created by 符现超 on 15/5/9.
//  Copyright (c) 2015年 http://weibo.com/u/1655766025 All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^UIAlertViewTXCallBackBlock)(NSInteger buttonIndex);

@interface UIAlertView (TXBlock)<UIAlertViewDelegate>

@property (nonatomic, copy) UIAlertViewTXCallBackBlock tx_alertViewCallBackBlock;

+ (void)tx_alertWithCallBackBlock:(UIAlertViewTXCallBackBlock)alertViewCallBackBlock
                            title:(NSString *)title message:(NSString *)message  cancelButtonName:(NSString *)cancelButtonName
                otherButtonTitles:(NSString *)otherButtonTitles, ...NS_REQUIRES_NIL_TERMINATION;

@end
