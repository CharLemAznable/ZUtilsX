//
//  UINavigationBar+ZUX.h
//  ZUtilsX
//
//  Created by Char Aznable on 15/12/10.
//  Copyright © 2015年 org.cuc.n3. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZUXCategory.h"
#import "zarc.h"

#ifndef ZUtilsX_UINavigationBar_ZUX_h
#define ZUtilsX_UINavigationBar_ZUX_h

@category_interface(UINavigationBar, ZUXAppearance)

+ (BOOL)isTranslucent;
+ (void)setTranslucent:(BOOL)translucent;

+ (UIColor *)tintColor;
+ (void)setTintColor:(UIColor *)tintColor;

#if __IPHONE_OS_VERSION_MAX_ALLOWED < 70000
@property (nonatomic, ZUX_STRONG) UIColor *barTintColor UI_APPEARANCE_SELECTOR;
#endif
+ (UIColor *)barTintColor;
+ (void)setBarTintColor:(UIColor *)barTintColor;

@property (nonatomic, ZUX_STRONG) UIImage *defaultBackgroundImage;
+ (UIImage *)defaultBackgroundImage;
+ (void)setDefaultBackgroundImage:(UIImage *)backgroundImage;

+ (UIImage *)backgroundImageForBarMetrics:(UIBarMetrics)barMetrics;
+ (void)setBackgroundImage:(UIImage *)backgroundImage forBarMetrics:(UIBarMetrics)barMetrics;

@property (nonatomic, ZUX_STRONG) UIColor *defaultBackgroundColor;
+ (UIColor *)defaultBackgroundColor;
+ (void)setDefaultBackgroundColor:(UIColor *)backgroundColor;

- (UIColor *)backgroundColorForBarMetrics:(UIBarMetrics)barMetrics;
- (void)setBackgroundColor:(UIColor *)backgroundColor forBarMetrics:(UIBarMetrics)barMetrics;
+ (UIColor *)backgroundColorForBarMetrics:(UIBarMetrics)barMetrics;
+ (void)setBackgroundColor:(UIColor *)backgroundColor forBarMetrics:(UIBarMetrics)barMetrics;

@property (nonatomic, ZUX_STRONG) UIFont *textFont;
+ (UIFont *)textFont;
+ (void)setTextFont:(UIFont *)textFont;

@property (nonatomic, ZUX_STRONG) UIColor *textColor;
+ (UIColor *)textColor;
+ (void)setTextColor:(UIColor *)textColor;

@property (nonatomic, ZUX_STRONG) UIColor *textShadowColor;
+ (UIColor *)textShadowColor;
+ (void)setTextShadowColor:(UIColor *)textShadowColor;

@property (nonatomic)             CGSize textShadowOffset;
+ (CGSize)textShadowOffset;
+ (void)setTextShadowOffset:(CGSize)textShadowOffset;

@property (nonatomic)             CGFloat textShadowSize;
+ (CGFloat)textShadowSize;
+ (void)setTextShadowSize:(CGFloat)textShadowSize;

@end

#endif /* ZUtilsX_UINavigationBar_ZUX_h */
