//
//  UIBarItem+ZUX.m
//  ZUtilsX
//
//  Created by Char Aznable on 15/12/14.
//  Copyright © 2015年 org.cuc.n3. All rights reserved.
//

#import "UIBarItem+ZUX.h"
#import "ZUXGeometry.h"
#import "zadapt.h"
#import "zappearance.h"

@category_implementation(UIBarItem, ZUXAppearance)

#pragma mark - textFont -

- (UIFont *)textFontForState:(UIControlState)state {
    return titleTextAttributeForStateAndKey(self, state, ZUXFontAttributeName);
}

- (void)setTextFont:(UIFont *)textFont forState:(UIControlState)state {
    setTitleTextAttributeForStateAndKey(self, state, ZUXFontAttributeName, textFont);
}

+ (UIFont *)textFontForState:(UIControlState)state {
    return titleTextAttributeForStateAndKey(APPEARANCE, state, ZUXFontAttributeName);
}

+ (void)setTextFont:(UIFont *)textFont forState:(UIControlState)state {
    setTitleTextAttributeForStateAndKey(APPEARANCE, state, ZUXFontAttributeName, textFont);
}

#pragma mark - textColor -

- (UIColor *)textColorForState:(UIControlState)state {
    return titleTextAttributeForStateAndKey(self, state, ZUXForegroundColorAttributeName);
}

- (void)setTextColor:(UIColor *)textColor forState:(UIControlState)state {
    setTitleTextAttributeForStateAndKey(self, state, ZUXForegroundColorAttributeName, textColor);
}

+ (UIColor *)textColorForState:(UIControlState)state {
    return titleTextAttributeForStateAndKey(APPEARANCE, state, ZUXForegroundColorAttributeName);
}

+ (void)setTextColor:(UIColor *)textColor forState:(UIControlState)state {
    setTitleTextAttributeForStateAndKey(APPEARANCE, state, ZUXForegroundColorAttributeName, textColor);
}

#pragma mark - textShadowColor -

- (UIColor *)textShadowColorForState:(UIControlState)state {
    return
#if __IPHONE_OS_VERSION_MIN_REQUIRED < 60000
    !IOS6_OR_LATER ? titleTextAttributeForStateAndKey(self, state, UITextAttributeTextShadowColor) :
#endif
    titleShadowAttributeForState(self, state).shadowColor;
}

- (void)setTextShadowColor:(UIColor *)textShadowColor forState:(UIControlState)state {
#if __IPHONE_OS_VERSION_MIN_REQUIRED < 60000
    if (!IOS6_OR_LATER) {
        setTitleTextAttributeForStateAndKey(self, state, UITextAttributeTextShadowColor, textShadowColor);
        return;
    }
#endif
    NSShadow *shadow = defaultTitleShadowAttributeForState(self, state);
    [shadow setShadowColor:textShadowColor];
    setTitleShadowAttributeForState(self, state, shadow);
}

+ (UIColor *)textShadowColorForState:(UIControlState)state {
    return
#if __IPHONE_OS_VERSION_MIN_REQUIRED < 60000
    !IOS6_OR_LATER ? titleTextAttributeForStateAndKey(APPEARANCE, state, UITextAttributeTextShadowColor) :
#endif
    titleShadowAttributeForState(APPEARANCE, state).shadowColor;
}

+ (void)setTextShadowColor:(UIColor *)textShadowColor forState:(UIControlState)state {
#if __IPHONE_OS_VERSION_MIN_REQUIRED < 60000
    if (!IOS6_OR_LATER) {
        setTitleTextAttributeForStateAndKey(APPEARANCE, state, UITextAttributeTextShadowColor, textShadowColor);
        return;
    }
#endif
    NSShadow *shadow = defaultTitleShadowAttributeForState(APPEARANCE, state);
    [shadow setShadowColor:textShadowColor];
    setTitleShadowAttributeForState(APPEARANCE, state, shadow);
}

