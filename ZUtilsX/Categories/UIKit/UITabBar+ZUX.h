//
//  UITabBar+ZUX.h
//  ZUtilsX
//
//  Created by Char Aznable on 15/12/14.
//  Copyright © 2015年 org.cuc.n3. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZUXCategory.h"
#import "zobjc.h"
#import "zarc.h"

#ifndef ZUtilsX_UITabBar_ZUX_h
#define ZUtilsX_UITabBar_ZUX_h

ZUX_CATEGORY_H(ZUX_UITabBar)

@interface UITabBar (ZUX)

@property (nonatomic, readonly) NSArray ZUX_GENERIC(UIView *) *barButtons;

@end // UITabBar (ZUX)

@interface UITabBar (ZUXAppearance)

#if __IPHONE_OS_VERSION_MAX_ALLOWED < 70000
@property (nonatomic, getter=isTranslucent) BOOL translucent;
#endif
+ (BOOL)isTranslucent;
+ (void)setTranslucent:(BOOL)translucent;

+ (UIImage *)backgroundImage;
+ (void)setBackgroundImage:(UIImage *)backgroundImage;

+ (UIImage *)selectionIndicatorImage;
+ (void)setSelectionIndicatorImage:(UIImage *)selectionIndicatorImage;

+ (UIColor *)tintColor;
+ (void)setTintColor:(UIColor *)tintColor;

+ (UIColor *)barTintColor;
+ (void)setBarTintColor:(UIColor *)barTintColor;

#if __IPHONE_OS_VERSION_MIN_REQUIRED >= 80000
@property (nonatomic, ZUX_STRONG) UIColor *selectedImageTintColor;
#endif
+ (UIColor *)selectedImageTintColor;
+ (void)setSelectedImageTintColor:(UIColor *)selectedImageTintColor;

@end // UITabBar (ZUXAppearance)

#endif /* ZUtilsX_UITabBar_ZUX_h */
