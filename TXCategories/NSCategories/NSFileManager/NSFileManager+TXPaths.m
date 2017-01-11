//
//  NSFileManager+Paths.m
//  TXCategories (https://github.com/tlsion/TXCategories)
//
//  Created by 王-庭协 on 14/12/30.
//  Copyright (c) 2014年 www.skyfox.org. All rights reserved.
//

#import "NSFileManager+TXPaths.h"
#include <sys/xattr.h>

@implementation NSFileManager (TXPaths)
+ (NSURL *)tx_URLForDirectory:(NSSearchPathDirectory)directory
{
    return [self.defaultManager URLsForDirectory:directory inDomains:NSUserDomainMask].lastObject;
}

+ (NSString *)tx_pathForDirectory:(NSSearchPathDirectory)directory
{
    return NSSearchPathForDirectoriesInDomains(directory, NSUserDomainMask, YES)[0];
}

+ (NSURL *)tx_documentsURL
{
    return [self tx_URLForDirectory:NSDocumentDirectory];
}

+ (NSString *)tx_documentsPath
{
    return [self tx_pathForDirectory:NSDocumentDirectory];
}

+ (NSURL *)tx_libraryURL
{
    return [self tx_URLForDirectory:NSLibraryDirectory];
}

+ (NSString *)tx_libraryPath
{
    return [self tx_pathForDirectory:NSLibraryDirectory];
}

+ (NSURL *)tx_cachesURL
{
    return [self tx_URLForDirectory:NSCachesDirectory];
}

+ (NSString *)tx_cachesPath
{
    return [self tx_pathForDirectory:NSCachesDirectory];
}

+ (BOOL)tx_addSkipBackupAttributeToFile:(NSString *)path
{
    return [[NSURL.alloc initFileURLWithPath:path] setResourceValue:@(YES) forKey:NSURLIsExcludedFromBackupKey error:nil];
}

+ (double)tx_availableDiskSpace
{
    NSDictionary *attributes = [self.defaultManager attributesOfFileSystemForPath:self.tx_documentsPath error:nil];
    
    return [attributes[NSFileSystemFreeSize] unsignedLongLongValue] / (double)0x100000;
}
@end
