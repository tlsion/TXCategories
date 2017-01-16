//
//  ViewController.m
//  TXCategoriesDemo
//
//  Created by Eton on 2017/1/11.
//  Copyright © 2017年 王-庭协. All rights reserved.
//

#import "ViewController.h"
#import "TXCategories.h"

@interface ViewController ()
{
    NSDictionary *_items;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"JKCategories";
    _items = @{
               @"TXUICategories":@[@"UIBezierPath",
                          @"UIButton",
                          @"UIColor",
                          @"UIFont",
                          @"UIDevice",
                          @"UIImage",
                          @"UIImageView",
                          @"UILable",
                          @"UINavigationController",
                          @"UIResponder",
                          @"UIScrollView",
                          @"UISearchBar",
                          @"UITableViewCell",
                          @"UITextField",
                          @"UITextView",
                          @"UIView",
                          @"UIViewController",
                          @"UIWebView",
                          @"UIWindow",
                          @"UITableView",
                          @"UINavigationBar",
                          @"UIAlertView",
                          @"UINavigationItem",
                          @"UIScreen",
                          @"UIControl",
                          @"UIApplication",
                          @"UIBarButtonItem",
                          @"UICollectionView"
                          
                          
                          ],
               @"TXNSCategories":@[@"NSArray",
                               @"NSBundle",
                               @"NSData",
                               @"NSDate",
                               @"NSDictionary",
                               @"NSException",
                               @"NSFileManager",
                               @"NSObject",
                               @"NSSet",
                               @"NSString",
                               @"NSTimer",
                               @"NSURL",
                               @"NSUserDefaults",
                               @"NSIndexPath",
                               @"NSDateFormatter",
                               @"NSNumber",
                               @"NSNotificationCenter",
                               @"NSHTTPCookieStorage",
                               @"NSFileHandle",
                               @"NSRunLoop",
                               @"NSURLRequest",
                               @"NSOperation",
                               @"NSInvocation",
                               @"NSURLConnection",
                               @"NSURLSession"
                               ]
               };
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
    [self.tableView reloadData];
    
    
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [[_items allKeys] count];
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return [_items allKeys][section];
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[_items objectForKey:[_items allKeys][section]] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    cell.textLabel.text =  [_items objectForKey:[_items allKeys][indexPath.section]][indexPath.row];
    return cell;
}

#pragma mark - Table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
