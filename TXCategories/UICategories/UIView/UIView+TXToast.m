//
//  UIView+Toast.m
//  Toast
//
//  Copyright 2014 Charles Scalesse.
//


#import "UIView+TXToast.h"
#import <QuartzCore/QuartzCore.h>
#import <objc/runtime.h>

/*
 *  CONFIGURE THESE VALUES TO ADJUST LOOK & FEEL,
 *  DISPLAY DURATION, ETC.
 */

// general appearance
static const CGFloat TXToastMaxWidth            = 0.8;      // 80% of parent view width
static const CGFloat TXToastMaxHeight           = 0.8;      // 80% of parent view height
static const CGFloat TXToastHorizontalPadding   = 10.0;
static const CGFloat TXToastVerticalPadding     = 10.0;
static const CGFloat TXToastCornerRadius        = 10.0;
static const CGFloat TXToastOpacity             = 0.8;
static const CGFloat TXToastFontSize            = 16.0;
static const CGFloat TXToastMaxTitleLines       = 0;
static const CGFloat TXToastMaxMessageLines     = 0;
static const NSTimeInterval TXToastFadeDuration = 0.2;

// shadow appearance
static const CGFloat TXToastShadowOpacity       = 0.8;
static const CGFloat TXToastShadowRadius        = 6.0;
static const CGSize  TXToastShadowOffset        = { 4.0, 4.0 };
static const BOOL    TXToastDisplayShadow       = YES;

// display duration
static const NSTimeInterval TXToastDefaultDuration  = 3.0;

// image view size
static const CGFloat TXToastImageViewWidth      = 80.0;
static const CGFloat TXToastImageViewHeight     = 80.0;

// activity
static const CGFloat TXToastActivityWidth       = 100.0;
static const CGFloat TXToastActivityHeight      = 100.0;
static const NSString * TXToastActivityDefaultPosition = @"center";

// interaction
static const BOOL TXToastHidesOnTap             = YES;     // excludes activity views

// associative reference keys
static const NSString * TXToastTimerKey         = @"TXToastTimerKey";
static const NSString * TXToastActivityViewKey  = @"TXToastActivityViewKey";
static const NSString * TXToastTapCallbackKey   = @"TXToastTapCallbackKey";

// positions
NSString * const TXToastPositionTop             = @"top";
NSString * const TXToastPositionCenter          = @"center";
NSString * const TXToastPositionBottom          = @"bottom";

@interface UIView (TXToastPrivate)

- (void)tx_hideToast:(UIView *)toast;
- (void)tx_toastTimerDidFinish:(NSTimer *)timer;
- (void)tx_handleToastTapped:(UITapGestureRecognizer *)recognizer;
- (CGPoint)tx_centerPointForPosition:(id)position withToast:(UIView *)toast;
- (UIView *)tx_viewForMessage:(NSString *)message title:(NSString *)title image:(UIImage *)image;
- (CGSize)tx_sizeForString:(NSString *)string font:(UIFont *)font constrainedToSize:(CGSize)constrainedSize lineBreakMode:(NSLineBreakMode)lineBreakMode;

@end


@implementation UIView (TXToast)

#pragma mark - Toast Methods

- (void)tx_makeToast:(NSString *)message {
    [self tx_makeToast:message duration:TXToastDefaultDuration position:nil];
}

- (void)tx_makeToast:(NSString *)message duration:(NSTimeInterval)duration position:(id)position {
    UIView *toast = [self tx_viewForMessage:message title:nil image:nil];
    [self tx_showToast:toast duration:duration position:position];
}

- (void)tx_makeToast:(NSString *)message duration:(NSTimeInterval)duration position:(id)position title:(NSString *)title {
    UIView *toast = [self tx_viewForMessage:message title:title image:nil];
    [self tx_showToast:toast duration:duration position:position];
}

- (void)tx_makeToast:(NSString *)message duration:(NSTimeInterval)duration position:(id)position image:(UIImage *)image {
    UIView *toast = [self tx_viewForMessage:message title:nil image:image];
    [self tx_showToast:toast duration:duration position:position];
}

