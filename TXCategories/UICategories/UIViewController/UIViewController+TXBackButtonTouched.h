//
//  UIViewController+BackButtonTouched.h
//  TXCategories (https://github.com/tlsion/TXCategories)
//
//  Created by 王-庭协 on 14/12/30.
//  Copyright (c) 2014年 www.skyfox.org. All rights reserved.
//
#import <UIKit/UIKit.h>
typedef void (^TXBackButtonHandler)(UIViewController *vc);
@interface UIViewController (TXBackButtonTouched)
/**
 *  @author TXCategories
 *
 *  navgation 返回按钮回调
 *
 *  @param backButtonHandler <#backButtonHandler description#>
 */
-(void)tx_backButtonTouched:(TXBackButtonHandler)backButtonHandler;
@end
