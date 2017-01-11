//
//  UIView+TXConstraints.m
//  TXCategories (https://github.com/tlsion/TXCategories)
//
//  Created by 王-庭协 on 15/5/22.
//  Copyright (c) 2015年 www.skyfox.org. All rights reserved.
//

#import "UIView+TXConstraints.h"

@implementation UIView (TXConstraints)
-(NSLayoutConstraint *)tx_constraintForAttribute:(NSLayoutAttribute)attribute {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"firstAttribute = %d && (firstItem = %@ || secondItem = %@)", attribute, self, self];
    NSArray *constraintArray = [self.superview constraints];
    
    if (attribute == NSLayoutAttributeWidth || attribute == NSLayoutAttributeHeight) {
        constraintArray = [self constraints];
    }
    
    NSArray *fillteredArray = [constraintArray filteredArrayUsingPredicate:predicate];
    if(fillteredArray.count == 0) {
        return nil;
    } else {
        return fillteredArray.firstObject;
    }
}

- (NSLayoutConstraint *)tx_leftConstraint {
    return [self tx_constraintForAttribute:NSLayoutAttributeLeft];
}

- (NSLayoutConstraint *)tx_rightConstraint {
    return [self tx_constraintForAttribute:NSLayoutAttributeRight];
}

- (NSLayoutConstraint *)tx_topConstraint {
    return [self tx_constraintForAttribute:NSLayoutAttributeTop];
}

- (NSLayoutConstraint *)tx_bottomConstraint {
    return [self tx_constraintForAttribute:NSLayoutAttributeBottom];
}

- (NSLayoutConstraint *)tx_leadingConstraint {
    return [self tx_constraintForAttribute:NSLayoutAttributeLeading];
}

- (NSLayoutConstraint *)tx_trailingConstraint {
    return [self tx_constraintForAttribute:NSLayoutAttributeTrailing];
}

- (NSLayoutConstraint *)tx_widthConstraint {
    return [self tx_constraintForAttribute:NSLayoutAttributeWidth];
}

- (NSLayoutConstraint *)tx_heightConstraint {
    return [self tx_constraintForAttribute:NSLayoutAttributeHeight];
}

- (NSLayoutConstraint *)tx_centerXConstraint {
    return [self tx_constraintForAttribute:NSLayoutAttributeCenterX];
}

- (NSLayoutConstraint *)tx_centerYConstraint {
    return [self tx_constraintForAttribute:NSLayoutAttributeCenterY];
}

- (NSLayoutConstraint *)tx_baseLineConstraint {
    return [self tx_constraintForAttribute:NSLayoutAttributeBaseline];
}
@end
