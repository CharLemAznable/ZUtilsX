//
//  UINavigationBar+ZUX.m
//  ZUtilsX
//
//  Created by Char Aznable on 15/12/10.
//  Copyright © 2015年 org.cuc.n3. All rights reserved.
//

#import "UINavigationBar+ZUX.h"
#import "UIImage+ZUX.h"
#import "ZUXGeometry.h"
#import "zadapt.h"
#import "zappearance.h"

ZUX_CATEGORY_M(ZUX_UINavigationBar)

@implementation UINavigationBar (ZUX)

#pragma mark - translucent -

+ (BOOL)isTranslucent {
    return [APPEARANCE isTranslucent];
}

+ (void)setTranslucent:(BOOL)translucent {
    [APPEARANCE setTranslucent:translucent];
}

#pragma mark - tintColor -

+ (UIColor *)tintColor {
    return [APPEARANCE tintColor];
}

+ (void)setTintColor:(UIColor *)tintColor {
    [APPEARANCE setTintColor:tintColor];
}

#pragma mark - backgroundColor -

- (UIColor *)defaultBackgroundColor {
    return backgroundColorForBarMetrics(self, UIBarMetricsDefault);
}

- (void)setDefaultBackgroundColor:(UIColor *)backgroundColor {
    setBackgroundColorForBarMetrics(self, backgroundColor, UIBarMetricsDefault);
}

+ (UIColor *)defaultBackgroundColor {
    return [self backgroundColorForBarMetrics:UIBarMetricsDefault];
}

+ (void)setDefaultBackgroundColor:(UIColor *)backgroundColor {
    [self setBackgroundColor:backgroundColor forBarMetrics:UIBarMetricsDefault];
}

+ (UIColor *)backgroundColorForBarMetrics:(UIBarMetrics)barMetrics {
    return backgroundColorForBarMetrics(APPEARANCE, barMetrics);
}

+ (void)setBackgroundColor:(UIColor *)backgroundColor forBarMetrics:(UIBarMetrics)barMetrics {
    setBackgroundColorForBarMetrics(APPEARANCE, backgroundColor, barMetrics);
}

#pragma mark - backgroundImage -

- (UIImage *)defaultBackgroundImage {
    return backgroundImageForBarMetrics(self, UIBarMetricsDefault);
}

- (void)setDefaultBackgroundImage:(UIImage *)backgroundImage {
    setBackgroundImageForBarMetrics(self, backgroundImage, UIBarMetricsDefault);
}

+ (UIImage *)defaultBackgroundImage {
    return [self backgroundImageForBarMetrics:UIBarMetricsDefault];
}

+ (void)setDefaultBackgroundImage:(UIImage *)backgroundImage {
    [self setBackgroundImage:backgroundImage forBarMetrics:UIBarMetricsDefault];
}

+ (UIImage *)backgroundImageForBarMetrics:(UIBarMetrics)barMetrics {
    return backgroundImageForBarMetrics(APPEARANCE, barMetrics);
}

+ (void)setBackgroundImage:(UIImage *)backgroundImage forBarMetrics:(UIBarMetrics)barMetrics {
    setBackgroundImageForBarMetrics(APPEARANCE, backgroundImage, barMetrics);
}

#pragma mark - textFont -

- (UIFont *)textFont {
    return titleTextAttributeForKey(self, ZUXFontAttributeName);
}

- (void)setTextFont:(UIFont *)textFont {
    setTitleTextAttributeForKey(self, ZUXFontAttributeName, textFont);
}

+ (UIFont *)textFont {
    return titleTextAttributeForKey(APPEARANCE, ZUXFontAttributeName);
}

+ (void)setTextFont:(UIFont *)textFont {
    setTitleTextAttributeForKey(APPEARANCE, ZUXFontAttributeName, textFont);
}

#pragma mark - textColor -

- (UIColor *)textColor {
    return titleTextAttributeForKey(self, ZUXForegroundColorAttributeName);
}

- (void)setTextColor:(UIColor *)textColor {
    setTitleTextAttributeForKey(self, ZUXForegroundColorAttributeName, textColor);
}

