//
//  UINavigationBar+ZUX.m
//  ZUtilsX
//
//  Created by Char Aznable on 15/12/10.
//  Copyright © 2015年 org.cuc.n3. All rights reserved.
//

#import "UINavigationBar+ZUX.h"
#import "ZUXGeometry.h"
#import "zadapt.h"
#import "zappearance.h"

@category_implementation(UINavigationBar, ZUXAppearance)

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

#if __IPHONE_OS_VERSION_MAX_ALLOWED < 70000
- (UIColor *)barTintColor {
    return nil;
}

- (void)setBarTintColor:(UIColor *)barTintColor {
}
#endif

+ (UIColor *)barTintColor {
    return
#if __IPHONE_OS_VERSION_MIN_REQUIRED < 70000
    BEFORE_IOS7 ? nil :
#endif
    [APPEARANCE barTintColor];
}

+ (void)setBarTintColor:(UIColor *)barTintColor {
#if __IPHONE_OS_VERSION_MIN_REQUIRED < 70000
    if (BEFORE_IOS7) return;
#endif
    [APPEARANCE setBarTintColor:barTintColor];
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

#pragma mark - backgroundColor -

- (UIColor *)defaultBackgroundColor {
    return [self backgroundColorForBarMetrics:UIBarMetricsDefault];
}

- (void)setDefaultBackgroundColor:(UIColor *)backgroundColor {
    [self setBackgroundColor:backgroundColor forBarMetrics:UIBarMetricsDefault];
}

+ (UIColor *)defaultBackgroundColor {
    return [self backgroundColorForBarMetrics:UIBarMetricsDefault];
}

+ (void)setDefaultBackgroundColor:(UIColor *)backgroundColor {
    [self setBackgroundColor:backgroundColor forBarMetrics:UIBarMetricsDefault];
}

- (UIColor *)backgroundColorForBarMetrics:(UIBarMetrics)barMetrics {
    return backgroundColorForBarMetrics(self, barMetrics);
}

- (void)setBackgroundColor:(UIColor *)backgroundColor forBarMetrics:(UIBarMetrics)barMetrics {
    setBackgroundColorForBarMetrics(self, backgroundColor, barMetrics);
}

+ (UIColor *)backgroundColorForBarMetrics:(UIBarMetrics)barMetrics {
    return backgroundColorForBarMetrics(APPEARANCE, barMetrics);
}

+ (void)setBackgroundColor:(UIColor *)backgroundColor forBarMetrics:(UIBarMetrics)barMetrics {
    setBackgroundColorForBarMetrics(APPEARANCE, backgroundColor, barMetrics);
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
    BEFORE_IOS6 ? titleTextAttributeForKey(self, UITextAttributeTextShadowColor) :
#endif
    titleShadowAttribute(self).shadowColor;
}

- (void)setTextShadowColor:(UIColor *)textShadowColor {
#if __IPHONE_OS_VERSION_MIN_REQUIRED < 60000
    if (BEFORE_IOS6) {
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
    BEFORE_IOS6 ? titleTextAttributeForKey(APPEARANCE, UITextAttributeTextShadowColor) :
#endif
    titleShadowAttribute(APPEARANCE).shadowColor;
}

+ (void)setTextShadowColor:(UIColor *)textShadowColor {
#if __IPHONE_OS_VERSION_MIN_REQUIRED < 60000
    if (BEFORE_IOS6) {
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
    BEFORE_IOS6 ? ZUX_CGSizeFromUIOffset
    ([titleTextAttributeForKey(self, UITextAttributeTextShadowOffset) UIOffsetValue]) :
#endif
    titleShadowAttribute(self).shadowOffset;
}

- (void)setTextShadowOffset:(CGSize)textShadowOffset {
#if __IPHONE_OS_VERSION_MIN_REQUIRED < 60000
    if (BEFORE_IOS6) {
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
    BEFORE_IOS6 ? ZUX_CGSizeFromUIOffset
    ([titleTextAttributeForKey(APPEARANCE, UITextAttributeTextShadowOffset) UIOffsetValue]) :
#endif
    titleShadowAttribute(APPEARANCE).shadowOffset;
}

+ (void)setTextShadowOffset:(CGSize)textShadowOffset {
#if __IPHONE_OS_VERSION_MIN_REQUIRED < 60000
    if (BEFORE_IOS6) {
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
    BEFORE_IOS6 ? 0 :
#endif
    titleShadowAttribute(self).shadowBlurRadius;
}

- (void)setTextShadowSize:(CGFloat)textShadowSize {
#if __IPHONE_OS_VERSION_MIN_REQUIRED < 60000
    if (BEFORE_IOS6) return;
#endif
    NSShadow *shadow = defaultTitleShadowAttribute(self);
    [shadow setShadowBlurRadius:textShadowSize];
    setTitleShadowAttribute(self, shadow);
}

+ (CGFloat)textShadowSize {
    return
#if __IPHONE_OS_VERSION_MIN_REQUIRED < 60000
    BEFORE_IOS6 ? 0 :
#endif
    titleShadowAttribute(APPEARANCE).shadowBlurRadius;
}

+ (void)setTextShadowSize:(CGFloat)textShadowSize {
#if __IPHONE_OS_VERSION_MIN_REQUIRED < 60000
    if (BEFORE_IOS6) return;
#endif
    NSShadow *shadow = defaultTitleShadowAttribute(APPEARANCE);
    [shadow setShadowBlurRadius:textShadowSize];
    setTitleShadowAttribute(APPEARANCE, shadow);
}

@end