- (void)tx_makeToast:(NSString *)message duration:(NSTimeInterval)duration  position:(id)position title:(NSString *)title image:(UIImage *)image {
    UIView *toast = [self tx_viewForMessage:message title:title image:image];
    [self tx_showToast:toast duration:duration position:position];
}

- (void)tx_showToast:(UIView *)toast {
    [self tx_showToast:toast duration:TXToastDefaultDuration position:nil];
}


- (void)tx_showToast:(UIView *)toast duration:(NSTimeInterval)duration position:(id)position {
    [self tx_showToast:toast duration:duration position:position tapCallback:nil];
    
}


- (void)tx_showToast:(UIView *)toast duration:(NSTimeInterval)duration position:(id)position
      tapCallback:(void(^)(void))tapCallback
{
    toast.center = [self tx_centerPointForPosition:position withToast:toast];
    toast.alpha = 0.0;
    
    if (TXToastHidesOnTap) {
        UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] initWithTarget:toast action:@selector(tx_handleToastTapped:)];
        [toast addGestureRecognizer:recognizer];
        toast.userInteractionEnabled = YES;
        toast.exclusiveTouch = YES;
    }
    
    [self addSubview:toast];
    
    [UIView animateWithDuration:TXToastFadeDuration
                          delay:0.0
                        options:(UIViewAnimationOptionCurveEaseOut | UIViewAnimationOptionAllowUserInteraction)
                     animations:^{
                         toast.alpha = 1.0;
                     } completion:^(BOOL finished) {
                         NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:duration target:self selector:@selector(tx_toastTimerDidFinish:) userInfo:toast repeats:NO];
                         // associate the timer with the toast view
                         objc_setAssociatedObject (toast, &TXToastTimerKey, timer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
                         objc_setAssociatedObject (toast, &TXToastTapCallbackKey, tapCallback, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
                     }];
}


- (void)tx_hideToast:(UIView *)toast {
    [UIView animateWithDuration:TXToastFadeDuration
                          delay:0.0
                        options:(UIViewAnimationOptionCurveEaseIn | UIViewAnimationOptionBeginFromCurrentState)
                     animations:^{
                         toast.alpha = 0.0;
                     } completion:^(BOOL finished) {
                         [toast removeFromSuperview];
                     }];
}

#pragma mark - Events

- (void)tx_toastTimerDidFinish:(NSTimer *)timer {
    [self tx_hideToast:(UIView *)timer.userInfo];
}

- (void)tx_handleToastTapped:(UITapGestureRecognizer *)recognizer {
    NSTimer *timer = (NSTimer *)objc_getAssociatedObject(self, &TXToastTimerKey);
    [timer invalidate];
    
    void (^callback)(void) = objc_getAssociatedObject(self, &TXToastTapCallbackKey);
    if (callback) {
        callback();
    }
    [self tx_hideToast:recognizer.view];
}

#pragma mark - Toast Activity Methods

- (void)tx_makeToastActivity {
    [self tx_makeToastActivity:TXToastActivityDefaultPosition];
}

- (void)tx_makeToastActivity:(id)position {
    // sanity
    UIView *existingActivityView = (UIView *)objc_getAssociatedObject(self, &TXToastActivityViewKey);
    if (existingActivityView != nil) return;
    
    UIView *activityView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, TXToastActivityWidth, TXToastActivityHeight)];
    activityView.center = [self tx_centerPointForPosition:position withToast:activityView];
    activityView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:TXToastOpacity];
    activityView.alpha = 0.0;
    activityView.autoresizingMask = (UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin);
    activityView.layer.cornerRadius = TXToastCornerRadius;
    
    if (TXToastDisplayShadow) {
        activityView.layer.shadowColor = [UIColor blackColor].CGColor;
        activityView.layer.shadowOpacity = TXToastShadowOpacity;
        activityView.layer.shadowRadius = TXToastShadowRadius;
        activityView.layer.shadowOffset = TXToastShadowOffset;
    }
    
    UIActivityIndicatorView *activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    activityIndicatorView.center = CGPointMake(activityView.bounds.size.width / 2, activityView.bounds.size.height / 2);
    [activityView addSubview:activityIndicatorView];
    [activityIndicatorView startAnimating];
    
    // associate the activity view with self
    objc_setAssociatedObject (self, &TXToastActivityViewKey, activityView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    [self addSubview:activityView];
    
    [UIView animateWithDuration:TXToastFadeDuration
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         activityView.alpha = 1.0;
                     } completion:nil];
}

