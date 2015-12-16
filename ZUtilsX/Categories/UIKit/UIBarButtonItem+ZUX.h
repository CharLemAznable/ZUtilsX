//
//  UIBarButtonItem+ZUX.h
//  ZUtilsX
//
//  Created by Char Aznable on 15/12/15.
//  Copyright © 2015年 org.cuc.n3. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZUXCategory.h"

#ifndef ZUtilsX_UIBarButtonItem_ZUX_h
#define ZUtilsX_UIBarButtonItem_ZUX_h

ZUX_CATEGORY_H(ZUX_UIBarButtonItem)

@interface UIBarButtonItem (ZUX)

#pragma mark - tintColor -

+ (UIColor *)tintColor;
+ (void)setTintColor:(UIColor *)tintColor;
+ (UIColor *)tintColorWhenContainedIn:(Class<UIAppearanceContainer>)containerClass;
+ (void)setTintColor:(UIColor *)tintColor whenContainedIn:(Class<UIAppearanceContainer>)containerClass;

#pragma mark - backgroundImage -

+ (UIImage *)defaultBackgroundImage;
+ (void)setDefaultBackgroundImage:(UIImage *)backgroundImage;
+ (UIImage *)defaultBackgroundImageWhenContainedIn:(Class<UIAppearanceContainer>)containerClass;
+ (void)setDefaultBackgroundImage:(UIImage *)backgroundImage whenContainedIn:(Class<UIAppearanceContainer>)containerClass;
+ (UIImage *)backgroundImageForState:(UIControlState)state barMetrics:(UIBarMetrics)barMetrics;
+ (void)setBackgroundImage:(UIImage *)backgroundImage forState:(UIControlState)state barMetrics:(UIBarMetrics)barMetrics;
+ (UIImage *)backgroundImageForState:(UIControlState)state barMetrics:(UIBarMetrics)barMetrics whenContainedIn:(Class<UIAppearanceContainer>)containerClass;
+ (void)setBackgroundImage:(UIImage *)backgroundImage forState:(UIControlState)state barMetrics:(UIBarMetrics)barMetrics whenContainedIn:(Class<UIAppearanceContainer>)containerClass;

#pragma mark - backgroundImage with style -

+ (UIImage *)defaultBackgroundImageForStyle:(UIBarButtonItemStyle)style;
+ (void)setDefaultBackgroundImage:(UIImage *)backgroundImage forStyle:(UIBarButtonItemStyle)style;
+ (UIImage *)defaultBackgroundImageForStyle:(UIBarButtonItemStyle)style whenContainedIn:(Class<UIAppearanceContainer>)containerClass;
+ (void)setDefaultBackgroundImage:(UIImage *)backgroundImage forStyle:(UIBarButtonItemStyle)style whenContainedIn:(Class<UIAppearanceContainer>)containerClass;
+ (UIImage *)backgroundImageForState:(UIControlState)state style:(UIBarButtonItemStyle)style barMetrics:(UIBarMetrics)barMetrics;
+ (void)setBackgroundImage:(UIImage *)backgroundImage forState:(UIControlState)state style:(UIBarButtonItemStyle)style barMetrics:(UIBarMetrics)barMetrics;
+ (UIImage *)backgroundImageForState:(UIControlState)state style:(UIBarButtonItemStyle)style barMetrics:(UIBarMetrics)barMetrics whenContainedIn:(Class<UIAppearanceContainer>)containerClass;
+ (void)setBackgroundImage:(UIImage *)backgroundImage forState:(UIControlState)state style:(UIBarButtonItemStyle)style barMetrics:(UIBarMetrics)barMetrics whenContainedIn:(Class<UIAppearanceContainer>)containerClass;

#pragma mark - backgroundVerticalPositionAdjustment -

