//
//  UIResponder+TXChain.h
//  TXCategories (https://github.com/tlsion/TXCategories)
//
//  Created by 王-庭协 on 14/12/30.
//  Copyright (c) 2014年 www.skyfox.org. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIResponder (TXChain)
/**
 *  @brief  响应者链
 *
 *  @return  响应者链
 */
- (NSString *)tx_responderChainDescription;
@end
