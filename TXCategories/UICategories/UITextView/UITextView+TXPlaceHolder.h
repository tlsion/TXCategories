//
//  UITextView+PlaceHolder.h
//  TXCategories (https://github.com/tlsion/TXCategories)
//
//  Created by 王-庭协 on 14/12/15.
//  Copyright (c) 2014年 www.skyfox.org. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <objc/runtime.h>
@interface UITextView (TXPlaceHolder) <UITextViewDelegate>
@property (nonatomic, strong) UITextView *tx_placeHolderTextView;
- (void)tx_addPlaceHolder:(NSString *)placeHolder;
@end
