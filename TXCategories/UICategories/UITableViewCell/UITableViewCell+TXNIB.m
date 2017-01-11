//
//  UITableViewCell+NIB.m
//  TXCategories (https://github.com/tlsion/TXCategories)
//
//  Created by 王-庭协 on 14/11/19.
//  Copyright (c) 2014年 jakey. All rights reserved.
//

#import "UITableViewCell+TXNIB.h"

@implementation UITableViewCell (TXNIB)
/**
 *  @brief  加载同类名的nib
 *
 *  @return nib
 */
+(UINib*)tx_nib{
   return  [UINib nibWithNibName:NSStringFromClass([self class]) bundle:nil];
}
@end
