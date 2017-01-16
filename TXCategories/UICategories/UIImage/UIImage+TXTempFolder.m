//
//  UIImage+TXTempFolder.m
//  TXCategoriesDemo
//
//  Created by Eton on 2017/1/11.
//  Copyright © 2017年 王-庭协. All rights reserved.
//

#import "UIImage+TXTempFolder.h"
#import "UIImage+TXSuperCompress.h"

@implementation UIImage (TXTempFolder)

- (NSString *)tx_saveImageToTempFolderWithFileName:(NSString *)fileName{
    return [self tx_saveImageToTempFolderWithFileName:fileName maxLength:0];
}

- (NSString *)tx_saveImageToTempFolderWithFileName:(NSString *)fileName maxLength:(CGFloat )maxLength{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *filePath = [[paths objectAtIndex:0] stringByAppendingPathComponent:fileName];
//  Save image.
    NSData *imageData = nil;
    if (maxLength == 0) {
        imageData = UIImageJPEGRepresentation(self, 1.0f);
    }else{
        imageData = [UIImage tx_compressImage:self toMaxLength:maxLength];
    }
//    NSLog(@"imgScarle:%lu",(unsigned long)imageData.length);
    
    [imageData writeToFile:filePath atomically:YES];
    return filePath;
}

@end
