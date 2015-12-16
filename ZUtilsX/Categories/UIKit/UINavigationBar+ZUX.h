//
//  UINavigationBar+ZUX.h
//  ZUtilsX
//
//  Created by Char Aznable on 15/12/10.
//  Copyright © 2015年 org.cuc.n3. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZUXCategory.h"

#ifndef ZUtilsX_UINavigationBar_ZUX_h
#define ZUtilsX_UINavigationBar_ZUX_h

ZUX_CATEGORY_H(ZUX_UINavigationBar)

@interface UINavigationBar (ZUX)

+ (BOOL)isTranslucent;
+ (void)setTranslucent:(BOOL)translucent;

+ (UIImage *)defaultBackgroundImage;
+ (void)setDefaultBackgroundImage:(UIImage *)backgroundImage;
+ (UIImage *)backgroundImageForBarMetrics:(UIBarMetrics)barMetrics;
+ (void)setBackgroundImage:(UIImage *)backgroundImage forBarMetrics:(UIBarMetrics)barMetrics;

+ (UIColor *)tintColor;
+ (void)setTintColor:(UIColor *)tintColor;

+ (UIFont *)textFont;
+ (void)setTextFont:(UIFont *)textFont;

+ (UIColor *)textColor;
+ (void)setTextColor:(UIColor *)textColor;

+ (UIColor *)textShadowColor;
+ (void)setTextShadowColor:(UIColor *)textShadowColor;

+ (CGSize)textShadowOffset;
+ (void)setTextShadowOffset:(CGSize)textShadowOffset;

+ (CGFloat)textShadowSize;
+ (void)setTextShadowSize:(CGFloat)textShadowSize;

@end

#endif /* ZUtilsX_UINavigationBar_ZUX_h */
