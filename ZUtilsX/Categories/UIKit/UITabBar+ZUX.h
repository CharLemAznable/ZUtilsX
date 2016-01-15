//
//  UITabBar+ZUX.h
//  ZUtilsX
//
//  Created by Char Aznable on 15/12/14.
//  Copyright © 2015年 org.cuc.n3. All rights reserved.
//

#ifndef ZUtilsX_UITabBar_ZUX_h
#define ZUtilsX_UITabBar_ZUX_h

#import <UIKit/UIKit.h>
#import "ZUXCategory.h"
#import "zobjc.h"
#import "zarc.h"

@category_interface(UITabBar, ZUX)

@property (nonatomic, readonly) NSArray ZUX_GENERIC(UIView *) *barButtons;

@end // UITabBar (ZUX)

@category_interface(UITabBar, ZUXAppearance)

#if __IPHONE_OS_VERSION_MAX_ALLOWED < 70000
@property (nonatomic, getter=isTranslucent) BOOL translucent;
#endif
+ (BOOL)isTranslucent;
+ (void)setTranslucent:(BOOL)translucent;

+ (UIColor *)tintColor;
+ (void)setTintColor:(UIColor *)tintColor;

#if __IPHONE_OS_VERSION_MAX_ALLOWED < 70000
@property (nonatomic, ZUX_STRONG) UIColor *barTintColor UI_APPEARANCE_SELECTOR;
#endif
+ (UIColor *)barTintColor;
+ (void)setBarTintColor:(UIColor *)barTintColor;

+ (UIImage *)backgroundImage;
+ (void)setBackgroundImage:(UIImage *)backgroundImage;

+ (UIColor *)backgroundColor;
+ (void)setBackgroundColor:(UIColor *)backgroundColor;

+ (UIImage *)selectionIndicatorImage;
+ (void)setSelectionIndicatorImage:(UIImage *)selectionIndicatorImage;

@property (nonatomic, ZUX_STRONG) UIColor *selectionIndicatorColor;
+ (UIColor *)selectionIndicatorColor;
+ (void)setSelectionIndicatorColor:(UIColor *)selectionIndicatorColor;

#if __IPHONE_OS_VERSION_MIN_REQUIRED >= 80000
@property (nonatomic, ZUX_STRONG) UIColor *selectedImageTintColor;
#endif
+ (UIColor *)selectedImageTintColor;
+ (void)setSelectedImageTintColor:(UIColor *)selectedImageTintColor;

@end // UITabBar (ZUXAppearance)

#endif /* ZUtilsX_UITabBar_ZUX_h */
