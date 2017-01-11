//
//  UISearchBar+TXBlocks.h
//  UISearchBarBlocks
//
//  Created by Håkon Bogen on 20.10.13.
//  Copyright (c) 2013 Håkon Bogen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UISearchBar (TXBlocks)

@property (copy, nonatomic) BOOL (^tx_completionShouldBeginEditingBlock)(UISearchBar *searchbar);
@property (copy, nonatomic) void (^tx_completionTextDidBeginEditingBlock)(UISearchBar *searchBar);
@property (copy, nonatomic) BOOL (^tx_completionShouldEndEditingBlock)(UISearchBar *searchBar);
@property (copy, nonatomic) void (^tx_completionTextDidEndEditingBlock)(UISearchBar *searchBar);
@property (copy, nonatomic) void (^tx_completionTextDidChangeBlock)(UISearchBar *searchBar, NSString *searchText);
@property (copy, nonatomic) BOOL (^tx_completionShouldChangeTextInRangeBlock)(UISearchBar *searchBar, NSRange range, NSString *replacementText);
@property (copy, nonatomic) void (^tx_completionSearchButtonClickedBlock)(UISearchBar *searchBar);
@property (copy, nonatomic) void (^tx_completionBookmarkButtonClickedBlock)(UISearchBar *searchBar);
@property (copy, nonatomic) void (^tx_completionCancelButtonClickedBlock)(UISearchBar *searchBar);
@property (copy, nonatomic) void (^tx_completionResultsListButtonClickedBlock)(UISearchBar *searchBar);
@property (copy, nonatomic) void (^tx_completionSelectedScopeButtonIndexDidChangeBlock)(UISearchBar *searchBar, NSInteger selectedScope);

- (void)setTx_completionShouldBeginEditingBlock:(BOOL (^)(UISearchBar *searchBar))searchBarShouldBeginEditingBlock;
- (void)setTx_completionTextDidBeginEditingBlock:(void (^)(UISearchBar *searchBar))searchBarTextDidBeginEditingBlock;
- (void)setTx_completionShouldEndEditingBlock:(BOOL (^)(UISearchBar *searchBar))searchBarShouldEndEditingBlock;
- (void)setTx_completionTextDidEndEditingBlock:(void (^)(UISearchBar *searchBar))searchBarTextDidEndEditingBlock;
- (void)setTx_completionTextDidChangeBlock:(void (^)(UISearchBar *searchBar, NSString *text))searchBarTextDidChangeBlock;
- (void)setTx_completionShouldChangeTextInRangeBlock:(BOOL (^)(UISearchBar *searchBar, NSRange range, NSString *text))searchBarShouldChangeTextInRangeBlock;
- (void)setTx_completionSearchButtonClickedBlock:(void (^)(UISearchBar *searchBar))searchBarSearchButtonClickedBlock;
- (void)setTx_completionBookmarkButtonClickedBlock:(void (^)(UISearchBar *searchBar))searchBarBookmarkButtonClickedBlock;
- (void)setTx_completionCancelButtonClickedBlock:(void (^)(UISearchBar *searchBar))searchBarCancelButtonClickedBlock;
- (void)setTx_completionResultsListButtonClickedBlock:(void (^)(UISearchBar *searchBar))searchBarResultsListButtonClickedBlock;
- (void)setTx_completionSelectedScopeButtonIndexDidChangeBlock:(void (^)(UISearchBar *searchBar, NSInteger index))searchBarSelectedScopeButtonIndexDidChangeBlock;

@end