#pragma mark - textShadowOffset -

- (CGSize)textShadowOffsetForState:(UIControlState)state {
    return
#if __IPHONE_OS_VERSION_MIN_REQUIRED < 60000
    !IOS6_OR_LATER ? ZUX_CGSizeFromUIOffset
    ([titleTextAttributeForStateAndKey(self, state, UITextAttributeTextShadowOffset) UIOffsetValue]) :
#endif
    titleShadowAttributeForState(self, state).shadowOffset;
}

- (void)setTextShadowOffset:(CGSize)textShadowOffset forState:(UIControlState)state {
#if __IPHONE_OS_VERSION_MIN_REQUIRED < 60000
    if (!IOS6_OR_LATER) {
        setTitleTextAttributeForStateAndKey(self, state, UITextAttributeTextShadowOffset,
                                            [NSValue valueWithUIOffset:ZUX_UIOffsetFromCGSize(textShadowOffset)]);
        return;
    }
#endif
    NSShadow *shadow = defaultTitleShadowAttributeForState(self, state);
    [shadow setShadowOffset:textShadowOffset];
    setTitleShadowAttributeForState(self, state, shadow);
}

+ (CGSize)textShadowOffsetForState:(UIControlState)state {
    return
#if __IPHONE_OS_VERSION_MIN_REQUIRED < 60000
    !IOS6_OR_LATER ? ZUX_CGSizeFromUIOffset
    ([titleTextAttributeForStateAndKey(APPEARANCE, state, UITextAttributeTextShadowOffset) UIOffsetValue]) :
#endif
    titleShadowAttributeForState(APPEARANCE, state).shadowOffset;
}

+ (void)setTextShadowOffset:(CGSize)textShadowOffset forState:(UIControlState)state {
#if __IPHONE_OS_VERSION_MIN_REQUIRED < 60000
    if (!IOS6_OR_LATER) {
        setTitleTextAttributeForStateAndKey(APPEARANCE, state, UITextAttributeTextShadowOffset,
                                            [NSValue valueWithUIOffset:ZUX_UIOffsetFromCGSize(textShadowOffset)]);
        return;
    }
#endif
    NSShadow *shadow = defaultTitleShadowAttributeForState(APPEARANCE, state);
    [shadow setShadowOffset:textShadowOffset];
    setTitleShadowAttributeForState(APPEARANCE, state, shadow);
}

#pragma mark - textShadowSize -

- (CGFloat)textShadowSizeForState:(UIControlState)state {
    return
#if __IPHONE_OS_VERSION_MIN_REQUIRED < 60000
    !IOS6_OR_LATER ? 0 :
#endif
    titleShadowAttributeForState(self, state).shadowBlurRadius;
}

- (void)setTextShadowSize:(CGFloat)textShadowSize forState:(UIControlState)state {
#if __IPHONE_OS_VERSION_MIN_REQUIRED < 60000
    if (!IOS6_OR_LATER) return;
#endif
    NSShadow *shadow = defaultTitleShadowAttributeForState(self, state);
    [shadow setShadowBlurRadius:textShadowSize];
    setTitleShadowAttributeForState(self, state, shadow);
}

+ (CGFloat)textShadowSizeForState:(UIControlState)state {
    return
#if __IPHONE_OS_VERSION_MIN_REQUIRED < 60000
    !IOS6_OR_LATER ? 0 :
#endif
    titleShadowAttributeForState(APPEARANCE, state).shadowBlurRadius;
}

+ (void)setTextShadowSize:(CGFloat)textShadowSize forState:(UIControlState)state {
#if __IPHONE_OS_VERSION_MIN_REQUIRED < 60000
    if (!IOS6_OR_LATER) return;
#endif
    NSShadow *shadow = defaultTitleShadowAttributeForState(APPEARANCE, state);
    [shadow setShadowBlurRadius:textShadowSize];
    setTitleShadowAttributeForState(APPEARANCE, state, shadow);
}

@end
