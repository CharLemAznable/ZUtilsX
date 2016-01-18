//
//  ZUXTransform.m
//  ZUtilsX
//
//  Created by Char Aznable on 15/11/13.
//  Copyright © 2015年 org.cuc.n3. All rights reserved.
//

#import "ZUXTransform.h"
#import "NSNumber+ZUX.h"
#import "NSValue+ZUX.h"
#import "NSExpression+ZUX.h"
#import "ZUXConstraint.h"

@implementation ZUXTransform

- (ZUX_INSTANCETYPE)init {
    return [self initWithView:nil left:nil right:nil top:nil bottom:nil
                        width:nil height:nil centerX:nil centerY:nil];
}

- (ZUX_INSTANCETYPE)initWithView:(UIView *)view
                            left:(id)left right:(id)right
                             top:(id)top bottom:(id)bottom {
    return [self initWithView:view left:left right:right top:top bottom:bottom
                        width:nil height:nil centerX:nil centerY:nil];
}

- (ZUX_INSTANCETYPE)initWithView:(UIView *)view
                           width:(id)width height:(id)height
                         centerX:(id)centerX centerY:(id)centerY {
    return [self initWithView:view left:nil right:nil top:nil bottom:nil
                        width:width height:height centerX:centerX centerY:centerY];
}

- (ZUX_INSTANCETYPE)initWithView:(UIView *)view
                            left:(id)left right:(id)right
                             top:(id)top bottom:(id)bottom
                           width:(id)width height:(id)height
                         centerX:(id)centerX centerY:(id)centerY {
    if (ZUX_EXPECT_T(self = [super init])) {
        _view = view;
        _left = ZUX_RETAIN(left);
        _right = ZUX_RETAIN(right);
        _top = ZUX_RETAIN(top);
        _bottom = ZUX_RETAIN(bottom);
        _width = ZUX_RETAIN(width);
        _height = ZUX_RETAIN(height);
        _centerX = ZUX_RETAIN(centerX);
        _centerY = ZUX_RETAIN(centerY);
    }
    return self;
}

- (void)dealloc {
    _view = nil;
    ZUX_RELEASE(_left);
    ZUX_RELEASE(_right);
    ZUX_RELEASE(_top);
    ZUX_RELEASE(_bottom);
    ZUX_RELEASE(_width);
    ZUX_RELEASE(_height);
    ZUX_RELEASE(_centerX);
    ZUX_RELEASE(_centerY);
    ZUX_SUPER_DEALLOC;
}

- (BOOL)isEqual:(id)object {
    if (object == self) return YES;
    if (!object || ![object isKindOfClass:[self class]]) return NO;
    return [self isEqualToTransform:object];
}

- (BOOL)isEqualToTransform:(ZUXTransform *)transform {
    if (transform == self) return YES;
    return
    ((_view == nil && transform.view == nil) || [_view isEqual:transform.view]) &&
    ((_left == nil && transform.left == nil) || [_left isEqual:transform.left]) &&
    ((_right == nil && transform.right == nil) || [_right isEqual:transform.right]) &&
    ((_top == nil && transform.top == nil) || [_top isEqual:transform.top]) &&
    ((_bottom == nil && transform.bottom == nil) || [_bottom isEqual:transform.bottom]) &&
    ((_width == nil && transform.width == nil) || [_width isEqual:transform.width]) &&
    ((_height == nil && transform.height == nil) || [_height isEqual:transform.height]) &&
    ((_centerX == nil && transform.centerX == nil) || [_centerX isEqual:transform.centerX]) &&
    ((_centerY == nil && transform.centerY == nil) || [_centerY isEqual:transform.centerY]);
}

- (CGRect)transformRect {
    CGRect result = CGRectZero;
    if (ZUX_EXPECT_F(!_view)) return result;
    constraintOriginAndSize(_view, _view.bounds.size.width,
                            _left, _right, _width, _centerX,
                            &result.origin.x, &result.size.width);
    constraintOriginAndSize(_view, _view.bounds.size.height,
                            _top, _bottom, _height, _centerY,
                            &result.origin.y, &result.size.height);
    return result;
}

#pragma mark - transform implementation functions -

ZUX_STATIC void constraintOriginAndSize(UIView *view, CGFloat viewSize,
                            id marginConstraint1, id marginConstraint2,
                            id sizeConstraint, id centerConstraint,
                            CGFloat *resultOrigin, CGFloat *resultSize) {
    CGFloat margin1 = constraintValue(view, marginConstraint1);
    CGFloat margin2 = constraintValue(view, marginConstraint2);
    *resultSize = sizeConstraint ? constraintValue(view, sizeConstraint) : viewSize - margin1 - margin2;
    
    // adjust origin:
    // SS           : superviewSize
    // S            : size
    // m1           : margin1
    // m2           : margin2
    // capacity     = SS - m1 - m2;
    // center       = capacity / 2 + m1
    //              = (SS + m1 - m2) / 2;
    // leftCoord    = center - S / 2
    //              = (SS + m1 - m2 - S) / 2;
    CGFloat center = 0;
    if (!centerConstraint) {
        if (!marginConstraint1 && marginConstraint2) margin1 = viewSize - *resultSize - margin2;
        if (!marginConstraint2 && marginConstraint1) margin2 = viewSize - *resultSize - margin1;
        center = (viewSize + margin1 - margin2) / 2;
    } else center = constraintValue(view, centerConstraint);
    *resultOrigin = center - *resultSize / 2;
}

ZUX_STATIC CGFloat constraintValue(UIView *view, id constraint) {
    if ([constraint isKindOfClass:[NSNumber class]]) {
        return [(NSNumber *)constraint cgfloatValue];
    } else if ([constraint isKindOfClass:[ZUXConstraint class]]) {
        ZUXConstraintBlock block = [(ZUXConstraint *)constraint block];
        return (block && view) ? block(view) : 0;
    } else if ([constraint isKindOfClass:[NSExpression class]]) {
        id result = [(NSExpression *)constraint expressionValueWithObject:view context:nil];
        return [result respondsToSelector:@selector(cgfloatValue)] ? [result cgfloatValue] : 0;
    } else if ([constraint isKindOfClass:[NSString class]]) {
        return constraintValue(view, [NSExpression expressionWithParametricFormat:constraint]);
    }
    return 0;
}

@end
