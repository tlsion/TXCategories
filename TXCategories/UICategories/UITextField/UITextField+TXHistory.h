//
//  UITextField+History.h
//  Demo
//
//  Created by DamonDing on 15/5/26.
//  Copyright (c) 2015年 morenotepad. All rights reserved.
//
//  https://github.com/Jameson-zxm/UITextField-History
//   A category of UITextfiled that can record it's input as history

#import <UIKit/UIKit.h>

@interface UITextField (TXHistory)

/**
 *  identity of this textfield
 */
@property (retain, nonatomic) NSString *tx_identify;


/**
 max history length, default is 30
 */
@property (nonatomic, assign) NSUInteger tx_maxHistoryLength;

/**
 *  load textfiled input history
 *
 *  @return the history of it's input
 */
- (NSArray*)tx_loadHistroy;

/**
 delete history, if history not found, do nothing

 @param history history string content
 */
- (void)tx_deleteHistory:(NSString *)history;

/**
 *  save current input text
 */
- (void)tx_synchronize;

- (void)tx_showHistory;
- (void)tx_hideHistroy;

- (void)tx_clearHistory;

@end
