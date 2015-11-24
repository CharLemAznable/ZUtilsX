//
//  UIView+ZUX.h
//  ZUtilsX
//
//  Created by Char Aznable on 15/11/13.
//  Copyright © 2015年 org.cuc.n3. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "zobjc.h"
#import "zarc.h"
#import "ZUXCategory.h"

ZUX_CATEGORY_H(ZUX_UIView)

@interface UIView (ZUX)

// Clip to Bounds.
@property BOOL      maskToBounds;

// Corner.
@property CGFloat   cornerRadius;

// Border.
@property CGFloat   borderWidth;
@property UIColor*  borderColor;

// Shadow
@property UIColor*  shadowColor;
@property float     shadowOpacity;
@property CGSize    shadowOffset;
@property CGFloat   shadowSize;

@end // UIView (ZUX) end

@class ZUXTransform;

@interface UIView (ZUXAutoLayout)

@property (nonatomic, ZUX_STRONG) ZUXTransform *zTransform; // animatable.

@property (nonatomic, ZUX_STRONG) id zLeft; // animatable.
@property (nonatomic, ZUX_STRONG) id zRight; // animatable.
@property (nonatomic, ZUX_STRONG) id zTop; // animatable.
@property (nonatomic, ZUX_STRONG) id zBottom; // animatable.
@property (nonatomic, ZUX_STRONG) id zWidth; // animatable.
@property (nonatomic, ZUX_STRONG) id zHeight; // animatable.
@property (nonatomic, ZUX_STRONG) id zCenterX; // animatable.
@property (nonatomic, ZUX_STRONG) id zCenterY; // animatable.
@property (nonatomic, ZUX_WEAK) UIView *zView;

- (ZUX_INSTANCETYPE)initWithTransform:(ZUXTransform *)transform;

@end // UIView (ZUXAutoLayout) end

typedef NS_OPTIONS(NSUInteger, ZUXAnimateType) {
    ZUXAnimateMove      = 1 <<  0, // animate by adjust self translate-transform
    ZUXAnimateFade      = 1 <<  1, // animate by adjust self alpha
    ZUXAnimateSlide     = 1 <<  2, // animate by adjust layer mask frame
    ZUXAnimateExpand    = 1 <<  3, // animate by adjust self scale-transform
    ZUXAnimateShrink    = 1 <<  4, // animate by adjust self scale-transform, expand and shrink at same time effect nothing
    
    ZUXAnimateIn        = 0 <<  8, // animate to current state, default
    ZUXAnimateOut       = 1 <<  8, // animate from current state
    
    // relative setting effective only when ZUXAnimateMove.
    ZUXAnimateBySelf    = 0 <<  9, // animate relative by self, default
    ZUXAnimateByWindow  = 1 <<  9, // animate relative by current window
};

// ZUXAnimateExpand/ZUXAnimateShrink parameter, at least 1
ZUX_EXTERN CGFloat ZUXAnimateZoomRatio;

// relative setting effective only when ZUXAnimateMove/ZUXAnimateSlide.
typedef NS_OPTIONS(NSUInteger, ZUXAnimateDirection) {
    ZUXAnimateNone      =       0, // default
    ZUXAnimateUp        = 1 <<  0,
    ZUXAnimateLeft      = 1 <<  1,
    ZUXAnimateDown      = 1 <<  2,
    ZUXAnimateRight     = 1 <<  3,
};

typedef struct ZUXAnimation {
    ZUXAnimateType type;
    ZUXAnimateDirection direction;
    NSTimeInterval duration, delay;
} ZUXAnimation;

ZUX_EXTERN ZUXAnimation ZUXAnimationMake(ZUXAnimateType type,
                                         ZUXAnimateDirection direction,
                                         NSTimeInterval duration,
                                         NSTimeInterval delay);

ZUX_EXTERN ZUXAnimation ZUXImmediateAnimationMake(ZUXAnimateType type,
                                                  ZUXAnimateDirection direction,
                                                  NSTimeInterval duration);

@interface UIView (ZUXAnimate)

- (void)zuxAnimate:(ZUXAnimation)animation;
- (void)zuxAnimate:(ZUXAnimation)animation completion:(void (^)())completion;

@end // UIView (ZUXAnimate) end
