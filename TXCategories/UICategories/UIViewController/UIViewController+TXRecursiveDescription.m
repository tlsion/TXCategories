//
//  UIViewController+RecursiveDescription.m
//  HLiPad
//
//  Created by Richard Turton on 07/01/2013.
//
//

#import "UIViewController+TXRecursiveDescription.h"

@implementation UIViewController (TXRecursiveDescription)
/**
 *  @brief  视图层级
 *
 *  @return 视图层级字符串
 */
-(NSString*)tx_recursiveDescription
{
    NSMutableString *description = [NSMutableString stringWithFormat:@"\n"];
    [self tx_addDescriptionToString:description indentLevel:0];
    return description;
}

-(void)tx_addDescriptionToString:(NSMutableString*)string indentLevel:(NSInteger)indentLevel
{
    NSString *padding = [@"" stringByPaddingToLength:indentLevel withString:@" " startingAtIndex:0];
    [string appendString:padding];
    [string appendFormat:@"%@, %@",[self debugDescription],NSStringFromCGRect(self.view.frame)];

    for (UIViewController *childController in self.childViewControllers)
    {
        [string appendFormat:@"\n%@>",padding];
        [childController tx_addDescriptionToString:string indentLevel:indentLevel + 1];
    }
}

@end
