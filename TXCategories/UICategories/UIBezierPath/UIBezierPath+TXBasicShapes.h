//
//  UIBezierPath+TXBasicShapes.h
//  Example
//
//  Created by Pierre Dulac on 26/02/13.
//  Copyright (c) 2013 Pierre Dulac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBezierPath (TXBasicShapes)

+ (UIBezierPath *)tx_heartShape:(CGRect)originalFrame;
+ (UIBezierPath *)tx_userShape:(CGRect)originalFrame;
+ (UIBezierPath *)tx_martiniShape:(CGRect)originalFrame;
+ (UIBezierPath *)tx_beakerShape:(CGRect)originalFrame;
+ (UIBezierPath *)tx_starShape:(CGRect)originalFrame;
+ (UIBezierPath *)tx_stars:(NSUInteger)numberOfStars shapeInFrame:(CGRect)originalFrame;

@end
