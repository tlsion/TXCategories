//
//  UILabel+AutomaticWriting.m
//  UILabel-AutomaticWriting
//
//  Created by alexruperez on 10/3/15.
//  Copyright (c) 2015 alexruperez. All rights reserved.
//

#import "UILabel+TXAutomaticWriting.h"
#import <objc/runtime.h>


NSTimeInterval const UILabelAWDefaultDuration = 0.4f;

unichar const UILabelAWDefaultCharacter = 124;

static inline void tx_AutomaticWritingSwizzleSelector(Class class, SEL originalSelector, SEL swizzledSelector) {
    Method originalMethod = class_getInstanceMethod(class, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
    if (class_addMethod(class, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod))) {
        class_replaceMethod(class, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}

static char kAutomaticWritingOperationQueueKey;
static char kAutomaticWritingEdgeInsetsKey;


@implementation UILabel (TXAutomaticWriting)

@dynamic tx_automaticWritingOperationQueue, tx_edgeInsets;

#pragma mark - Public Methods

+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        tx_AutomaticWritingSwizzleSelector([self class], @selector(textRectForBounds:limitedToNumberOfLines:), @selector(tx_automaticWritingTextRectForBounds:limitedToNumberOfLines:));
        tx_AutomaticWritingSwizzleSelector([self class], @selector(drawTextInRect:), @selector(tx_drawAutomaticWritingTextInRect:));
    });
}

-(void)tx_drawAutomaticWritingTextInRect:(CGRect)rect
{
    [self tx_drawAutomaticWritingTextInRect:UIEdgeInsetsInsetRect(rect, self.tx_edgeInsets)];
}

- (CGRect)tx_automaticWritingTextRectForBounds:(CGRect)bounds limitedToNumberOfLines:(NSInteger)numberOfLines
{
    CGRect textRect = [self tx_automaticWritingTextRectForBounds:UIEdgeInsetsInsetRect(bounds, self.tx_edgeInsets) limitedToNumberOfLines:numberOfLines];
    return textRect;
}

