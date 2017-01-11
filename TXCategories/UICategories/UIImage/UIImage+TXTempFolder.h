//
//  UIImage+TXTempFolder.h
//  TXCategoriesDemo
//
//  Created by Eton on 2017/1/11.
//  Copyright © 2017年 王-庭协. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (TXTempFolder)

/**
 *  保存图片到本地
 *
 *  @param fileName 保存为名字 包含后缀
 *  @param maxLength 压缩后最大字节大小
 *
 *  @return 返回图片路径
 */
- (NSString *)saveImageToTempFolderWithFileName:(NSString *)fileName maxLength:(CGFloat )maxLength;
- (NSString *)saveImageToTempFolderWithFileName:(NSString *)fileName;

@end