+ (CGFloat)defaultBackgroundVerticalPositionAdjustment;
+ (void)setDefaultBackgroundVerticalPositionAdjustment:(CGFloat)adjustment;
+ (CGFloat)defaultBackgroundVerticalPositionAdjustmentWhenContainedIn:(Class<UIAppearanceContainer>)containerClass;
+ (void)setDefaultBackgroundVerticalPositionAdjustment:(CGFloat)adjustment whenContainedIn:(Class<UIAppearanceContainer>)containerClass;
+ (CGFloat)backgroundVerticalPositionAdjustmentForBarMetrics:(UIBarMetrics)barMetrics;
+ (void)setBackgroundVerticalPositionAdjustment:(CGFloat)adjustment forBarMetrics:(UIBarMetrics)barMetrics;
+ (CGFloat)backgroundVerticalPositionAdjustmentForBarMetrics:(UIBarMetrics)barMetrics whenContainedIn:(Class<UIAppearanceContainer>)containerClass;
+ (void)setBackgroundVerticalPositionAdjustment:(CGFloat)adjustment forBarMetrics:(UIBarMetrics)barMetrics whenContainedIn:(Class<UIAppearanceContainer>)containerClass;

#pragma mark - titlePositionAdjustment -

+ (UIOffset)defaultTitlePositionAdjustment;
+ (void)setDefaultTitlePositionAdjustment:(UIOffset)adjustment;
+ (UIOffset)defaultTitlePositionAdjustmentWhenContainedIn:(Class<UIAppearanceContainer>)containerClass;
+ (void)setDefaultTitlePositionAdjustment:(UIOffset)adjustment whenContainedIn:(Class<UIAppearanceContainer>)containerClass;
+ (UIOffset)titlePositionAdjustmentForBarMetrics:(UIBarMetrics)barMetrics;
+ (void)setTitlePositionAdjustment:(UIOffset)adjustment forBarMetrics:(UIBarMetrics)barMetrics;
+ (UIOffset)titlePositionAdjustmentForBarMetrics:(UIBarMetrics)barMetrics whenContainedIn:(Class<UIAppearanceContainer>)containerClass;
+ (void)setTitlePositionAdjustment:(UIOffset)adjustment forBarMetrics:(UIBarMetrics)barMetrics whenContainedIn:(Class<UIAppearanceContainer>)containerClass;

#pragma mark - backButtonBackgroundImage -

+ (UIImage *)defaultBackButtonBackgroundImage;
+ (void)setDefaultBackButtonBackgroundImage:(UIImage *)backgroundImage;
+ (UIImage *)defaultBackButtonBackgroundImageWhenContainedIn:(Class<UIAppearanceContainer>)containerClass;
+ (void)setDefaultBackButtonBackgroundImage:(UIImage *)backgroundImage whenContainedIn:(Class<UIAppearanceContainer>)containerClass;
+ (UIImage *)backButtonBackgroundImageForState:(UIControlState)state barMetrics:(UIBarMetrics)barMetrics;
+ (void)setBackButtonBackgroundImage:(UIImage *)backgroundImage forState:(UIControlState)state barMetrics:(UIBarMetrics)barMetrics;
+ (UIImage *)backButtonBackgroundImageForState:(UIControlState)state barMetrics:(UIBarMetrics)barMetrics whenContainedIn:(Class<UIAppearanceContainer>)containerClass;
+ (void)setBackButtonBackgroundImage:(UIImage *)backgroundImage forState:(UIControlState)state barMetrics:(UIBarMetrics)barMetrics whenContainedIn:(Class<UIAppearanceContainer>)containerClass;

#pragma mark - backButtonBackgroundVerticalPositionAdjustment -

