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
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= 60000
    return TitleShadowAttribute.shadowColor;
#else
    return TitleTextAttributeForKey(UITextAttributeTextShadowColor);
#endif
}

+ (void)setTextShadowColor:(UIColor *)textShadowColor {
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= 60000
    NSShadow *shadow = DefaultTitleShadowAttribute;
    [shadow setShadowColor:textShadowColor];
    SetTitleShadowAttribute(shadow);
#else
    SetTitleTextAttributeForKey(textShadowColor, UITextAttributeTextShadowColor);
#endif
}

+ (CGSize)textShadowOffset {
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= 60000
    return TitleShadowAttribute.shadowOffset;
#else
    return ZUX_CGSizeFromUIOffset([TitleTextAttributeForKey(UITextAttributeTextShadowOffset) UIOffsetValue]);
#endif
}

+ (void)setTextShadowOffset:(CGSize)textShadowOffset {
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= 60000
    NSShadow *shadow = DefaultTitleShadowAttribute;
    [shadow setShadowOffset:textShadowOffset];
    SetTitleShadowAttribute(shadow);
#else
    NSValue *offsetValue = [NSValue valueWithUIOffset:ZUX_UIOffsetFromCGSize(textShadowOffset)];
    SetTitleTextAttributeForKey(offsetValue, UITextAttributeTextShadowOffset);
#endif
}

#if __IPHONE_OS_VERSION_MIN_REQUIRED >= 60000
+ (CGFloat)textShadowSize {
    return TitleShadowAttribute.shadowBlurRadius;
}

+ (void)setTextShadowSize:(CGFloat)textShadowSize {
    NSShadow *shadow = DefaultTitleShadowAttribute;
    [shadow setShadowBlurRadius:textShadowSize];
    SetTitleShadowAttribute(shadow);
}
#endif // __IPHONE_OS_VERSION_MIN_REQUIRED >= 60000

@end