+ (UIColor *)textColor {
    return titleTextAttributeForKey(APPEARANCE, ZUXForegroundColorAttributeName);
}

+ (void)setTextColor:(UIColor *)textColor {
    setTitleTextAttributeForKey(APPEARANCE, ZUXForegroundColorAttributeName, textColor);
}

#pragma mark - textShadowColor -

- (UIColor *)textShadowColor {
    return
#if __IPHONE_OS_VERSION_MIN_REQUIRED < 60000
    !IOS6_OR_LATER ? titleTextAttributeForKey(self, UITextAttributeTextShadowColor) :
#endif
    titleShadowAttribute(self).shadowColor;
}

- (void)setTextShadowColor:(UIColor *)textShadowColor {
#if __IPHONE_OS_VERSION_MIN_REQUIRED < 60000
    if (!IOS6_OR_LATER) {
        setTitleTextAttributeForKey
        (self, UITextAttributeTextShadowColor, textShadowColor);
        return;
    }
#endif
    NSShadow *shadow = defaultTitleShadowAttribute(self);
    [shadow setShadowColor:textShadowColor];
    setTitleShadowAttribute(self, shadow);
}

+ (UIColor *)textShadowColor {
    return
#if __IPHONE_OS_VERSION_MIN_REQUIRED < 60000
    !IOS6_OR_LATER ? titleTextAttributeForKey(APPEARANCE, UITextAttributeTextShadowColor) :
#endif
    titleShadowAttribute(APPEARANCE).shadowColor;
}

+ (void)setTextShadowColor:(UIColor *)textShadowColor {
#if __IPHONE_OS_VERSION_MIN_REQUIRED < 60000
    if (!IOS6_OR_LATER) {
        setTitleTextAttributeForKey
        (APPEARANCE, UITextAttributeTextShadowColor, textShadowColor);
        return;
    }
#endif
    NSShadow *shadow = defaultTitleShadowAttribute(APPEARANCE);
    [shadow setShadowColor:textShadowColor];
    setTitleShadowAttribute(APPEARANCE, shadow);
}

#pragma mark - textShadowOffset -

- (CGSize)textShadowOffset {
    return
#if __IPHONE_OS_VERSION_MIN_REQUIRED < 60000
    !IOS6_OR_LATER ? ZUX_CGSizeFromUIOffset
    ([titleTextAttributeForKey(self, UITextAttributeTextShadowOffset) UIOffsetValue]) :
#endif
    titleShadowAttribute(self).shadowOffset;
}

- (void)setTextShadowOffset:(CGSize)textShadowOffset {
#if __IPHONE_OS_VERSION_MIN_REQUIRED < 60000
    if (!IOS6_OR_LATER) {
        setTitleTextAttributeForKey
        (self, UITextAttributeTextShadowOffset,
         [NSValue valueWithUIOffset:ZUX_UIOffsetFromCGSize(textShadowOffset)]);
        return;
    }
#endif
    NSShadow *shadow = defaultTitleShadowAttribute(self);
    [shadow setShadowOffset:textShadowOffset];
    setTitleShadowAttribute(self, shadow);
}

+ (CGSize)textShadowOffset {
    return
#if __IPHONE_OS_VERSION_MIN_REQUIRED < 60000
    !IOS6_OR_LATER ? ZUX_CGSizeFromUIOffset
    ([titleTextAttributeForKey(APPEARANCE, UITextAttributeTextShadowOffset) UIOffsetValue]) :
#endif
    titleShadowAttribute(APPEARANCE).shadowOffset;
}

+ (void)setTextShadowOffset:(CGSize)textShadowOffset {
#if __IPHONE_OS_VERSION_MIN_REQUIRED < 60000
    if (!IOS6_OR_LATER) {
        setTitleTextAttributeForKey
        (APPEARANCE, UITextAttributeTextShadowOffset,
         [NSValue valueWithUIOffset:ZUX_UIOffsetFromCGSize(textShadowOffset)]);
        return;
    }
#endif
    NSShadow *shadow = defaultTitleShadowAttribute(APPEARANCE);
    [shadow setShadowOffset:textShadowOffset];
    setTitleShadowAttribute(APPEARANCE, shadow);
}

