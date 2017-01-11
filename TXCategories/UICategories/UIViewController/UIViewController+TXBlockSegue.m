/*
 Copyright (c) 2014 Jorge Maroto García
 http://maroto.me

 Permission is hereby granted, free of charge, to any
 person obtaining a copy of this software and associated
 documentation files (the "Software"), to deal in the
 Software without restriction, including without limitation
 the rights to use, copy, modify, merge, publish,
 distribute, sublicense, and/or sell copies of the
 Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:

 The above copyright notice and this permission notice
 shall be included in all copies or substantial portions of
 the Software.

 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY
 KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE
 WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR
 PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS
 OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR
 OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR
 OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
 SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 */

#import "UIViewController+TXBlockSegue.h"
#import <objc/runtime.h>

static const void *UIViewControllerDictionaryBlockKey = &UIViewControllerDictionaryBlockKey;

@implementation UIViewController (TXBlockSegue)

__attribute__((constructor))
void TXBlockSegue(void) {
    Class currentClass = [UIViewController class];

    SEL originalSel = @selector(prepareForSegue:sender:);
    SEL swizzledSel = @selector(tx_prepareForSegue:sender:);

    Method originalMethod = class_getInstanceMethod(currentClass, originalSel);
    IMP swizzledImplementation = class_getMethodImplementation(currentClass, swizzledSel);

    method_setImplementation(originalMethod, swizzledImplementation);
}


-(void)tx_prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if (segue.identifier == nil) {
        return;
    }

    if (!self.jmg_dictionaryBlock || !self.jmg_dictionaryBlock[segue.identifier]) {
        NSLog(@"Segue identifier '%@' doesn't exist", segue.identifier);
        return;
    }

    UIViewControllerTXSegueBlock segueBlock = self.jmg_dictionaryBlock[segue.identifier];
    segueBlock(sender, segue.destinationViewController, segue);
}

-(NSMutableDictionary *)jmg_dictionaryBlock {
    return objc_getAssociatedObject(self, UIViewControllerDictionaryBlockKey);
}

-(NSMutableDictionary *)jmg_createDictionaryBlock {
    if (!self.jmg_dictionaryBlock) {
        objc_setAssociatedObject(self, UIViewControllerDictionaryBlockKey, [NSMutableDictionary dictionary], OBJC_ASSOCIATION_RETAIN);
    }

    return self.jmg_dictionaryBlock;
}

#pragma mark - Public interface
-(void)tx_configureSegue:(NSString *)identifier withBlock:(UIViewControllerTXSegueBlock)block {
    if (!identifier) {
        @throw [NSException exceptionWithName:NSInvalidArgumentException reason:@"Segue identifier can not be nil" userInfo:nil];
    }

    if (!block) {
        return ;
    }

    NSMutableDictionary *dBlocks = self.jmg_dictionaryBlock ?: [self jmg_createDictionaryBlock];
    [dBlocks setObject:block forKey:identifier];
}

-(void)tx_performSegueWithIdentifier:(NSString *)identifier sender:(id)sender withBlock:(UIViewControllerTXSegueBlock)block {
    if (!identifier) {
        @throw [NSException exceptionWithName:NSInvalidArgumentException reason:@"Segue identifier can not be nil" userInfo:nil];
    }

    if (!block) {
        return ;
    }

    [self tx_configureSegue:identifier withBlock:block];
    [self performSegueWithIdentifier:identifier sender:sender];
}

@end
