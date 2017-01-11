//
//  UIWindow+TXHierarchy.m
//  TXCategories (https://github.com/tlsion/TXCategories)
//
//  Created by 王-庭协 on 15/1/16.
//  Copyright (c) 2015年 www.skyfox.org. All rights reserved.
//

#import "UIWindow+TXHierarchy.h"

@implementation UIWindow (TXHierarchy)
- (UIViewController*)tx_topMostController
{
    UIViewController *topController = [self rootViewController];
    
    //  Getting topMost ViewController
    while ([topController presentedViewController])	topController = [topController presentedViewController];
    
    //  Returning topMost ViewController
    return topController;
}

- (UIViewController*)tx_currentViewController;
{
    UIViewController *currentViewController = [self tx_topMostController];
    
    while ([currentViewController isKindOfClass:[UINavigationController class]] && [(UINavigationController*)currentViewController topViewController])
        currentViewController = [(UINavigationController*)currentViewController topViewController];
    
    return currentViewController;
}
@end
