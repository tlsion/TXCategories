//
//  UIViewController+BackButtonTouched.h
//  TXCategories (https://github.com/tlsion/TXCategories)
//
//  Created by 王-庭协 on 14/12/30.
//  Copyright (c) 2014年 www.skyfox.org. All rights reserved.
//

#import "UIViewController+TXBackButtonTouched.h"
#import <objc/runtime.h>
static const void *TXBackButtonHandlerKey = &TXBackButtonHandlerKey;

@implementation UIViewController (TXBackButtonTouched)
-(void)tx_backButtonTouched:(TXBackButtonHandler)backButtonHandler{
    objc_setAssociatedObject(self, TXBackButtonHandlerKey, backButtonHandler, OBJC_ASSOCIATION_COPY);
}
- (TXBackButtonHandler)tx_backButtonTouched
{
    return objc_getAssociatedObject(self, TXBackButtonHandlerKey);
}
@end

@implementation UINavigationController (ShouldPopItem)
- (BOOL)navigationBar:(UINavigationBar *)navigationBar shouldPopItem:(UINavigationItem *)item {

	if([self.viewControllers count] < [navigationBar.items count]) {
		return YES;
	}

   	UIViewController* vc = [self topViewController];
    TXBackButtonHandler handler = [vc tx_backButtonTouched];
    if (handler) {
        // Workaround for iOS7.1. Thanks to @boliva - http://stackoverflow.com/posts/comments/34452906

        for(UIView *subview in [navigationBar subviews]) {
            if(subview.alpha < 1.) {
                [UIView animateWithDuration:.25 animations:^{
                    subview.alpha = 1.;
                }];
            }
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            handler(self);
        });
    }else{
        dispatch_async(dispatch_get_main_queue(), ^{
            [self popViewControllerAnimated:YES];
        });
    }

	return NO;
}
@end
