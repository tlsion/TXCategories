//
//  UIScrollView+PlaceHolder.m
//  TXCategoriesDemo
//
//  Created by Eton on 2017/10/12.
//  Copyright © 2017年 王-庭协. All rights reserved.
//

#import "UIScrollView+PlaceHolder.h"


#import <objc/runtime.h>

@interface UIScrollView ()

@property (nonatomic, assign) BOOL scrollWasEnabled;
@property (nonatomic, strong) UIView *placeHolderView;

@end


@implementation UIScrollView (PlaceHolder)

- (BOOL)scrollWasEnabled {
    NSNumber *scrollWasEnabledObject = objc_getAssociatedObject(self, @selector(scrollWasEnabled));
    return [scrollWasEnabledObject boolValue];
}

- (void)setScrollWasEnabled:(BOOL)scrollWasEnabled {
    NSNumber *scrollWasEnabledObject = [NSNumber numberWithBool:scrollWasEnabled];
    objc_setAssociatedObject(self, @selector(scrollWasEnabled), scrollWasEnabledObject, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIView *)placeHolderView {
    return objc_getAssociatedObject(self, @selector(placeHolderView));
}

- (void)setPlaceHolderView:(UIView *)placeHolderView {
    objc_setAssociatedObject(self, @selector(placeHolderView), placeHolderView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)tx_reloadData {
    
    if ([self respondsToSelector:@selector(endRefreshing)]) {
        [self performSelector:@selector(endRefreshing)];
    }
    
    if ([self isKindOfClass:[UITableView class]]) {
        [(UITableView *)self reloadData];
    }else if ([self isKindOfClass:[UICollectionView class]]) {
        [(UICollectionView *)self reloadData];
    }
    
    [self tx_checkEmpty];
}

- (void)tx_checkEmpty {
    BOOL isEmpty = YES;
    
    UIView * headerView = nil;
    UIView * footerView = nil;
    if ([self isKindOfClass:[UITableView class]]) {
        
        UITableView * tableView = (UITableView *)self;
        
        headerView = tableView.tableHeaderView;
        footerView = tableView.tableFooterView;
        
        id<UITableViewDataSource> src = tableView.dataSource;
        NSInteger sections = 1;
        if ([src respondsToSelector: @selector(numberOfSectionsInTableView:)]) {
            sections = [src numberOfSectionsInTableView:tableView];
        }
        for (NSInteger i = 0; i<sections; ++i) {
            NSInteger rows = [src tableView:tableView numberOfRowsInSection:i];
            if (rows) {
                isEmpty = NO;
            }
        }
        
    }else if ([self isKindOfClass:[UICollectionView class]]) {
        
        UICollectionView * collectionView = (UICollectionView *)self;
        
        id<UICollectionViewDataSource> src = collectionView.dataSource;
        NSInteger sections = 1;
        if ([src respondsToSelector: @selector(numberOfSectionsInTableView:)]) {
            sections = [src numberOfSectionsInCollectionView:collectionView];
        }
        for (NSInteger i = 0; i<sections; ++i) {
            NSInteger rows = [src collectionView:collectionView numberOfItemsInSection:i];
            if (rows) {
                isEmpty = NO;
            }
        }
        
    }
    
    if (!isEmpty != !self.placeHolderView) {
        if (isEmpty) {
            self.scrollWasEnabled = self.scrollEnabled;
            BOOL scrollEnabled = NO;
            if ([self respondsToSelector:@selector(enableScrollWhenPlaceHolderViewShowing)]) {
                scrollEnabled = [self performSelector:@selector(enableScrollWhenPlaceHolderViewShowing)]?YES:NO;
                if (!scrollEnabled) {
                    NSString *reason = @"There is no need to return  NO for `-enableScrollWhenPlaceHolderViewShowing`, it will be NO by default";
                    @throw [NSException exceptionWithName:NSGenericException
                                                   reason:reason
                                                 userInfo:nil];
                }
            } else if ([self.delegate respondsToSelector:@selector(enableScrollWhenPlaceHolderViewShowing)]) {
                scrollEnabled = [self.delegate performSelector:@selector(enableScrollWhenPlaceHolderViewShowing)]?YES:NO;
                if (!scrollEnabled) {
                    NSString *reason = @"There is no need to return  NO for `-enableScrollWhenPlaceHolderViewShowing`, it will be NO by default";
                    @throw [NSException exceptionWithName:NSGenericException
                                                   reason:reason
                                                 userInfo:nil];
                }
            }
            self.scrollEnabled = scrollEnabled;
            if ([self respondsToSelector:@selector(makePlaceHolderView)]) {
                self.placeHolderView = [self performSelector:@selector(makePlaceHolderView)];
            } else if ( [self.delegate respondsToSelector:@selector(makePlaceHolderView)]) {
                self.placeHolderView = [self.delegate performSelector:@selector(makePlaceHolderView)];
            } else {
                //                NSString *selectorName = NSStringFromSelector(_cmd);
                //                NSString *reason = [NSString stringWithFormat:@"You must implement makePlaceHolderView method in your custom tableView or its delegate class if you want to use %@", selectorName];
                //                @throw [NSException exceptionWithName:NSGenericException
                //                                               reason:reason
                //                                             userInfo:nil];
            }
            self.placeHolderView.frame = CGRectMake(0, CGRectGetHeight(headerView.frame), CGRectGetWidth(self.frame), CGRectGetHeight(self.frame) - CGRectGetHeight(headerView.frame) - CGRectGetHeight(footerView.frame));
            self.placeHolderView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
            [self addSubview:self.placeHolderView];
        } else {
            self.scrollEnabled = self.scrollWasEnabled;
            [self.placeHolderView removeFromSuperview];
            self.placeHolderView = nil;
        }
    } else if (isEmpty) {
        // Make sure it is still above all siblings.
        [self.placeHolderView removeFromSuperview];
        [self addSubview:self.placeHolderView];
    }
}

@end
