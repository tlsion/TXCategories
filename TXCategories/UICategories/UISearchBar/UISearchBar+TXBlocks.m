//
//  UISearchBar+TXBlocks.m
//  UISearchBarBlocks
//
//  Created by Håkon Bogen on 20.10.13.
//  Copyright (c) 2013 Håkon Bogen. All rights reserved.
//

#import "UISearchBar+TXBlocks.h"
#import <objc/runtime.h>

/* Only for convenience and readabilty in delegate methods */
typedef BOOL (^TX_UISearchBarReturnBlock) (UISearchBar *searchBar);
typedef void (^TX_UISearchBarVoidBlock) (UISearchBar *searchBar);
typedef void (^TX_UISearchBarSearchTextBlock) (UISearchBar *searchBar,NSString *searchText);
typedef BOOL (^TX_UISearchBarInRangeReplacementTextBlock) (UISearchBar *searchBar,NSRange range,NSString *text);
typedef void (^TX_UISearchBarScopeIndexBlock)(UISearchBar *searchBar, NSInteger selectedScope);

@implementation UISearchBar (TXBlocks)


static const void *TX_UISearchBarDelegateKey                                = &TX_UISearchBarDelegateKey;
static const void *TX_UISearchBarShouldBeginEditingKey                      = &TX_UISearchBarShouldBeginEditingKey;
static const void *TX_UISearchBarTextDidBeginEditingKey                     = &TX_UISearchBarTextDidBeginEditingKey;
static const void *TX_UISearchBarShouldEndEditingKey                        = &TX_UISearchBarShouldEndEditingKey;
static const void *TX_UISearchBarTextDidEndEditingKey                       = &TX_UISearchBarTextDidEndEditingKey;
static const void *TX_UISearchBarTextDidChangeKey                           = &TX_UISearchBarTextDidChangeKey;
static const void *TX_UISearchBarShouldChangeTextInRangeKey                 = &TX_UISearchBarShouldChangeTextInRangeKey;
static const void *TX_UISearchBarSearchButtonClickedKey                                = &TX_UISearchBarSearchButtonClickedKey;
static const void *TX_UISearchBarBookmarkButtonClickedKey                                = &TX_UISearchBarBookmarkButtonClickedKey;
static const void *TX_UISearchBarCancelButtonClickedKey                                = &TX_UISearchBarCancelButtonClickedKey;
static const void *TX_UISearchBarResultsListButtonClickedKey                                = &TX_UISearchBarResultsListButtonClickedKey;
static const void *TX_UISearchBarSelectedScopeButtonIndexDidChangeKey                                = &TX_UISearchBarSelectedScopeButtonIndexDidChangeKey;




#pragma mark UISearchBar delegate Methods
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar;
{
    TX_UISearchBarReturnBlock block = searchBar.tx_completionShouldBeginEditingBlock;
    if (block) {
        return block(searchBar);
    }
    id delegate = objc_getAssociatedObject(self, TX_UISearchBarDelegateKey);
    
    if (delegate && [delegate respondsToSelector:@selector(searchBarShouldBeginEditing:)]){
        return [delegate searchBarShouldBeginEditing:searchBar];
    }
    return YES;
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    TX_UISearchBarVoidBlock block = searchBar.tx_completionTextDidBeginEditingBlock;
    if (block) {
        block(searchBar);
    }
    id delegate = objc_getAssociatedObject(self, TX_UISearchBarDelegateKey);
    
    if (delegate && [delegate respondsToSelector:@selector(searchBarTextDidBeginEditing:)]){
        [delegate searchBarTextDidBeginEditing:searchBar];
    }
}

- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar
{
    TX_UISearchBarReturnBlock block = searchBar.tx_completionShouldEndEditingBlock;
    if (block) {
        return block(searchBar);
    }
    id delegate = objc_getAssociatedObject(self, TX_UISearchBarDelegateKey);
    
    if (delegate && [delegate respondsToSelector:@selector(searchBarShouldEndEditing:)]){
        return [delegate searchBarShouldEndEditing:searchBar];
    }
    return YES;
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{
   TX_UISearchBarVoidBlock block = searchBar.tx_completionTextDidEndEditingBlock;
    if (block) {
        block(searchBar);
    }
    id delegate = objc_getAssociatedObject(self, TX_UISearchBarDelegateKey);
    
    if (delegate && [delegate respondsToSelector:@selector(searchBarTextDidEndEditing:)]){
        [delegate searchBarTextDidEndEditing:searchBar];
    }
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    TX_UISearchBarSearchTextBlock block = searchBar.tx_completionTextDidChangeBlock;
    if (block) {
        block(searchBar,searchText);
    }
    id delegate = objc_getAssociatedObject(self, TX_UISearchBarDelegateKey);
    
    if (delegate && [delegate respondsToSelector:@selector(searchBar:textDidChange:)]){
        [delegate searchBar:searchBar textDidChange:searchText];
    }
}
// called when text changes (including clear)
- (BOOL)searchBar:(UISearchBar *)searchBar shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    TX_UISearchBarInRangeReplacementTextBlock block = searchBar.tx_completionShouldChangeTextInRangeBlock;
    if (block) {
        return block(searchBar,range,text);
    }
    id delegate = objc_getAssociatedObject(self, TX_UISearchBarDelegateKey);
    
    if (delegate && [delegate respondsToSelector:@selector(searchBar:shouldChangeTextInRange:replacementText:)]){
        return [delegate searchBar:searchBar shouldChangeTextInRange:range replacementText:text];
    }
    return YES;
}
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    TX_UISearchBarVoidBlock block = searchBar.tx_completionSearchButtonClickedBlock;
    if (block) {
        block(searchBar);
    }
    id delegate = objc_getAssociatedObject(self, TX_UISearchBarDelegateKey);
    
    if (delegate && [delegate respondsToSelector:@selector(searchBarSearchButtonClicked:)]){
        [delegate searchBarSearchButtonClicked:searchBar];
    }
}

