
//
//  UIBezierPath+LxThroughPointsBezier.m
//  LxThroughPointsBezierDemo
//

#import "UIBezierPath+TXThroughPointsBezier.h"
#import <objc/runtime.h>

@implementation UIBezierPath (TXThroughPointsBezier)

- (void)setTx_contractionFactor:(CGFloat)contractionFactor
{
    objc_setAssociatedObject(self, @selector(tx_contractionFactor), @(contractionFactor), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CGFloat)tx_contractionFactor
{
    id contractionFactorAssociatedObject = objc_getAssociatedObject(self, @selector(tx_contractionFactor));
    if (contractionFactorAssociatedObject == nil) {
        return 0.7;
    }
    return [contractionFactorAssociatedObject floatValue];
}

- (void)tx_addBezierThroughPoints:(NSArray *)pointArray
{
    NSAssert(pointArray.count > 0, @"You must give at least 1 point for drawing the curve.");
    
    if (pointArray.count < 3) {
        switch (pointArray.count) {
            case 1:
            {
                NSValue * point0Value = pointArray[0];
                CGPoint point0 = [point0Value CGPointValue];
                [self addLineToPoint:point0];
            }
                break;
            case 2:
            {
                NSValue * point0Value = pointArray[0];
                CGPoint point0 = [point0Value CGPointValue];
                NSValue * point1Value = pointArray[1];
                CGPoint point1 = [point1Value CGPointValue];
                [self addQuadCurveToPoint:point1 controlPoint:tx_ControlPointForTheBezierCanThrough3Point(self.currentPoint, point0, point1)];
            }
                break;
            default:
                break;
        }
    }
    
    CGPoint previousPoint = CGPointZero;
    
    CGPoint previousCenterPoint = CGPointZero;
    CGPoint centerPoint = CGPointZero;
    CGFloat centerPointDistance = 0;
    
    CGFloat obliqueAngle = 0;
    
    CGPoint previousControlPoint1 = CGPointZero;
    CGPoint previousControlPoint2 = CGPointZero;
    CGPoint controlPoint1 = CGPointZero;
    
    previousPoint = self.currentPoint;
    
    for (int i = 0; i < pointArray.count; i++) {
        
        NSValue * pointIValue = pointArray[i];
        CGPoint pointI = [pointIValue CGPointValue];
        
        if (i > 0) {
            
            previousCenterPoint = tx_CenterPointOf(self.currentPoint, previousPoint);
            centerPoint = tx_CenterPointOf(previousPoint, pointI);
            
            centerPointDistance = tx_DistanceBetweenPoint(previousCenterPoint, centerPoint);
            
            obliqueAngle = tx_ObliqueAngleOfStraightThrough(centerPoint, previousCenterPoint);
            
            previousControlPoint2 = CGPointMake(previousPoint.x - 0.5 * self.tx_contractionFactor * centerPointDistance * cos(obliqueAngle), previousPoint.y - 0.5 * self.tx_contractionFactor * centerPointDistance * sin(obliqueAngle));
            controlPoint1 = CGPointMake(previousPoint.x + 0.5 * self.tx_contractionFactor * centerPointDistance * cos(obliqueAngle), previousPoint.y + 0.5 * self.tx_contractionFactor * centerPointDistance * sin(obliqueAngle));
        }
        
        if (i == 1) {
            
            [self addQuadCurveToPoint:previousPoint controlPoint:previousControlPoint2];
        }
        else if (i > 1 && i < pointArray.count - 1) {
            
            [self addCurveToPoint:previousPoint controlPoint1:previousControlPoint1 controlPoint2:previousControlPoint2];
        }
        else if (i == pointArray.count - 1) {
            
            [self addCurveToPoint:previousPoint controlPoint1:previousControlPoint1 controlPoint2:previousControlPoint2];
            [self addQuadCurveToPoint:pointI controlPoint:controlPoint1];
        }
        else {
            
        }
        
        previousControlPoint1 = controlPoint1;
        previousPoint = pointI;
    }
}

CGFloat tx_ObliqueAngleOfStraightThrough(CGPoint point1, CGPoint point2)   //  [-π/2, 3π/2)
{
    CGFloat obliqueRatio = 0;
    CGFloat obliqueAngle = 0;
    
    if (point1.x > point2.x) {
        
        obliqueRatio = (point2.y - point1.y) / (point2.x - point1.x);
        obliqueAngle = atan(obliqueRatio);
    }
    else if (point1.x < point2.x) {
        
        obliqueRatio = (point2.y - point1.y) / (point2.x - point1.x);
        obliqueAngle = M_PI + atan(obliqueRatio);
    }
    else if (point2.y - point1.y >= 0) {
        
        obliqueAngle = M_PI/2;
    }
    else {
        obliqueAngle = -M_PI/2;
    }
    
    return obliqueAngle;
}

CGPoint tx_ControlPointForTheBezierCanThrough3Point(CGPoint point1, CGPoint point2, CGPoint point3)
{
    return CGPointMake(2 * point2.x - (point1.x + point3.x) / 2, 2 * point2.y - (point1.y + point3.y) / 2);
}

CGFloat tx_DistanceBetweenPoint(CGPoint point1, CGPoint point2)
{
    return sqrt((point1.x - point2.x) * (point1.x - point2.x) + (point1.y - point2.y) * (point1.y - point2.y));
}

CGPoint tx_CenterPointOf(CGPoint point1, CGPoint point2)
{
    return CGPointMake((point1.x + point2.x) / 2, (point1.y + point2.y) / 2);
}

@end