#pragma mark - textShadowSize -

- (CGFloat)textShadowSize {
    return
#if __IPHONE_OS_VERSION_MIN_REQUIRED < 60000
    !IOS6_OR_LATER ? 0 :
#endif
    titleShadowAttribute(self).shadowBlurRadius;
}

- (void)setTextShadowSize:(CGFloat)textShadowSize {
#if __IPHONE_OS_VERSION_MIN_REQUIRED < 60000
    if (!IOS6_OR_LATER) return;
#endif
    NSShadow *shadow = defaultTitleShadowAttribute(self);
    [shadow setShadowBlurRadius:textShadowSize];
    setTitleShadowAttribute(self, shadow);
}

+ (CGFloat)textShadowSize {
    return
#if __IPHONE_OS_VERSION_MIN_REQUIRED < 60000
    !IOS6_OR_LATER ? 0 :
#endif
    titleShadowAttribute(APPEARANCE).shadowBlurRadius;
}

+ (void)setTextShadowSize:(CGFloat)textShadowSize {
#if __IPHONE_OS_VERSION_MIN_REQUIRED < 60000
    if (!IOS6_OR_LATER) return;
#endif
    NSShadow *shadow = defaultTitleShadowAttribute(APPEARANCE);
    [shadow setShadowBlurRadius:textShadowSize];
    setTitleShadowAttribute(APPEARANCE, shadow);
}

#pragma mark - inline implementation -

ZUX_STATIC_INLINE id titleTextAttributeForKey(id instance, NSString *key) {
    return [[instance titleTextAttributes] objectForKey:key];
}

ZUX_STATIC_INLINE void setTitleTextAttributeForKey(id instance, NSString *key, id value) {
    NSMutableDictionary *attributes = ZUX_AUTORELEASE([[instance titleTextAttributes] mutableCopy]);
    [attributes setObject:value forKey:key];
    [instance setTitleTextAttributes:attributes];
}

ZUX_STATIC_INLINE NSShadow *titleShadowAttribute(id instance) {
    return titleTextAttributeForKey(instance, NSShadowAttributeName);
}

ZUX_STATIC_INLINE NSShadow *defaultTitleShadowAttribute(id instance) {
    return titleShadowAttribute(instance) ?: ZUX_AUTORELEASE([[NSShadow alloc] init]);
}

ZUX_STATIC_INLINE void setTitleShadowAttribute(id instance, NSShadow *shadow) {
    setTitleTextAttributeForKey(instance, NSShadowAttributeName, shadow);
}

ZUX_STATIC_INLINE UIColor *backgroundColorForBarMetrics
(ZUX_KINDOF(UINavigationBar *) instance, UIBarMetrics barMetrics) {
    ZUX_ENABLE_CATEGORY(ZUX_UIImage);
    return [[instance backgroundImageForBarMetrics:barMetrics] dominantColor];
}

ZUX_STATIC_INLINE void setBackgroundColorForBarMetrics
(ZUX_KINDOF(UINavigationBar *) instance, UIColor *backgroundColor, UIBarMetrics barMetrics) {
    ZUX_ENABLE_CATEGORY(ZUX_UIImage);
    [instance setBackgroundImage:[UIImage imagePointWithColor:backgroundColor]
                   forBarMetrics:barMetrics];
}

ZUX_STATIC_INLINE UIImage *backgroundImageForBarMetrics
(ZUX_KINDOF(UINavigationBar *) instance, UIBarMetrics barMetrics) {
    return [instance backgroundImageForBarMetrics:barMetrics];
}

ZUX_STATIC_INLINE void setBackgroundImageForBarMetrics
(ZUX_KINDOF(UINavigationBar *) instance, UIImage *backgroundImage, UIBarMetrics barMetrics) {
    [instance setBackgroundImage:backgroundImage forBarMetrics:barMetrics];
}

@end