+ (CGFloat)defaultBackButtonBackgroundVerticalPositionAdjustment;
+ (void)setDefaultBackButtonBackgroundVerticalPositionAdjustment:(CGFloat)adjustment;
+ (CGFloat)defaultBackButtonBackgroundVerticalPositionAdjustmentWhenContainedIn:(Class<UIAppearanceContainer>)containerClass;
+ (void)setDefaultBackButtonBackgroundVerticalPositionAdjustment:(CGFloat)adjustment whenContainedIn:(Class<UIAppearanceContainer>)containerClass;
+ (CGFloat)backButtonBackgroundVerticalPositionAdjustmentForBarMetrics:(UIBarMetrics)barMetrics;
+ (void)setBackButtonBackgroundVerticalPositionAdjustment:(CGFloat)adjustment forBarMetrics:(UIBarMetrics)barMetrics;
+ (CGFloat)backButtonBackgroundVerticalPositionAdjustmentForBarMetrics:(UIBarMetrics)barMetrics whenContainedIn:(Class<UIAppearanceContainer>)containerClass;
+ (void)setBackButtonBackgroundVerticalPositionAdjustment:(CGFloat)adjustment forBarMetrics:(UIBarMetrics)barMetrics whenContainedIn:(Class<UIAppearanceContainer>)containerClass;

#pragma mark - backButtonTitlePositionAdjustment -

+ (UIOffset)defaultBackButtonTitlePositionAdjustment;
+ (void)setDefaultBackButtonTitlePositionAdjustment:(UIOffset)adjustment;
+ (UIOffset)defaultBackButtonTitlePositionAdjustmentWhenContainedIn:(Class<UIAppearanceContainer>)containerClass;
+ (void)setDefaultBackButtonTitlePositionAdjustment:(UIOffset)adjustment whenContainedIn:(Class<UIAppearanceContainer>)containerClass;
+ (UIOffset)backButtonTitlePositionAdjustmentForBarMetrics:(UIBarMetrics)barMetrics;
+ (void)setBackButtonTitlePositionAdjustment:(UIOffset)adjustment forBarMetrics:(UIBarMetrics)barMetrics;
+ (UIOffset)backButtonTitlePositionAdjustmentForBarMetrics:(UIBarMetrics)barMetrics whenContainedIn:(Class<UIAppearanceContainer>)containerClass;
+ (void)setBackButtonTitlePositionAdjustment:(UIOffset)adjustment forBarMetrics:(UIBarMetrics)barMetrics whenContainedIn:(Class<UIAppearanceContainer>)containerClass;

#pragma mark - text attributes with container -

+ (UIFont *)textFontForState:(UIControlState)state whenContainedIn:(Class<UIAppearanceContainer>)containerClass;
+ (void)setTextFont:(UIFont *)textFont forState:(UIControlState)state whenContainedIn:(Class<UIAppearanceContainer>)containerClass;

+ (UIColor *)textColorForState:(UIControlState)state whenContainedIn:(Class<UIAppearanceContainer>)containerClass;
+ (void)setTextColor:(UIColor *)textColor forState:(UIControlState)state whenContainedIn:(Class<UIAppearanceContainer>)containerClass;

+ (UIColor *)textShadowColorForState:(UIControlState)state whenContainedIn:(Class<UIAppearanceContainer>)containerClass;
+ (void)setTextShadowColor:(UIColor *)textShadowColor forState:(UIControlState)state whenContainedIn:(Class<UIAppearanceContainer>)containerClass;

+ (CGSize)textShadowOffsetForState:(UIControlState)state whenContainedIn:(Class<UIAppearanceContainer>)containerClass;
+ (void)setTextShadowOffset:(CGSize)textShadowOffset forState:(UIControlState)state whenContainedIn:(Class<UIAppearanceContainer>)containerClass;

+ (CGFloat)textShadowSizeForState:(UIControlState)state whenContainedIn:(Class<UIAppearanceContainer>)containerClass;
+ (void)setTextShadowSize:(CGFloat)textShadowSize forState:(UIControlState)state whenContainedIn:(Class<UIAppearanceContainer>)containerClass;

@end

#endif /* ZUtilsX_UIBarButtonItem_ZUX_h */