- (void)tx_hideToastActivity {
    UIView *existingActivityView = (UIView *)objc_getAssociatedObject(self, &TXToastActivityViewKey);
    if (existingActivityView != nil) {
        [UIView animateWithDuration:TXToastFadeDuration
                              delay:0.0
                            options:(UIViewAnimationOptionCurveEaseIn | UIViewAnimationOptionBeginFromCurrentState)
                         animations:^{
                             existingActivityView.alpha = 0.0;
                         } completion:^(BOOL finished) {
                             [existingActivityView removeFromSuperview];
                             objc_setAssociatedObject (self, &TXToastActivityViewKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
                         }];
    }
}

#pragma mark - Helpers

- (CGPoint)tx_centerPointForPosition:(id)point withToast:(UIView *)toast {
    if([point isKindOfClass:[NSString class]]) {
        if([point caseInsensitiveCompare:TXToastPositionTop] == NSOrderedSame) {
            return CGPointMake(self.bounds.size.width/2, (toast.frame.size.height / 2) + TXToastVerticalPadding);
        } else if([point caseInsensitiveCompare:TXToastPositionCenter] == NSOrderedSame) {
            return CGPointMake(self.bounds.size.width / 2, self.bounds.size.height / 2);
        }
    } else if ([point isKindOfClass:[NSValue class]]) {
        return [point CGPointValue];
    }
    
    // default to bottom
    return CGPointMake(self.bounds.size.width/2, (self.bounds.size.height - (toast.frame.size.height / 2)) - TXToastVerticalPadding);
}

- (CGSize)tx_sizeForString:(NSString *)string font:(UIFont *)font constrainedToSize:(CGSize)constrainedSize lineBreakMode:(NSLineBreakMode)lineBreakMode {
    if ([string respondsToSelector:@selector(boundingRectWithSize:options:attributes:context:)]) {
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        paragraphStyle.lineBreakMode = lineBreakMode;
        NSDictionary *attributes = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paragraphStyle};
        CGRect boundingRect = [string boundingRectWithSize:constrainedSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil];
        return CGSizeMake(ceilf(boundingRect.size.width), ceilf(boundingRect.size.height));
    }

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
    return [string sizeWithFont:font constrainedToSize:constrainedSize lineBreakMode:lineBreakMode];
#pragma clang diagnostic pop
}