- (void)searchBarBookmarkButtonClicked:(UISearchBar *)searchBar
{
    TX_UISearchBarVoidBlock block = searchBar.tx_completionBookmarkButtonClickedBlock;
    if (block) {
        block(searchBar);
    }
    id delegate = objc_getAssociatedObject(self, TX_UISearchBarDelegateKey);
    
    if (delegate && [delegate respondsToSelector:@selector(searchBarBookmarkButtonClicked:)]){
        [delegate searchBarBookmarkButtonClicked:searchBar];
    }
}

- (void)searchBarCancelButtonClicked:(UISearchBar *) searchBar
{
    TX_UISearchBarVoidBlock block = searchBar.tx_completionCancelButtonClickedBlock;
    if (block) {
        block(searchBar);
    }
    id delegate = objc_getAssociatedObject(self, TX_UISearchBarDelegateKey);
    
    if (delegate && [delegate respondsToSelector:@selector(searchBarCancelButtonClicked:)]){
        [delegate searchBarCancelButtonClicked:searchBar];
    }
}

- (void)searchBarResultsListButtonClicked:(UISearchBar *)searchBar
{
    TX_UISearchBarVoidBlock block = searchBar.tx_completionResultsListButtonClickedBlock;
    if (block) {
        block(searchBar);
    }
    id delegate = objc_getAssociatedObject(self, TX_UISearchBarDelegateKey);
    
    if (delegate && [delegate respondsToSelector:@selector(searchBarResultsListButtonClicked:)]){
        [delegate searchBarResultsListButtonClicked:searchBar];
    }
}

- (void)searchBar:(UISearchBar *)searchBar selectedScopeButtonIndexDidChange:(NSInteger)selectedScope
{
    TX_UISearchBarScopeIndexBlock block = searchBar.tx_completionSelectedScopeButtonIndexDidChangeBlock;
    if (block) {
        block(searchBar,selectedScope);
    }
    id delegate = objc_getAssociatedObject(self, TX_UISearchBarDelegateKey);
    
    if (delegate && [delegate respondsToSelector:@selector(searchBar:selectedScopeButtonIndexDidChange:)]){
        [delegate searchBar:searchBar selectedScopeButtonIndexDidChange:selectedScope];
    }
}


#pragma mark Block setting/getting methods
- (BOOL (^)(UISearchBar *))tx_completionShouldBeginEditingBlock
{
    return objc_getAssociatedObject(self, TX_UISearchBarShouldBeginEditingKey);
}

- (void)setTx_completionShouldBeginEditingBlock:(BOOL (^)(UISearchBar *))searchBarShouldBeginEditingBlock
{
    [self tx_setDelegateIfNoDelegateSet];
    objc_setAssociatedObject(self, TX_UISearchBarShouldBeginEditingKey, searchBarShouldBeginEditingBlock, OBJC_ASSOCIATION_COPY);
}

- (void (^)(UISearchBar *))tx_completionTextDidBeginEditingBlock
{
    return objc_getAssociatedObject(self,TX_UISearchBarTextDidBeginEditingKey);
}

- (void)setTx_completionTextDidBeginEditingBlock:(void (^)(UISearchBar *))searchBarTextDidBeginEditingBlock
{
    [self tx_setDelegateIfNoDelegateSet];
    objc_setAssociatedObject(self, TX_UISearchBarTextDidBeginEditingKey, searchBarTextDidBeginEditingBlock, OBJC_ASSOCIATION_COPY);
}

- (BOOL (^)(UISearchBar *))tx_completionShouldEndEditingBlock
{
    return objc_getAssociatedObject(self, TX_UISearchBarShouldEndEditingKey);
}

- (void)setTx_completionShouldEndEditingBlock:(BOOL (^)(UISearchBar *))searchBarShouldEndEditingBlock
{
    [self tx_setDelegateIfNoDelegateSet];
    objc_setAssociatedObject(self, TX_UISearchBarShouldEndEditingKey, searchBarShouldEndEditingBlock, OBJC_ASSOCIATION_COPY);
}

- (void (^)(UISearchBar *))tx_completionTextDidEndEditingBlock
{
    return objc_getAssociatedObject(self, TX_UISearchBarTextDidEndEditingKey);
}

