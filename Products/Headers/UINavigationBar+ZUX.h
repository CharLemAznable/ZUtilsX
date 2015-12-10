//
//  UINavigationBar+ZUX.h
//  ZUtilsX
//
//  Created by Char Aznable on 15/12/10.
//  Copyright © 2015年 org.cuc.n3. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationBar (ZUX)

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

#if __IPHONE_OS_VERSION_MIN_REQUIRED >= 60000
+ (CGFloat)textShadowSize;
+ (void)setTextShadowSize:(CGFloat)textShadowSize;
#endif

@end
