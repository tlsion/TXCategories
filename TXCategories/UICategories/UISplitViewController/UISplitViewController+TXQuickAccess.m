//
//  UISplitViewController+TXQuickAccess.m
//  TXCategories (https://github.com/tlsion/TXCategories)
//
//  Created by 王-庭协 on 15/5/22.
//  Copyright (c) 2015年 www.skyfox.org. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "UISplitViewController+TXQuickAccess.h"

@implementation UISplitViewController (TXQuickAccess)

- (UIViewController *)tx_leftController {
    UIViewController * leftVC = [[self viewControllers] objectAtIndex:0];
    
    if ([leftVC isKindOfClass:[UINavigationController class]]) {
        leftVC = [(UINavigationController *)leftVC topViewController];
    }
    return  leftVC;
}

- (UIViewController *)tx_rightController {
    UIViewController * rightVC = [[self viewControllers] lastObject];
    
    if ([rightVC isKindOfClass:[UINavigationController class]]) {
        rightVC = [(UINavigationController *)rightVC topViewController];
    }
    return rightVC;
}

@end
