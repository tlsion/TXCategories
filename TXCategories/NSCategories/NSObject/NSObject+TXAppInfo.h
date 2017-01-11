//
//  NSObject+TXAppInfo.h
//  TXCategories
//
//  Created by nidom on 15/9/29.
//  Copyright © 2017年 ApeStar. All rights reserved
//

#import <Foundation/Foundation.h>

@interface NSObject (TXAppInfo)
-(NSString *)tx_version;
-(NSInteger)tx_build;
-(NSString *)tx_identifier;
-(NSString *)tx_currentLanguage;
-(NSString *)tx_deviceModel;
@end
