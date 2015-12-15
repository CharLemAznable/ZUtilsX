//
//  UIBarButtonItem+ZUX.m
//  ZUtilsX
//
//  Created by Char Aznable on 15/12/15.
//  Copyright © 2015年 org.cuc.n3. All rights reserved.
//

#import "UIBarButtonItem+ZUX.h"
#import "ZUXGeometry.h"
#import "zadapt.h"
#import "zappearance.h"

ZUX_CATEGORY_M(ZUX_UIBarButtonItem)

@implementation UIBarButtonItem (ZUX)

#pragma mark - tintColor -

+ (UIColor *)tintColor {
    return [APPEARANCE tintColor];
}

+ (void)setTintColor:(UIColor *)tintColor {
    [APPEARANCE setTintColor:tintColor];
}

+ (UIColor *)tintColorWhenContainedIn:(Class<UIAppearanceContainer>)containerClass {
    return [APPEARANCE_IN_CLASS(containerClass) tintColor];
}

+ (void)setTintColor:(UIColor *)tintColor whenContainedIn:(Class<UIAppearanceContainer>)containerClass {
    [APPEARANCE_IN_CLASS(containerClass) setTintColor:tintColor];
}

#pragma mark - backgroundImage -

+ (UIImage *)defaultBackgroundImage {
    return [self backgroundImageForState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
}

+ (void)setDefaultBackgroundImage:(UIImage *)backgroundImage {
    [self setBackgroundImage:backgroundImage forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
}

+ (UIImage *)defaultBackgroundImageWhenContainedIn:(Class<UIAppearanceContainer>)containerClass {
    return [self backgroundImageForState:UIControlStateNormal barMetrics:UIBarMetricsDefault whenContainedIn:containerClass];
}

+ (void)setDefaultBackgroundImage:(UIImage *)backgroundImage whenContainedIn:(Class<UIAppearanceContainer>)containerClass {
    [self setBackgroundImage:backgroundImage forState:UIControlStateNormal barMetrics:UIBarMetricsDefault whenContainedIn:containerClass];
}

+ (UIImage *)backgroundImageForState:(UIControlState)state barMetrics:(UIBarMetrics)barMetrics {
    return [APPEARANCE backgroundImageForState:state barMetrics:barMetrics];
}

+ (void)setBackgroundImage:(UIImage *)backgroundImage forState:(UIControlState)state barMetrics:(UIBarMetrics)barMetrics {
    [APPEARANCE setBackgroundImage:backgroundImage forState:state barMetrics:barMetrics];
}

+ (UIImage *)backgroundImageForState:(UIControlState)state barMetrics:(UIBarMetrics)barMetrics whenContainedIn:(Class<UIAppearanceContainer>)containerClass {
    return [APPEARANCE_IN_CLASS(containerClass) backgroundImageForState:state barMetrics:barMetrics];
}

+ (void)setBackgroundImage:(UIImage *)backgroundImage forState:(UIControlState)state barMetrics:(UIBarMetrics)barMetrics whenContainedIn:(Class<UIAppearanceContainer>)containerClass {
    [APPEARANCE_IN_CLASS(containerClass) setBackgroundImage:backgroundImage forState:state barMetrics:barMetrics];
}

#if __IPHONE_OS_VERSION_MIN_REQUIRED >= 60000
#pragma mark - backgroundImage with style -

+ (UIImage *)defaultBackgroundImageForStyle:(UIBarButtonItemStyle)style {
    return [self backgroundImageForState:UIControlStateNormal style:style barMetrics:UIBarMetricsDefault];
}

+ (void)setDefaultBackgroundImage:(UIImage *)backgroundImage forStyle:(UIBarButtonItemStyle)style {
    [self setBackgroundImage:backgroundImage forState:UIControlStateNormal style:style barMetrics:UIBarMetricsDefault];
}

+ (UIImage *)defaultBackgroundImageForStyle:(UIBarButtonItemStyle)style whenContainedIn:(Class<UIAppearanceContainer>)containerClass {
    return [self backgroundImageForState:UIControlStateNormal style:style barMetrics:UIBarMetricsDefault whenContainedIn:containerClass];
}

+ (void)setDefaultBackgroundImage:(UIImage *)backgroundImage forStyle:(UIBarButtonItemStyle)style whenContainedIn:(Class<UIAppearanceContainer>)containerClass {
    [self setBackgroundImage:backgroundImage forState:UIControlStateNormal style:style barMetrics:UIBarMetricsDefault whenContainedIn:containerClass];
}

+ (UIImage *)backgroundImageForState:(UIControlState)state style:(UIBarButtonItemStyle)style barMetrics:(UIBarMetrics)barMetrics {
    return [APPEARANCE backgroundImageForState:state style:style barMetrics:barMetrics];
}

+ (void)setBackgroundImage:(UIImage *)backgroundImage forState:(UIControlState)state style:(UIBarButtonItemStyle)style barMetrics:(UIBarMetrics)barMetrics {
    [APPEARANCE setBackgroundImage:backgroundImage forState:state style:style barMetrics:barMetrics];
}

+ (UIImage *)backgroundImageForState:(UIControlState)state style:(UIBarButtonItemStyle)style barMetrics:(UIBarMetrics)barMetrics whenContainedIn:(Class<UIAppearanceContainer>)containerClass {
    return [APPEARANCE_IN_CLASS(containerClass) backgroundImageForState:state style:style barMetrics:barMetrics];
}

+ (void)setBackgroundImage:(UIImage *)backgroundImage forState:(UIControlState)state style:(UIBarButtonItemStyle)style barMetrics:(UIBarMetrics)barMetrics whenContainedIn:(Class<UIAppearanceContainer>)containerClass {
    [APPEARANCE_IN_CLASS(containerClass) setBackgroundImage:backgroundImage forState:state style:style barMetrics:barMetrics];
}
#endif // __IPHONE_OS_VERSION_MIN_REQUIRED >= 60000

#pragma mark - backgroundVerticalPositionAdjustment -

+ (CGFloat)defaultBackgroundVerticalPositionAdjustment {
    return [self backgroundVerticalPositionAdjustmentForBarMetrics:UIBarMetricsDefault];
}

+ (void)setDefaultBackgroundVerticalPositionAdjustment:(CGFloat)adjustment {
    [self setBackgroundVerticalPositionAdjustment:adjustment forBarMetrics:UIBarMetricsDefault];
}

+ (CGFloat)defaultBackgroundVerticalPositionAdjustmentWhenContainedIn:(Class<UIAppearanceContainer>)containerClass {
    return [self backgroundVerticalPositionAdjustmentForBarMetrics:UIBarMetricsDefault whenContainedIn:containerClass];
}

+ (void)setDefaultBackgroundVerticalPositionAdjustment:(CGFloat)adjustment whenContainedIn:(Class<UIAppearanceContainer>)containerClass {
    [self setBackgroundVerticalPositionAdjustment:adjustment forBarMetrics:UIBarMetricsDefault whenContainedIn:containerClass];
}

+ (CGFloat)backgroundVerticalPositionAdjustmentForBarMetrics:(UIBarMetrics)barMetrics {
    return [APPEARANCE backgroundVerticalPositionAdjustmentForBarMetrics:barMetrics];
}

+ (void)setBackgroundVerticalPositionAdjustment:(CGFloat)adjustment forBarMetrics:(UIBarMetrics)barMetrics {
    [APPEARANCE setBackgroundVerticalPositionAdjustment:adjustment forBarMetrics:barMetrics];
}

+ (CGFloat)backgroundVerticalPositionAdjustmentForBarMetrics:(UIBarMetrics)barMetrics whenContainedIn:(Class<UIAppearanceContainer>)containerClass {
    return [APPEARANCE_IN_CLASS(containerClass) backgroundVerticalPositionAdjustmentForBarMetrics:barMetrics];
}

+ (void)setBackgroundVerticalPositionAdjustment:(CGFloat)adjustment forBarMetrics:(UIBarMetrics)barMetrics whenContainedIn:(Class<UIAppearanceContainer>)containerClass {
    [APPEARANCE_IN_CLASS(containerClass) setBackgroundVerticalPositionAdjustment:adjustment forBarMetrics:barMetrics];
}

#pragma mark - titlePositionAdjustment -

+ (UIOffset)defaultTitlePositionAdjustment {
    return [self titlePositionAdjustmentForBarMetrics:UIBarMetricsDefault];
}

+ (void)setDefaultTitlePositionAdjustment:(UIOffset)adjustment {
    [self setTitlePositionAdjustment:adjustment forBarMetrics:UIBarMetricsDefault];
}

+ (UIOffset)defaultTitlePositionAdjustmentWhenContainedIn:(Class<UIAppearanceContainer>)containerClass {
    return [self titlePositionAdjustmentForBarMetrics:UIBarMetricsDefault whenContainedIn:containerClass];
}

+ (void)setDefaultTitlePositionAdjustment:(UIOffset)adjustment whenContainedIn:(Class<UIAppearanceContainer>)containerClass {
    [self setTitlePositionAdjustment:adjustment forBarMetrics:UIBarMetricsDefault whenContainedIn:containerClass];
}

+ (UIOffset)titlePositionAdjustmentForBarMetrics:(UIBarMetrics)barMetrics {
    return [APPEARANCE titlePositionAdjustmentForBarMetrics:barMetrics];
}

+ (void)setTitlePositionAdjustment:(UIOffset)adjustment forBarMetrics:(UIBarMetrics)barMetrics {
    [APPEARANCE setTitlePositionAdjustment:adjustment forBarMetrics:barMetrics];
}

+ (UIOffset)titlePositionAdjustmentForBarMetrics:(UIBarMetrics)barMetrics whenContainedIn:(Class<UIAppearanceContainer>)containerClass {
    return [APPEARANCE_IN_CLASS(containerClass) titlePositionAdjustmentForBarMetrics:barMetrics];
}

+ (void)setTitlePositionAdjustment:(UIOffset)adjustment forBarMetrics:(UIBarMetrics)barMetrics whenContainedIn:(Class<UIAppearanceContainer>)containerClass {
    [APPEARANCE_IN_CLASS(containerClass) setTitlePositionAdjustment:adjustment forBarMetrics:barMetrics];
}

#pragma mark - backButtonBackgroundImage -

+ (UIImage *)defaultBackButtonBackgroundImage {
    return [self backButtonBackgroundImageForState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
}

+ (void)setDefaultBackButtonBackgroundImage:(UIImage *)backgroundImage {
    [self setBackButtonBackgroundImage:backgroundImage forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
}

+ (UIImage *)defaultBackButtonBackgroundImageWhenContainedIn:(Class<UIAppearanceContainer>)containerClass {
    return [self backButtonBackgroundImageForState:UIControlStateNormal barMetrics:UIBarMetricsDefault whenContainedIn:containerClass];
}

+ (void)setDefaultBackButtonBackgroundImage:(UIImage *)backgroundImage whenContainedIn:(Class<UIAppearanceContainer>)containerClass {
    [self setBackButtonBackgroundImage:backgroundImage forState:UIControlStateNormal barMetrics:UIBarMetricsDefault whenContainedIn:containerClass];
}

+ (UIImage *)backButtonBackgroundImageForState:(UIControlState)state barMetrics:(UIBarMetrics)barMetrics {
    return [APPEARANCE backButtonBackgroundImageForState:state barMetrics:barMetrics];
}

+ (void)setBackButtonBackgroundImage:(UIImage *)backgroundImage forState:(UIControlState)state barMetrics:(UIBarMetrics)barMetrics {
    [APPEARANCE setBackButtonBackgroundImage:backgroundImage forState:state barMetrics:barMetrics];
}

+ (UIImage *)backButtonBackgroundImageForState:(UIControlState)state barMetrics:(UIBarMetrics)barMetrics whenContainedIn:(Class<UIAppearanceContainer>)containerClass {
    return [APPEARANCE_IN_CLASS(containerClass) backButtonBackgroundImageForState:state barMetrics:barMetrics];
}

+ (void)setBackButtonBackgroundImage:(UIImage *)backgroundImage forState:(UIControlState)state barMetrics:(UIBarMetrics)barMetrics whenContainedIn:(Class<UIAppearanceContainer>)containerClass {
    [APPEARANCE_IN_CLASS(containerClass) setBackButtonBackgroundImage:backgroundImage forState:state barMetrics:barMetrics];
}

#pragma mark - backButtonBackgroundVerticalPositionAdjustment -

+ (CGFloat)defaultBackButtonBackgroundVerticalPositionAdjustment {
    return [self backButtonBackgroundVerticalPositionAdjustmentForBarMetrics:UIBarMetricsDefault];
}

+ (void)setDefaultBackButtonBackgroundVerticalPositionAdjustment:(CGFloat)adjustment {
    [self setBackButtonBackgroundVerticalPositionAdjustment:adjustment forBarMetrics:UIBarMetricsDefault];
}

+ (CGFloat)defaultBackButtonBackgroundVerticalPositionAdjustmentWhenContainedIn:(Class<UIAppearanceContainer>)containerClass {
    return [self backButtonBackgroundVerticalPositionAdjustmentForBarMetrics:UIBarMetricsDefault whenContainedIn:containerClass];
}

+ (void)setDefaultBackButtonBackgroundVerticalPositionAdjustment:(CGFloat)adjustment whenContainedIn:(Class<UIAppearanceContainer>)containerClass {
    [self setBackButtonBackgroundVerticalPositionAdjustment:adjustment forBarMetrics:UIBarMetricsDefault whenContainedIn:containerClass];
}

+ (CGFloat)backButtonBackgroundVerticalPositionAdjustmentForBarMetrics:(UIBarMetrics)barMetrics {
    return [APPEARANCE backButtonBackgroundVerticalPositionAdjustmentForBarMetrics:barMetrics];
}

+ (void)setBackButtonBackgroundVerticalPositionAdjustment:(CGFloat)adjustment forBarMetrics:(UIBarMetrics)barMetrics {
    [APPEARANCE setBackButtonBackgroundVerticalPositionAdjustment:adjustment forBarMetrics:barMetrics];
}

+ (CGFloat)backButtonBackgroundVerticalPositionAdjustmentForBarMetrics:(UIBarMetrics)barMetrics whenContainedIn:(Class<UIAppearanceContainer>)containerClass {
    return [APPEARANCE_IN_CLASS(containerClass) backButtonBackgroundVerticalPositionAdjustmentForBarMetrics:barMetrics];
}

+ (void)setBackButtonBackgroundVerticalPositionAdjustment:(CGFloat)adjustment forBarMetrics:(UIBarMetrics)barMetrics whenContainedIn:(Class<UIAppearanceContainer>)containerClass {
    [APPEARANCE_IN_CLASS(containerClass) setBackButtonBackgroundVerticalPositionAdjustment:adjustment forBarMetrics:barMetrics];
}

#pragma mark - backButtonTitlePositionAdjustment -

+ (UIOffset)defaultBackButtonTitlePositionAdjustment {
    return [self backButtonTitlePositionAdjustmentForBarMetrics:UIBarMetricsDefault];
}

+ (void)setDefaultBackButtonTitlePositionAdjustment:(UIOffset)adjustment {
    [self setBackButtonTitlePositionAdjustment:adjustment forBarMetrics:UIBarMetricsDefault];
}

+ (UIOffset)defaultBackButtonTitlePositionAdjustmentWhenContainedIn:(Class<UIAppearanceContainer>)containerClass {
    return [self backButtonTitlePositionAdjustmentForBarMetrics:UIBarMetricsDefault whenContainedIn:containerClass];
}

+ (void)setDefaultBackButtonTitlePositionAdjustment:(UIOffset)adjustment whenContainedIn:(Class<UIAppearanceContainer>)containerClass {
    [self setBackButtonTitlePositionAdjustment:adjustment forBarMetrics:UIBarMetricsDefault whenContainedIn:containerClass];
}

+ (UIOffset)backButtonTitlePositionAdjustmentForBarMetrics:(UIBarMetrics)barMetrics {
    return [APPEARANCE backButtonTitlePositionAdjustmentForBarMetrics:barMetrics];
}

+ (void)setBackButtonTitlePositionAdjustment:(UIOffset)adjustment forBarMetrics:(UIBarMetrics)barMetrics {
    [APPEARANCE setBackButtonTitlePositionAdjustment:adjustment forBarMetrics:barMetrics];
}

+ (UIOffset)backButtonTitlePositionAdjustmentForBarMetrics:(UIBarMetrics)barMetrics whenContainedIn:(Class<UIAppearanceContainer>)containerClass {
    return [APPEARANCE_IN_CLASS(containerClass) backButtonTitlePositionAdjustmentForBarMetrics:barMetrics];
}

+ (void)setBackButtonTitlePositionAdjustment:(UIOffset)adjustment forBarMetrics:(UIBarMetrics)barMetrics whenContainedIn:(Class<UIAppearanceContainer>)containerClass {
    [APPEARANCE_IN_CLASS(containerClass) setBackButtonTitlePositionAdjustment:adjustment forBarMetrics:barMetrics];
}

#pragma mark - text attributes with container -

+ (UIFont *)textFontForState:(UIControlState)state whenContainedIn:(Class<UIAppearanceContainer>)containerClass {
    return TitleTextAttributeForKeyAndStateInClass(ZUXFontAttributeName, state, containerClass);
}

+ (void)setTextFont:(UIFont *)textFont forState:(UIControlState)state whenContainedIn:(Class<UIAppearanceContainer>)containerClass {
    SetTitleTextAttributeForKeyAndStateInClass(textFont, ZUXFontAttributeName, state, containerClass);
}

+ (UIColor *)textColorForState:(UIControlState)state whenContainedIn:(Class<UIAppearanceContainer>)containerClass {
    return TitleTextAttributeForKeyAndStateInClass(ZUXForegroundColorAttributeName, state, containerClass);
}

+ (void)setTextColor:(UIColor *)textColor forState:(UIControlState)state whenContainedIn:(Class<UIAppearanceContainer>)containerClass {
    SetTitleTextAttributeForKeyAndStateInClass(textColor, ZUXForegroundColorAttributeName, state, containerClass);
}

+ (UIColor *)textShadowColorForState:(UIControlState)state whenContainedIn:(Class<UIAppearanceContainer>)containerClass {
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= 60000
    return TitleShadowAttributeForStateInClass(state, containerClass).shadowColor;
#else
    return TitleTextAttributeForKeyAndStateInClass(UITextAttributeTextShadowColor, state, containerClass);
#endif
}

+ (void)setTextShadowColor:(UIColor *)textShadowColor forState:(UIControlState)state whenContainedIn:(Class<UIAppearanceContainer>)containerClass {
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= 60000
    NSShadow *shadow = DefaultTitleShadowAttributeForStateInClass(state, containerClass);
    [shadow setShadowColor:textShadowColor];
    SetTitleShadowAttributeForStateInClass(shadow, state, containerClass);
#else
    SetTitleTextAttributeForKeyAndStateInClass(textShadowColor, UITextAttributeTextShadowColor, state, containerClass);
#endif
}

+ (CGSize)textShadowOffsetForState:(UIControlState)state whenContainedIn:(Class<UIAppearanceContainer>)containerClass {
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= 60000
    return TitleShadowAttributeForStateInClass(state, containerClass).shadowOffset;
#else
    return ZUX_CGSizeFromUIOffset([TitleTextAttributeForKeyAndStateInClass(UITextAttributeTextShadowOffset, state, containerClass) UIOffsetValue]);
#endif
}

+ (void)setTextShadowOffset:(CGSize)textShadowOffset forState:(UIControlState)state whenContainedIn:(Class<UIAppearanceContainer>)containerClass {
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= 60000
    NSShadow *shadow = DefaultTitleShadowAttributeForStateInClass(state, containerClass);
    [shadow setShadowOffset:textShadowOffset];
    SetTitleShadowAttributeForStateInClass(shadow, state, containerClass);
#else
    NSValue *offsetValue = [NSValue valueWithUIOffset:ZUX_UIOffsetFromCGSize(textShadowOffset)];
    SetTitleTextAttributeForKeyAndStateInClass(offsetValue, UITextAttributeTextShadowOffset, state, containerClass);
#endif
}

#if __IPHONE_OS_VERSION_MIN_REQUIRED >= 60000
+ (CGFloat)textShadowSizeForState:(UIControlState)state whenContainedIn:(Class<UIAppearanceContainer>)containerClass {
    return TitleShadowAttributeForStateInClass(state, containerClass).shadowBlurRadius;
}

+ (void)setTextShadowSize:(CGFloat)textShadowSize forState:(UIControlState)state whenContainedIn:(Class<UIAppearanceContainer>)containerClass {
    NSShadow *shadow = DefaultTitleShadowAttributeForStateInClass(state, containerClass);
    [shadow setShadowBlurRadius:textShadowSize];
    SetTitleShadowAttributeForStateInClass(shadow, state, containerClass);
}
#endif

@end
