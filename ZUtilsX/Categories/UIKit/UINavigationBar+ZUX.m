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

ZUX_CATEGORY_M(ZUX_UINavigationBar)

@implementation UINavigationBar (ZUX)

+ (BOOL)isTranslucent {
    return [APPEARANCE isTranslucent];
}

+ (void)setTranslucent:(BOOL)translucent {
    [APPEARANCE setTranslucent:translucent];
}

+ (UIImage *)defaultBackgroundImage {
    return [self backgroundImageForBarMetrics:UIBarMetricsDefault];
}

+ (void)setDefaultBackgroundImage:(UIImage *)backgroundImage {
    [self setBackgroundImage:backgroundImage forBarMetrics:UIBarMetricsDefault];
}

+ (UIImage *)backgroundImageForBarMetrics:(UIBarMetrics)barMetrics {
    return [APPEARANCE backgroundImageForBarMetrics:barMetrics];
}

+ (void)setBackgroundImage:(UIImage *)backgroundImage forBarMetrics:(UIBarMetrics)barMetrics {
    [APPEARANCE setBackgroundImage:backgroundImage forBarMetrics:barMetrics];
}

+ (UIColor *)tintColor {
    return [APPEARANCE tintColor];
}

+ (void)setTintColor:(UIColor *)tintColor {
    [APPEARANCE setTintColor:tintColor];
}

+ (UIFont *)textFont {
    return TitleTextAttributeForKey(ZUXFontAttributeName);
}

+ (void)setTextFont:(UIFont *)textFont {
    SetTitleTextAttributeForKey(textFont, ZUXFontAttributeName);
}

+ (UIColor *)textColor {
    return TitleTextAttributeForKey(ZUXForegroundColorAttributeName);
}

+ (void)setTextColor:(UIColor *)textColor {
    SetTitleTextAttributeForKey(textColor, ZUXForegroundColorAttributeName);
}

+ (UIColor *)textShadowColor {
    return
#if __IPHONE_OS_VERSION_MIN_REQUIRED < 60000
    IOS6_OR_LATER ?
#endif
    TitleShadowAttribute.shadowColor
#if __IPHONE_OS_VERSION_MIN_REQUIRED < 60000
    : TitleTextAttributeForKey(UITextAttributeTextShadowColor)
#endif
    ;
}

+ (void)setTextShadowColor:(UIColor *)textShadowColor {
#if __IPHONE_OS_VERSION_MIN_REQUIRED < 60000
    if (IOS6_OR_LATER) {
#endif
        NSShadow *shadow = DefaultTitleShadowAttribute;
        [shadow setShadowColor:textShadowColor];
        SetTitleShadowAttribute(shadow);
#if __IPHONE_OS_VERSION_MIN_REQUIRED < 60000
    } else {
        SetTitleTextAttributeForKey(textShadowColor, UITextAttributeTextShadowColor);
    }
#endif
}

+ (CGSize)textShadowOffset {
    return
#if __IPHONE_OS_VERSION_MIN_REQUIRED < 60000
    IOS6_OR_LATER ?
#endif
    TitleShadowAttribute.shadowOffset
#if __IPHONE_OS_VERSION_MIN_REQUIRED < 60000
    : ZUX_CGSizeFromUIOffset([TitleTextAttributeForKey(UITextAttributeTextShadowOffset) UIOffsetValue])
#endif
    ;
}

+ (void)setTextShadowOffset:(CGSize)textShadowOffset {
#if __IPHONE_OS_VERSION_MIN_REQUIRED < 60000
    if (IOS6_OR_LATER) {
#endif
        NSShadow *shadow = DefaultTitleShadowAttribute;
        [shadow setShadowOffset:textShadowOffset];
        SetTitleShadowAttribute(shadow);
#if __IPHONE_OS_VERSION_MIN_REQUIRED < 60000
    } else {
        NSValue *offsetValue = [NSValue valueWithUIOffset:ZUX_UIOffsetFromCGSize(textShadowOffset)];
        SetTitleTextAttributeForKey(offsetValue, UITextAttributeTextShadowOffset);
    }
#endif
}

+ (CGFloat)textShadowSize {
    return
#if __IPHONE_OS_VERSION_MIN_REQUIRED < 60000
    IOS6_OR_LATER ?
#endif
    TitleShadowAttribute.shadowBlurRadius
#if __IPHONE_OS_VERSION_MIN_REQUIRED < 60000
    : 0
#endif
    ;
}

+ (void)setTextShadowSize:(CGFloat)textShadowSize {
#if __IPHONE_OS_VERSION_MIN_REQUIRED < 60000
    if (IOS6_OR_LATER) {
#endif
        NSShadow *shadow = DefaultTitleShadowAttribute;
        [shadow setShadowBlurRadius:textShadowSize];
        SetTitleShadowAttribute(shadow);
#if __IPHONE_OS_VERSION_MIN_REQUIRED < 60000
    }
#endif
}

@end
