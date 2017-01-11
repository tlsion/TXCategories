//
//  UITextView+PinchZoom.m
//
//  Created by Stan Serebryakov <cfr@gmx.us> on 04.12.12.
//

#import "UITextView+TXPinchZoom.h"
#import "objc/runtime.h"

static int tx_minFontSizeKey;
static int tx_maxFontSizeKey;
static int tx_zoomEnabledKey;

@implementation UITextView (TXPinchZoom)

- (void)setTx_maxFontSize:(CGFloat)maxFontSize
{
    objc_setAssociatedObject(self, &tx_maxFontSizeKey, [NSNumber numberWithFloat:maxFontSize],
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CGFloat)tx_maxFontSize
{
    return [objc_getAssociatedObject(self, &tx_maxFontSizeKey) floatValue];
}

- (void)setTx_minFontSize:(CGFloat)maxFontSize
{
    objc_setAssociatedObject(self, &tx_minFontSizeKey, [NSNumber numberWithFloat:maxFontSize],
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CGFloat)tx_minFontSize
{
    return [objc_getAssociatedObject(self, &tx_minFontSizeKey) floatValue];
}

- (void)pinchGesture:(UIPinchGestureRecognizer *)gestureRecognizer
{
    if (!self.istx_zoomEnabled) return;

    CGFloat pointSize = (gestureRecognizer.velocity > 0.0f ? 1.0f : -1.0f) + self.font.pointSize;

    pointSize = MAX(MIN(pointSize, self.tx_maxFontSize), self.tx_minFontSize);

    self.font = [UIFont fontWithName:self.font.fontName size:pointSize];
}


- (void)setTx_zoomEnabled:(BOOL)zoomEnabled
{
    objc_setAssociatedObject(self, &tx_zoomEnabledKey, [NSNumber numberWithBool:zoomEnabled],
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);

    if (zoomEnabled) {
        for (UIGestureRecognizer *recognizer in self.gestureRecognizers) // initialized already
            if ([recognizer isKindOfClass:[UIPinchGestureRecognizer class]]) return;

        self.tx_minFontSize = self.tx_minFontSize ?: 8.0f;
        self.tx_maxFontSize = self.tx_maxFontSize ?: 42.0f;
        UIPinchGestureRecognizer *pinchRecognizer = [[UIPinchGestureRecognizer alloc]
                                                     initWithTarget:self action:@selector(pinchGesture:)];
        [self addGestureRecognizer:pinchRecognizer];
#if !__has_feature(objc_arc)
        [pinchRecognizer release];
#endif
    }
}

- (BOOL)istx_zoomEnabled
{
    return [objc_getAssociatedObject(self, &tx_zoomEnabledKey) boolValue];
}

@end
