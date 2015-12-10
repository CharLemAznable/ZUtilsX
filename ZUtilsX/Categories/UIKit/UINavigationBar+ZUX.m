//
//  UINavigationBar+ZUX.m
//  ZUtilsX
//
//  Created by Char Aznable on 15/12/10.
//  Copyright © 2015年 org.cuc.n3. All rights reserved.
//

#import "UINavigationBar+ZUX.h"
#import "zarc.h"
#import "zadapt.h"
#import "ZUXGeometry.h"

@implementation UINavigationBar (ZUX)

#define APPEARANCE [self appearance]

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

#define TitleTextAttributeForKey(key) \
[[APPEARANCE titleTextAttributes] objectForKey:(key)]

#define SetTitleTextAttributeForKey(key, value) \
NSMutableDictionary *attributes = ZUX_AUTORELEASE([[APPEARANCE titleTextAttributes] mutableCopy]); \
[attributes setObject:(value) forKey:(key)]; \
[APPEARANCE setTitleTextAttributes:attributes];

+ (UIFont *)textFont {
    return TitleTextAttributeForKey(ZUXFontAttributeName);
}

+ (void)setTextFont:(UIFont *)textFont {
    SetTitleTextAttributeForKey(ZUXFontAttributeName, textFont);
}

+ (UIColor *)textColor {
    return TitleTextAttributeForKey(ZUXForegroundColorAttributeName);
}

+ (void)setTextColor:(UIColor *)textColor {
    SetTitleTextAttributeForKey(ZUXForegroundColorAttributeName, textColor);
}

#define TitleShadowAttribute \
TitleTextAttributeForKey(NSShadowAttributeName) ?: ZUX_AUTORELEASE([[NSShadow alloc] init])

+ (UIColor *)textShadowColor {
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= 60000
    return ((NSShadow *)TitleTextAttributeForKey(NSShadowAttributeName)).shadowColor;
#else
    return TitleTextAttributeForKey(UITextAttributeTextShadowColor);
#endif
}

+ (void)setTextShadowColor:(UIColor *)textShadowColor {
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= 60000
    NSShadow *shadow = TitleShadowAttribute;
    [shadow setShadowColor:textShadowColor];
    SetTitleTextAttributeForKey(NSShadowAttributeName, shadow);
#else
    SetTitleTextAttributeForKey(UITextAttributeTextShadowColor, textShadowColor);
#endif
}

+ (CGSize)textShadowOffset {
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= 60000
    return ((NSShadow *)TitleTextAttributeForKey(NSShadowAttributeName)).shadowOffset;
#else
    return ZUX_CGSizeFromUIOffset([TitleTextAttributeForKey(UITextAttributeTextShadowOffset) UIOffsetValue]);
#endif
}

+ (void)setTextShadowOffset:(CGSize)textShadowOffset {
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= 60000
    NSShadow *shadow = TitleShadowAttribute;
    [shadow setShadowOffset:textShadowOffset];
    SetTitleTextAttributeForKey(NSShadowAttributeName, shadow);
#else
    NSValue *offsetValue = [NSValue valueWithUIOffset:ZUX_UIOffsetFromCGSize(textShadowOffset)];
    SetTitleTextAttributeForKey(UITextAttributeTextShadowOffset, offsetValue);
#endif
}

#if __IPHONE_OS_VERSION_MIN_REQUIRED >= 60000

+ (CGFloat)textShadowSize {
    return ((NSShadow *)TitleTextAttributeForKey(NSShadowAttributeName)).shadowBlurRadius;
}

+ (void)setTextShadowSize:(CGFloat)textShadowSize {
    NSShadow *shadow = TitleShadowAttribute;
    [shadow setShadowBlurRadius:textShadowSize];
    SetTitleTextAttributeForKey(NSShadowAttributeName, shadow);
}

#endif // __IPHONE_OS_VERSION_MIN_REQUIRED >= 60000

@end
