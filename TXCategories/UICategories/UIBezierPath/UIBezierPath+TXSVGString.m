//
//  UIBezierPath+TXSVGString.m
//  TXCategories (https://github.com/tlsion/TXCategories)
//
//  Created by 王-庭协 on 14/12/30.
//  Copyright (c) 2014年 www.skyfox.org. All rights reserved.
//

#import "UIBezierPath+TXSVGString.h"
static void TXSVGApplier(void* info, const CGPathElement* element);
@implementation UIBezierPath (ZTKit)
/**
 *  @brief  UIBezierPath转成SVG
 *
 *  @return SVG
 */
- (NSString*)tx_SVGString
{
    CGPathRef path = [self CGPath];
    NSMutableString* SVGString = [NSMutableString string];
    [SVGString appendString:@"<path id=\"temporaryID\" d=\""];
    CGPathApply(path, (__bridge_retained void*)SVGString, TXSVGApplier);
    NSString *lineCap;
    switch (self.lineCapStyle) {
        case kCGLineCapRound:
            lineCap = @"round";
            break;
        case kCGLineCapSquare:
            lineCap = @"square";
            break;
        default:
            lineCap = @"butt";
            break;
    }
    [SVGString appendFormat:@"\" stroke-linecap=\"%@\" stroke-width=\"%i\" fill=\"none\" stroke=\"red\" />", lineCap, (int)self.lineWidth];
    return [NSString stringWithFormat:@"%@", SVGString];
}
@end

static void TXSVGApplier(void* info, const CGPathElement* element)
{
    NSMutableString* SVGString = (__bridge NSMutableString*) info;
    int nPoints;
    char elementKey;
    switch (element->type)
    {
        case kCGPathElementMoveToPoint:
            nPoints = 1;
            elementKey = 'M';
            break;
        case kCGPathElementAddLineToPoint:
            nPoints = 1;
            elementKey = 'L';
            break;
        case kCGPathElementAddQuadCurveToPoint:
            nPoints = 2;
            elementKey = 'Q';
            break;
        case kCGPathElementAddCurveToPoint:
            nPoints = 3;
            elementKey = 'C';
            break;
        case kCGPathElementCloseSubpath:
            nPoints = 0;
            elementKey = 'Z';
            break;
        default:
            SVGString = nil;
            return;
    }
    NSString* nextElement = [NSString stringWithFormat:@" %c", elementKey];
    for (int i = 0; i < nPoints; i++) {
        nextElement = [nextElement stringByAppendingString:[NSString stringWithFormat:@" %i %i", (int)element->points[i].x, (int)element->points[i].y]];
    }
    [SVGString appendString:nextElement];
}
