//
//  UIView+TXFind.m
//  TXCategories (https://github.com/tlsion/TXCategories)
//
//  Created by 王-庭协 on 2017/1/12.
//  Copyright © 2017年 ApeStar. All rights reserved.
//

#import "UIView+TXFind.h"

@implementation UIView (TXFind)
/**
 *  @brief  找到指定类名的view对象
 *
 *  @param clazz view类名
 *
 *  @return view对象
 */
- (id)tx_findSubViewWithSubViewClass:(Class)clazz
{
    for (id subView in self.subviews) {
        if ([subView isKindOfClass:clazz]) {
            return subView;
        }
    }
    
    return nil;
}
/**
 *  @brief  找到指定类名的SuperView对象
 *
 *  @param clazz SuperView类名
 *
 *  @return view对象
 */
- (id)tx_findSuperViewWithSuperViewClass:(Class)clazz
{
    if (self == nil) {
        return nil;
    } else if (self.superview == nil) {
        return nil;
    } else if ([self.superview isKindOfClass:clazz]) {
        return self.superview;
    } else {
        return [self.superview tx_findSuperViewWithSuperViewClass:clazz];
    }
}
/**
 *  @brief  找到并且resign第一响应者
 *
 *  @return 结果
 */
- (BOOL)tx_findAndResignFirstResponder {
    if (self.isFirstResponder) {
        [self resignFirstResponder];
        return YES;
    }
    
    for (UIView *v in self.subviews) {
        if ([v tx_findAndResignFirstResponder]) {
            return YES;
        }
    }
    
    return NO;
}
/**
 *  @brief  找到第一响应者
 *
 *  @return 第一响应者
 */
- (UIView *)tx_findFirstResponder {
    
    if (([self isKindOfClass:[UITextField class]] || [self isKindOfClass:[UITextView class]])
        && (self.isFirstResponder)) {
        return self;
    }
    
    for (UIView *v in self.subviews) {
        UIView *fv = [v tx_findFirstResponder];
        if (fv) {
            return fv;
        }
    }
    
    return nil;
}
/**
 *  @brief  找到当前view所在的viewcontroler
 */
- (UIViewController *)tx_viewController
{
    UIResponder *responder = self.nextResponder;
    do {
        if ([responder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)responder;
        }
        responder = responder.nextResponder;
    } while (responder);
    return nil;
}

@end
