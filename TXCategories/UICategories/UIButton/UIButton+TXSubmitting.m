//
//  UIButton+Submitting.m
//  FXCategories
//
//  Created by foxsofter on 15/4/2.
//  Copyright (c) 2015年 foxsofter. All rights reserved.
//

#import "UIButton+TXSubmitting.h"
#import  <objc/runtime.h>

@interface UIButton ()

@property(nonatomic, strong) UIView *tx_modalView;
@property(nonatomic, strong) UIActivityIndicatorView *tx_spinnerView;
@property(nonatomic, strong) UILabel *tx_spinnerTitleLabel;

@end

@implementation UIButton (TXSubmitting)

- (void)tx_beginSubmitting:(NSString *)title {
    [self tx_endSubmitting];
    
    self.tx_submitting = @YES;
    self.hidden = YES;
    
    self.tx_modalView = [[UIView alloc] initWithFrame:self.frame];
    self.tx_modalView.backgroundColor =
    [self.backgroundColor colorWithAlphaComponent:0.6];
    self.tx_modalView.layer.cornerRadius = self.layer.cornerRadius;
    self.tx_modalView.layer.borderWidth = self.layer.borderWidth;
    self.tx_modalView.layer.borderColor = self.layer.borderColor;
    
    CGRect viewBounds = self.tx_modalView.bounds;
    self.tx_spinnerView = [[UIActivityIndicatorView alloc]
                        initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    self.tx_spinnerView.tintColor = self.titleLabel.textColor;
    
    CGRect spinnerViewBounds = self.tx_spinnerView.bounds;
    self.tx_spinnerView.frame = CGRectMake(
                                        15, viewBounds.size.height / 2 - spinnerViewBounds.size.height / 2,
                                        spinnerViewBounds.size.width, spinnerViewBounds.size.height);
    self.tx_spinnerTitleLabel = [[UILabel alloc] initWithFrame:viewBounds];
    self.tx_spinnerTitleLabel.textAlignment = NSTextAlignmentCenter;
    self.tx_spinnerTitleLabel.text = title;
    self.tx_spinnerTitleLabel.font = self.titleLabel.font;
    self.tx_spinnerTitleLabel.textColor = self.titleLabel.textColor;
    [self.tx_modalView addSubview:self.tx_spinnerView];
    [self.tx_modalView addSubview:self.tx_spinnerTitleLabel];
    [self.superview addSubview:self.tx_modalView];
    [self.tx_spinnerView startAnimating];
}

- (void)tx_endSubmitting {
    if (!self.isTXSubmitting.boolValue) {
        return;
    }
    
    self.tx_submitting = @NO;
    self.hidden = NO;
    
    [self.tx_modalView removeFromSuperview];
    self.tx_modalView = nil;
    self.tx_spinnerView = nil;
    self.tx_spinnerTitleLabel = nil;
}

- (NSNumber *)isTXSubmitting {
    return objc_getAssociatedObject(self, @selector(setTx_submitting:));
}

- (void)setTx_submitting:(NSNumber *)submitting {
    objc_setAssociatedObject(self, @selector(setTx_submitting:), submitting, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
}

- (UIActivityIndicatorView *)tx_spinnerView {
    return objc_getAssociatedObject(self, @selector(setTx_spinnerView:));
}

- (void)setTx_spinnerView:(UIActivityIndicatorView *)spinnerView {
    objc_setAssociatedObject(self, @selector(setTx_spinnerView:), spinnerView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIView *)tx_modalView {
    return objc_getAssociatedObject(self, @selector(setTx_modalView:));

}

- (void)setTx_modalView:(UIView *)modalView {
    objc_setAssociatedObject(self, @selector(setTx_modalView:), modalView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UILabel *)tx_spinnerTitleLabel {
    return objc_getAssociatedObject(self, @selector(setTx_spinnerTitleLabel:));
}

- (void)setTx_spinnerTitleLabel:(UILabel *)spinnerTitleLabel {
    objc_setAssociatedObject(self, @selector(setTx_spinnerTitleLabel:), spinnerTitleLabel, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