- (void)setTx_edgeInsets:(UIEdgeInsets)edgeInsets
{
    objc_setAssociatedObject(self, &kAutomaticWritingEdgeInsetsKey, [NSValue valueWithUIEdgeInsets:edgeInsets], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIEdgeInsets)tx_edgeInsets
{
    NSValue *edgeInsetsValue = objc_getAssociatedObject(self, &kAutomaticWritingEdgeInsetsKey);
    
    if (edgeInsetsValue)
    {
        return edgeInsetsValue.UIEdgeInsetsValue;
    }
    
    edgeInsetsValue = [NSValue valueWithUIEdgeInsets:UIEdgeInsetsZero];
    
    objc_setAssociatedObject(self, &kAutomaticWritingEdgeInsetsKey, edgeInsetsValue, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    return edgeInsetsValue.UIEdgeInsetsValue;
}

- (void)setTx_automaticWritingOperationQueue:(NSOperationQueue *)automaticWritingOperationQueue
{
    objc_setAssociatedObject(self, &kAutomaticWritingOperationQueueKey, automaticWritingOperationQueue, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSOperationQueue *)tx_automaticWritingOperationQueue
{
    NSOperationQueue *operationQueue = objc_getAssociatedObject(self, &kAutomaticWritingOperationQueueKey);
    
    if (operationQueue)
    {
        return operationQueue;
    }
    
    operationQueue = NSOperationQueue.new;
    operationQueue.name = @"Automatic Writing Operation Queue";
    operationQueue.maxConcurrentOperationCount = 1;
    
    objc_setAssociatedObject(self, &kAutomaticWritingOperationQueueKey, operationQueue, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    return operationQueue;
}

- (void)tx_setTextWithAutomaticWritingAnimation:(NSString *)text
{
    [self tx_setText:text automaticWritingAnimationWithBlinkingMode:UILabelTXlinkingModeNone];
}

- (void)tx_setText:(NSString *)text automaticWritingAnimationWithBlinkingMode:(UILabelTXlinkingMode)blinkingMode
{
    [self tx_setText:text automaticWritingAnimationWithDuration:UILabelAWDefaultDuration blinkingMode:blinkingMode];
}

- (void)tx_setText:(NSString *)text automaticWritingAnimationWithDuration:(NSTimeInterval)duration
{
    [self tx_setText:text automaticWritingAnimationWithDuration:duration blinkingMode:UILabelTXlinkingModeNone];
}

- (void)tx_setText:(NSString *)text automaticWritingAnimationWithDuration:(NSTimeInterval)duration blinkingMode:(UILabelTXlinkingMode)blinkingMode
{
    [self tx_setText:text automaticWritingAnimationWithDuration:duration blinkingMode:blinkingMode blinkingCharacter:UILabelAWDefaultCharacter];
}

- (void)tx_setText:(NSString *)text automaticWritingAnimationWithDuration:(NSTimeInterval)duration blinkingMode:(UILabelTXlinkingMode)blinkingMode blinkingCharacter:(unichar)blinkingCharacter
{
    [self tx_setText:text automaticWritingAnimationWithDuration:duration blinkingMode:blinkingMode blinkingCharacter:blinkingCharacter completion:nil];
}

- (void)tx_setText:(NSString *)text automaticWritingAnimationWithDuration:(NSTimeInterval)duration blinkingMode:(UILabelTXlinkingMode)blinkingMode blinkingCharacter:(unichar)blinkingCharacter completion:(void (^)(void))completion
{
    self.tx_automaticWritingOperationQueue.suspended = YES;
    self.tx_automaticWritingOperationQueue = nil;
    
    self.text = @"";
    
    NSMutableString *automaticWritingText = NSMutableString.new;
    
    if (text)
    {
        [automaticWritingText appendString:text];
    }
    
    [self.tx_automaticWritingOperationQueue addOperationWithBlock:^{
        [self tx_automaticWriting:automaticWritingText duration:duration mode:blinkingMode character:blinkingCharacter completion:completion];
    }];
}

#pragma mark - Private Methods

- (void)tx_automaticWriting:(NSMutableString *)text duration:(NSTimeInterval)duration mode:(UILabelTXlinkingMode)mode character:(unichar)character completion:(void (^)(void))completion
{
    NSOperationQueue *currentQueue = NSOperationQueue.currentQueue;
    if ((text.length || mode >= UILabelTXlinkingModeWhenFinish) && !currentQueue.isSuspended)
    {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(duration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            if (mode != UILabelTXlinkingModeNone)
            {
                if ([self tx_isLastCharacter:character])
                {
                    [self tx_deleteLastCharacter];
                }
                else if (mode != UILabelTXlinkingModeWhenFinish || !text.length)
                {
                    [text insertString:[self tx_stringWithCharacter:character] atIndex:0];
                }
            }
            
            if (text.length)
            {
                [self tx_appendCharacter:[text characterAtIndex:0]];
                [text deleteCharactersInRange:NSMakeRange(0, 1)];
                if ((![self tx_isLastCharacter:character] && mode == UILabelTXlinkingModeWhenFinishShowing) || (!text.length && mode == UILabelTXlinkingModeUntilFinishKeeping))
                {
                    [self tx_appendCharacter:character];
                }
            }
            
            if (!currentQueue.isSuspended)
            {
                [currentQueue addOperationWithBlock:^{
                    [self tx_automaticWriting:text duration:duration mode:mode character:character completion:completion];
                }];
            }
            else if (completion)
            {
                completion();
            }
        });
    }
    else if (completion)
    {
        completion();
    }
}

- (NSString *)tx_stringWithCharacter:(unichar)character
{
    return [self tx_stringWithCharacters:@[@(character)]];
}

- (NSString *)tx_stringWithCharacters:(NSArray *)characters
{
    NSMutableString *string = NSMutableString.new;
    
    for (NSNumber *character in characters)
    {
        [string appendFormat:@"%C", character.unsignedShortValue];
    }
    
    return string.copy;
}

- (void)tx_appendCharacter:(unichar)character
{
    [self tx_appendCharacters:@[@(character)]];
}

- (void)tx_appendCharacters:(NSArray *)characters
{
    self.text = [self.text stringByAppendingString:[self tx_stringWithCharacters:characters]];
}

- (BOOL)tx_isLastCharacters:(NSArray *)characters
{
    if (self.text.length >= characters.count)
    {
        return [self.text hasSuffix:[self tx_stringWithCharacters:characters]];
    }
    return NO;
}

- (BOOL)tx_isLastCharacter:(unichar)character
{
    return [self tx_isLastCharacters:@[@(character)]];
}

- (BOOL)tx_deleteLastCharacters:(NSUInteger)characters
{
    if (self.text.length >= characters)
    {
        self.text = [self.text substringToIndex:self.text.length-characters];
        return YES;
    }
    return NO;
}

- (BOOL)tx_deleteLastCharacter
{
    return [self tx_deleteLastCharacters:1];
}

@end
