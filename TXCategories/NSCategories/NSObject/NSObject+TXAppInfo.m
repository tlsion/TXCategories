//
//  NSObject+TXAppInfo.m
//  TXCategories
//
//  Created by nidom on 15/9/29.
//  Copyright © 2017年 ApeStar. All rights reserved
//

#import "NSObject+TXAppInfo.h"
#import <sys/utsname.h>
@implementation NSObject (TXAppInfo)

-(NSDictionary *)tx_infoDictionary{
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    return infoDictionary;
}

-(NSString *)tx_version{
    NSString *app_Version = [[self tx_infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    return app_Version;
}

-(NSInteger)tx_build{
    NSString *app_build = [[self tx_infoDictionary] objectForKey:@"CFBundleVersion"];
    return [app_build integerValue];
}

-(NSString *)tx_identifier{
    NSString * bundleIdentifier = [[self tx_infoDictionary] objectForKey:@"CFBundleIdentifier"];
    return bundleIdentifier;
}

-(NSString *)tx_appName{
    NSString *appName = [[self tx_infoDictionary] objectForKey:@"CFBundleDisplayName"];
    return appName;
}

-(NSString *)tx_currentLanguage{
    NSArray *languages = [NSLocale preferredLanguages];
    NSString *currentLanguage = [languages firstObject];
    return [NSString stringWithString:currentLanguage];
}

-(NSString *)tx_deviceModel{
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *deviceString = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    return [NSString stringWithString:deviceString];
}


@end
