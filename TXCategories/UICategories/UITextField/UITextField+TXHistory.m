//
//  UITextField+History.m
//  Demo
//
//  Created by DamonDing on 15/5/26.
//  Copyright (c) 2015年 morenotepad. All rights reserved.
//

#import "UITextField+TXHistory.h"
#import <objc/runtime.h>

#define tx_history_X(view) (view.frame.origin.x)
#define tx_history_Y(view) (view.frame.origin.y)
#define tx_history_W(view) (view.frame.size.width)
#define tx_history_H(view) (view.frame.size.height)

static char kTextFieldIdentifyKey;
static char kTextFieldHistoryviewIdentifyKey;

#define tx_ANIMATION_DURATION 0.3f
#define tx_ITEM_HEIGHT 40
#define tx_CLEAR_BUTTON_HEIGHT 45
#define tx_MAX_HEIGHT 300


@interface UITextField ()<UITableViewDataSource,UITableViewDelegate>

@property (retain, nonatomic) UITableView *tx_historyTableView;

@end


@implementation UITextField (TXHistory)

- (NSString*)tx_identify {
    return objc_getAssociatedObject(self, &kTextFieldIdentifyKey);
}

- (void)setTx_identify:(NSString *)identify {
    objc_setAssociatedObject(self, &kTextFieldIdentifyKey, identify, OBJC_ASSOCIATION_RETAIN);
}

- (UITableView*)tx_historyTableView {
    UITableView* table = objc_getAssociatedObject(self, &kTextFieldHistoryviewIdentifyKey);
    
    if (table == nil) {
        table = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        [table registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITextFieldHistoryCell"];
        table.layer.borderColor = [UIColor grayColor].CGColor;
        table.layer.borderWidth = 1;
        table.delegate = self;
        table.dataSource = self;
        objc_setAssociatedObject(self, &kTextFieldHistoryviewIdentifyKey, table, OBJC_ASSOCIATION_RETAIN);
    }
    
    return table;
}

- (NSArray*)tx_loadHistroy {
    if (self.tx_identify == nil) {
        return nil;
    }

    NSUserDefaults* def = [NSUserDefaults standardUserDefaults];
    NSDictionary* dic = [def objectForKey:@"UITextField+TXHistory"];
    
    if (dic != nil) {
        return [dic objectForKey:self.tx_identify];
    }

    return nil;
}

- (void)tx_synchronize {
    if (self.tx_identify == nil || [self.text length] == 0) {
        return;
    }
    
    NSUserDefaults* def = [NSUserDefaults standardUserDefaults];
    NSDictionary* dic = [def objectForKey:@"UITextField+TXHistory"];
    NSArray* history = [dic objectForKey:self.tx_identify];
    
    NSMutableArray* newHistory = [NSMutableArray arrayWithArray:history];
    
    __block BOOL haveSameRecord = false;
    __weak typeof(self) weakSelf = self;
    
    [newHistory enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if ([(NSString*)obj isEqualToString:weakSelf.text]) {
            *stop = true;
            haveSameRecord = true;
        }
    }];
    
    if (haveSameRecord) {
        return;
    }
    
    [newHistory addObject:self.text];
    
    NSMutableDictionary* dic2 = [NSMutableDictionary dictionaryWithDictionary:dic];
    [dic2 setObject:newHistory forKey:self.tx_identify];
    
    [def setObject:dic2 forKey:@"UITextField+TXHistory"];
    
    [def synchronize];
}

- (void) tx_showHistory; {
    NSArray* history = [self tx_loadHistroy];
    
    if (self.tx_historyTableView.superview != nil || history == nil || history.count == 0) {
        return;
    }
    
    CGRect frame1 = CGRectMake(tx_history_X(self), tx_history_Y(self) + tx_history_H(self) + 1, tx_history_W(self), 1);
    CGRect frame2 = CGRectMake(tx_history_X(self), tx_history_Y(self) + tx_history_H(self) + 1, tx_history_W(self), MIN(tx_MAX_HEIGHT, tx_ITEM_HEIGHT * history.count + tx_CLEAR_BUTTON_HEIGHT));
    
    self.tx_historyTableView.frame = frame1;
    
    [self.superview addSubview:self.tx_historyTableView];
    
    [UIView animateWithDuration:tx_ANIMATION_DURATION animations:^{
        self.tx_historyTableView.frame = frame2;
    }];
}

- (void) tx_clearHistoryButtonClick:(UIButton*) button {
    [self tx_clearHistory];
    [self tx_hideHistroy];
}

- (void)tx_hideHistroy; {
    if (self.tx_historyTableView.superview == nil) {
        return;
    }

    CGRect frame1 = CGRectMake(tx_history_X(self), tx_history_Y(self) + tx_history_H(self) + 1, tx_history_W(self), 1);
    
    [UIView animateWithDuration:tx_ANIMATION_DURATION animations:^{
        self.tx_historyTableView.frame = frame1;
    } completion:^(BOOL finished) {
        [self.tx_historyTableView removeFromSuperview];
    }];
}

- (void) tx_clearHistory; {
    NSUserDefaults* def = [NSUserDefaults standardUserDefaults];
    
    [def setObject:nil forKey:@"UITextField+TXHistory"];
    [def synchronize];
}


#pragma mark tableview datasource
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wobjc-protocol-method-implementation"
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView; {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section; {
    return [self tx_loadHistroy].count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath; {
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"UITextFieldHistoryCell"];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITextFieldHistoryCell"];
    }
    
    cell.textLabel.text = [self tx_loadHistroy][indexPath.row];
    
    return cell;
}
#pragma clang diagnostic pop

#pragma mark tableview delegate
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section; {
    UIButton* clearButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [clearButton setTitle:@"Clear" forState:UIControlStateNormal];
    [clearButton addTarget:self action:@selector(tx_clearHistoryButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    return clearButton;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath; {
    return tx_ITEM_HEIGHT;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section; {
    return tx_CLEAR_BUTTON_HEIGHT;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath; {
    self.text = [self tx_loadHistroy][indexPath.row];
    [self tx_hideHistroy];
}

@end
