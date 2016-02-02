//
//  UIView+ZUX.h
//  ZUtilsX
//
//  Created by Char Aznable on 15/11/13.
//  Copyright © 2015年 org.cuc.n3. All rights reserved.
//

#ifndef ZUtilsX_UIView_ZUX_h
#define ZUtilsX_UIView_ZUX_h

#import <UIKit/UIKit.h>
#import "zobjc.h"
#import "zarc.h"
#import "ZUXCategory.h"

@category_interface(UIView, ZUX)

// Clip to Bounds.
@property BOOL      masksToBounds;

// Corner.
@property CGFloat   cornerRadius;

// Border.
@property CGFloat   borderWidth     UI_APPEARANCE_SELECTOR;
@property UIColor  *borderColor     UI_APPEARANCE_SELECTOR;

// Shadow.
@property UIColor  *shadowColor     UI_APPEARANCE_SELECTOR;
@property float     shadowOpacity   UI_APPEARANCE_SELECTOR;
@property CGSize    shadowOffset    UI_APPEARANCE_SELECTOR;
@property CGFloat   shadowSize      UI_APPEARANCE_SELECTOR;

// Screenshots.
- (UIImage *)imageRepresentation;

@end // UIView (ZUX)

@class ZUXTransform;

@category_interface(UIView, ZUXAutoLayout)

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

@end // UIView (ZUXAutoLayout)

typedef NS_OPTIONS(NSUInteger, ZUXAnimateType) {
    ZUXAnimateNone      =       0, // none animate
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
    
    ZUXAnimateOnce      = 0 << 10, // default
    ZUXAnimateRepeat    = 1 << 10, // repeat animation indefinitely
    
    // if ZUXAnimateRepeat
    ZUXAnimateForward   = 0 << 11, // default
    ZUXAnimateReverse   = 1 << 11, // repeat animation back and forth
};

// ZUXAnimateExpand/ZUXAnimateShrink parameter, at least 1
ZUX_EXTERN CGFloat ZUXAnimateZoomRatio;

// relative setting effective only when ZUXAnimateMove/ZUXAnimateSlide.
typedef NS_OPTIONS(NSUInteger, ZUXAnimateDirection) {
    ZUXAnimateStay      =       0, // default
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

@category_interface(UIView, ZUXAnimate)

- (void)zuxAnimate:(ZUXAnimation)animation;
- (void)zuxAnimate:(ZUXAnimation)animation completion:(void (^)())completion;

@end // UIView (ZUXAnimate)

@category_interface(UIView, ZUXBadge)

- (void)showBadge;
- (void)showBadgeWithValue:(NSString *)badgeValue;
- (void)hideBadge;

// default text font <font-family: ".SFUIText-Regular"; font-weight: normal; font-style: normal; font-size: 13.00pt>
@property (nonatomic, ZUX_STRONG) UIFont   *badgeTextFont   UI_APPEARANCE_SELECTOR;
// default text color [UIColor whiteColor]
@property (nonatomic, ZUX_STRONG) UIColor  *badgeTextColor  UI_APPEARANCE_SELECTOR;
// default color [UIColor redColor]
@property (nonatomic, ZUX_STRONG) UIColor  *badgeColor      UI_APPEARANCE_SELECTOR;
// default offset (0, 0), center position (bounds.size.width, badgeSize/4).
@property (nonatomic)             CGSize    badgeOffset     UI_APPEARANCE_SELECTOR;
// default size 8, badge is a circle of radius 4. Effect badge size when badgeValue is nil or empty.
@property (nonatomic)             CGFloat   badgeSize       UI_APPEARANCE_SELECTOR;

@end // UIView (ZUXBadge)

@category_interface(UIView, ZUXAppearance)

+ (CGFloat)borderWidth;
+ (void)setBorderWidth:(CGFloat)borderWidth;

+ (UIColor *)borderColor;
+ (void)setBorderColor:(UIColor *)borderColor;

+ (UIColor *)shadowColor;
+ (void)setShadowColor:(UIColor *)shadowColor;

+ (float)shadowOpacity;
+ (void)setShadowOpacity:(float)shadowOpacity;

+ (CGSize)shadowOffset;
+ (void)setShadowOffset:(CGSize)shadowOffset;

+ (CGFloat)shadowSize;
+ (void)setShadowSize:(CGFloat)shadowSize;

+ (UIFont *)badgeTextFont;
+ (void)setBadgeTextFont:(UIFont *)badgeTextFont;

+ (UIColor *)badgeTextColor;
+ (void)setBadgeTextColor:(UIColor *)badgeTextColor;

+ (UIColor *)badgeColor;
+ (void)setBadgeColor:(UIColor *)badgeColor;

+ (CGSize)badgeOffset;
+ (void)setBadgeOffset:(CGSize)badgeOffset;

+ (CGFloat)badgeSize;
+ (void)setBadgeSize:(CGFloat)badgeSize;

@end // UIView (ZUXAppearance)

#endif /* ZUtilsX_UIView_ZUX_h */