- (UIView *)tx_viewForMessage:(NSString *)message title:(NSString *)title image:(UIImage *)image {
    // sanity
    if((message == nil) && (title == nil) && (image == nil)) return nil;

    // dynamically build a toast view with any combination of message, title, & image.
    UILabel *messageLabel = nil;
    UILabel *titleLabel = nil;
    UIImageView *imageView = nil;
    
    // create the parent view
    UIView *wrapperView = [[UIView alloc] init];
    wrapperView.autoresizingMask = (UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin);
    wrapperView.layer.cornerRadius = TXToastCornerRadius;
    
    if (TXToastDisplayShadow) {
        wrapperView.layer.shadowColor = [UIColor blackColor].CGColor;
        wrapperView.layer.shadowOpacity = TXToastShadowOpacity;
        wrapperView.layer.shadowRadius = TXToastShadowRadius;
        wrapperView.layer.shadowOffset = TXToastShadowOffset;
    }

    wrapperView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:TXToastOpacity];
    
    if(image != nil) {
        imageView = [[UIImageView alloc] initWithImage:image];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        imageView.frame = CGRectMake(TXToastHorizontalPadding, TXToastVerticalPadding, TXToastImageViewWidth, TXToastImageViewHeight);
    }
    
    CGFloat imageWidth, imageHeight, imageLeft;
    
    // the imageView frame values will be used to size & position the other views
    if(imageView != nil) {
        imageWidth = imageView.bounds.size.width;
        imageHeight = imageView.bounds.size.height;
        imageLeft = TXToastHorizontalPadding;
    } else {
        imageWidth = imageHeight = imageLeft = 0.0;
    }
    
    if (title != nil) {
        titleLabel = [[UILabel alloc] init];
        titleLabel.numberOfLines = TXToastMaxTitleLines;
        titleLabel.font = [UIFont boldSystemFontOfSize:TXToastFontSize];
        titleLabel.textAlignment = NSTextAlignmentLeft;
        titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
        titleLabel.textColor = [UIColor whiteColor];
        titleLabel.backgroundColor = [UIColor clearColor];
        titleLabel.alpha = 1.0;
        titleLabel.text = title;
        
        // size the title label according to the length of the text
        CGSize maxSizeTitle = CGSizeMake((self.bounds.size.width * TXToastMaxWidth) - imageWidth, self.bounds.size.height * TXToastMaxHeight);
        CGSize expectedSizeTitle = [self tx_sizeForString:title font:titleLabel.font constrainedToSize:maxSizeTitle lineBreakMode:titleLabel.lineBreakMode];
        titleLabel.frame = CGRectMake(0.0, 0.0, expectedSizeTitle.width, expectedSizeTitle.height);
    }
    
    if (message != nil) {
        messageLabel = [[UILabel alloc] init];
        messageLabel.numberOfLines = TXToastMaxMessageLines;
        messageLabel.font = [UIFont systemFontOfSize:TXToastFontSize];
        messageLabel.lineBreakMode = NSLineBreakByWordWrapping;
        messageLabel.textColor = [UIColor whiteColor];
        messageLabel.backgroundColor = [UIColor clearColor];
        messageLabel.alpha = 1.0;
        messageLabel.text = message;
        
        // size the message label according to the length of the text
        CGSize maxSizeMessage = CGSizeMake((self.bounds.size.width * TXToastMaxWidth) - imageWidth, self.bounds.size.height * TXToastMaxHeight);
        CGSize expectedSizeMessage = [self tx_sizeForString:message font:messageLabel.font constrainedToSize:maxSizeMessage lineBreakMode:messageLabel.lineBreakMode];
        messageLabel.frame = CGRectMake(0.0, 0.0, expectedSizeMessage.width, expectedSizeMessage.height);
    }
    
    // titleLabel frame values
    CGFloat titleWidth, titleHeight, titleTop, titleLeft;
    
    if(titleLabel != nil) {
        titleWidth = titleLabel.bounds.size.width;
        titleHeight = titleLabel.bounds.size.height;
        titleTop = TXToastVerticalPadding;
        titleLeft = imageLeft + imageWidth + TXToastHorizontalPadding;
    } else {
        titleWidth = titleHeight = titleTop = titleLeft = 0.0;
    }
    
    // messageLabel frame values
    CGFloat messageWidth, messageHeight, messageLeft, messageTop;

    if(messageLabel != nil) {
        messageWidth = messageLabel.bounds.size.width;
        messageHeight = messageLabel.bounds.size.height;
        messageLeft = imageLeft + imageWidth + TXToastHorizontalPadding;
        messageTop = titleTop + titleHeight + TXToastVerticalPadding;
    } else {
        messageWidth = messageHeight = messageLeft = messageTop = 0.0;
    }

    CGFloat longerWidth = MAX(titleWidth, messageWidth);
    CGFloat longerLeft = MAX(titleLeft, messageLeft);
    
    // wrapper width uses the longerWidth or the image width, whatever is larger. same logic applies to the wrapper height
    CGFloat wrapperWidth = MAX((imageWidth + (TXToastHorizontalPadding * 2)), (longerLeft + longerWidth + TXToastHorizontalPadding));    
    CGFloat wrapperHeight = MAX((messageTop + messageHeight + TXToastVerticalPadding), (imageHeight + (TXToastVerticalPadding * 2)));
                         
    wrapperView.frame = CGRectMake(0.0, 0.0, wrapperWidth, wrapperHeight);
    
    if(titleLabel != nil) {
        titleLabel.frame = CGRectMake(titleLeft, titleTop, titleWidth, titleHeight);
        [wrapperView addSubview:titleLabel];
    }
    
    if(messageLabel != nil) {
        messageLabel.frame = CGRectMake(messageLeft, messageTop, messageWidth, messageHeight);
        [wrapperView addSubview:messageLabel];
    }
    
    if(imageView != nil) {
        [wrapperView addSubview:imageView];
    }
        
    return wrapperView;
}

@end
