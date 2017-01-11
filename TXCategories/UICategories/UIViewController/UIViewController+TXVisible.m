//
//  UIViewController+TXVisible.m
//  TXCategories (https://github.com/tlsion/TXCategories)
//
//  Created by 王-庭协 on 14/12/15.
//  Copyright (c) 2014年 www.skyfox.org. All rights reserved.
//

#import "UIViewController+TXVisible.h"

@implementation UIViewController (TXVisible)
- (BOOL)tx_isVisible {
    return [self isViewLoaded] && self.view.window;
}
@end
