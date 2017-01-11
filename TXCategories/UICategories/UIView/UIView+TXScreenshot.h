//
//  UIView+Screenshot.h
//  TXCategories (https://github.com/tlsion/TXCategories)
//
//  Created by 王-庭协 on 15/1/10.
//  Copyright (c) 2015年 www.skyfox.org. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (TXScreenshot)
/**
 *  @brief  view截图
 *
 *  @return 截图
 */
- (UIImage *)tx_screenshot;

/**
 *  @author Jakey
 *
 *  @brief  截图一个view中所有视图 包括旋转缩放效果
 *
 *  @param aView    一个view
 *  @param limitWidth 限制缩放的最大宽度 保持默认传0
 *
 *  @return 截图
 */
- (UIImage *)tx_screenshot:(CGFloat)maxWidth;
@end
