//
//  UIBezierPath+TXSVGString.h
//  TXCategories (https://github.com/tlsion/TXCategories)
//
//  Created by 王-庭协 on 14/12/30.
//  Copyright (c) 2014年 www.skyfox.org. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBezierPath (TXSVGString)
/**
 *  @brief  UIBezierPath转成SVG
 *
 *  @return SVG
 */
- (NSString*)tx_SVGString;
@end