- (void)setTx_completionTextDidEndEditingBlock:(void (^)(UISearchBar *))searchBarTextDidEndEditingBlock
{
    [self tx_setDelegateIfNoDelegateSet];
    objc_setAssociatedObject(self, TX_UISearchBarTextDidEndEditingKey, searchBarTextDidEndEditingBlock, OBJC_ASSOCIATION_COPY);
}

- (void (^)(UISearchBar *, NSString *))tx_completionTextDidChangeBlock
{
    return objc_getAssociatedObject(self, TX_UISearchBarTextDidChangeKey);
}

- (void)setTx_completionTextDidChangeBlock:(void (^)(UISearchBar *, NSString *))searchBarTextDidChangeBlock
{
    [self tx_setDelegateIfNoDelegateSet];
    objc_setAssociatedObject(self, TX_UISearchBarTextDidChangeKey, searchBarTextDidChangeBlock, OBJC_ASSOCIATION_COPY);
}

- (BOOL (^)(UISearchBar *, NSRange, NSString *))tx_completionShouldChangeTextInRangeBlock
{
    return objc_getAssociatedObject(self, TX_UISearchBarShouldChangeTextInRangeKey);
}

- (void)setTx_completionShouldChangeTextInRangeBlock:(BOOL (^)(UISearchBar *, NSRange, NSString *))searchBarShouldChangeTextInRangeBlock
{
    [self tx_setDelegateIfNoDelegateSet];
    objc_setAssociatedObject(self, TX_UISearchBarShouldChangeTextInRangeKey, searchBarShouldChangeTextInRangeBlock, OBJC_ASSOCIATION_COPY);
}

- (void (^)(UISearchBar *))tx_completionSearchButtonClickedBlock
{
    return objc_getAssociatedObject(self, TX_UISearchBarSearchButtonClickedKey);
}

- (void)setTx_completionSearchButtonClickedBlock:(void (^)(UISearchBar *))searchBarSearchButtonClickedBlock
{
    [self tx_setDelegateIfNoDelegateSet];
    objc_setAssociatedObject(self, TX_UISearchBarSearchButtonClickedKey, searchBarSearchButtonClickedBlock, OBJC_ASSOCIATION_COPY);
}

- (void (^)(UISearchBar *))tx_completionBookmarkButtonClickedBlock
{
    return objc_getAssociatedObject(self, TX_UISearchBarBookmarkButtonClickedKey);
}

- (void)setTx_completionBookmarkButtonClickedBlock:(void (^)(UISearchBar *))searchBarBookmarkButtonClickedBlock
{
    [self tx_setDelegateIfNoDelegateSet];
    objc_setAssociatedObject(self, TX_UISearchBarBookmarkButtonClickedKey, searchBarBookmarkButtonClickedBlock, OBJC_ASSOCIATION_COPY);
}

- (void (^)(UISearchBar *))tx_completionCancelButtonClickedBlock
{
    return objc_getAssociatedObject(self, TX_UISearchBarCancelButtonClickedKey);
}

- (void)setTx_completionCancelButtonClickedBlock:(void (^)(UISearchBar *))searchBarCancelButtonClickedBlock
{
    [self tx_setDelegateIfNoDelegateSet];
    objc_setAssociatedObject(self, TX_UISearchBarCancelButtonClickedKey, searchBarCancelButtonClickedBlock, OBJC_ASSOCIATION_COPY);
}

- (void (^)(UISearchBar *))tx_completionResultsListButtonClickedBlock
{
    return objc_getAssociatedObject(self, TX_UISearchBarResultsListButtonClickedKey);
}

- (void)setTx_completionResultsListButtonClickedBlock:(void (^)(UISearchBar *))searchBarResultsListButtonClickedBlock
{
    [self tx_setDelegateIfNoDelegateSet];
    objc_setAssociatedObject(self, TX_UISearchBarResultsListButtonClickedKey, searchBarResultsListButtonClickedBlock, OBJC_ASSOCIATION_COPY);
}

- (void (^)(UISearchBar *, NSInteger))tx_completionSelectedScopeButtonIndexDidChangeBlock
{
    return objc_getAssociatedObject(self, TX_UISearchBarSelectedScopeButtonIndexDidChangeKey);
}

- (void)setTx_completionSelectedScopeButtonIndexDidChangeBlock:(void (^)(UISearchBar *, NSInteger))searchBarSelectedScopeButtonIndexDidChangeBlock
{
    [self tx_setDelegateIfNoDelegateSet];
    objc_setAssociatedObject(self, TX_UISearchBarSelectedScopeButtonIndexDidChangeKey, searchBarSelectedScopeButtonIndexDidChangeBlock, OBJC_ASSOCIATION_COPY);
}

- (void)tx_setDelegateIfNoDelegateSet
{
    if (self.delegate != (id<UISearchBarDelegate>)self) {
        objc_setAssociatedObject(self, TX_UISearchBarDelegateKey, self.delegate, OBJC_ASSOCIATION_ASSIGN);
        self.delegate = (id<UISearchBarDelegate>)self;
    }
}

@end
