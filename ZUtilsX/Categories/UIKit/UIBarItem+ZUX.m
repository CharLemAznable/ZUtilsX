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

ZUX_CATEGORY_M(ZUX_UIBarItem)

@implementation UIBarItem (ZUX)

+ (UIFont *)textFontForState:(UIControlState)state {
    return TitleTextAttributeForKeyAndState(ZUXFontAttributeName, state);
}

+ (void)setTextFont:(UIFont *)textFont forState:(UIControlState)state {
    SetTitleTextAttributeForKeyAndState(textFont, ZUXFontAttributeName, state);
}

+ (UIColor *)textColorForState:(UIControlState)state {
    return TitleTextAttributeForKeyAndState(ZUXForegroundColorAttributeName, state);
}

+ (void)setTextColor:(UIColor *)textColor forState:(UIControlState)state {
    SetTitleTextAttributeForKeyAndState(textColor, ZUXForegroundColorAttributeName, state);
}

+ (UIColor *)textShadowColorForState:(UIControlState)state {
    return
#if __IPHONE_OS_VERSION_MIN_REQUIRED < 60000
    IOS6_OR_LATER ?
#endif
    TitleShadowAttributeForState(state).shadowColor
#if __IPHONE_OS_VERSION_MIN_REQUIRED < 60000
    : TitleTextAttributeForKeyAndState(UITextAttributeTextShadowColor, state)
#endif
    ;
}

+ (void)setTextShadowColor:(UIColor *)textShadowColor forState:(UIControlState)state {
#if __IPHONE_OS_VERSION_MIN_REQUIRED < 60000
    if (IOS6_OR_LATER) {
#endif
        NSShadow *shadow = DefaultTitleShadowAttributeForState(state);
        [shadow setShadowColor:textShadowColor];
        SetTitleShadowAttributeForState(shadow, state);
#if __IPHONE_OS_VERSION_MIN_REQUIRED < 60000
    } else {
        SetTitleTextAttributeForKeyAndState(textShadowColor, UITextAttributeTextShadowColor, state);
    }
#endif
}

+ (CGSize)textShadowOffsetForState:(UIControlState)state {
    return
#if __IPHONE_OS_VERSION_MIN_REQUIRED < 60000
    IOS6_OR_LATER ?
#endif
    TitleShadowAttributeForState(state).shadowOffset
#if __IPHONE_OS_VERSION_MIN_REQUIRED < 60000
    : ZUX_CGSizeFromUIOffset([TitleTextAttributeForKeyAndState(UITextAttributeTextShadowOffset, state) UIOffsetValue])
#endif
    ;
}

+ (void)setTextShadowOffset:(CGSize)textShadowOffset forState:(UIControlState)state {
#if __IPHONE_OS_VERSION_MIN_REQUIRED < 60000
    if (IOS6_OR_LATER) {
#endif
        NSShadow *shadow = DefaultTitleShadowAttributeForState(state);
        [shadow setShadowOffset:textShadowOffset];
        SetTitleShadowAttributeForState(shadow, state);
#if __IPHONE_OS_VERSION_MIN_REQUIRED < 60000
    } else {
        NSValue *offsetValue = [NSValue valueWithUIOffset:ZUX_UIOffsetFromCGSize(textShadowOffset)];
        SetTitleTextAttributeForKeyAndState(offsetValue, UITextAttributeTextShadowOffset, state);
    }
#endif
}

+ (CGFloat)textShadowSizeForState:(UIControlState)state {
    return
#if __IPHONE_OS_VERSION_MIN_REQUIRED < 60000
    IOS6_OR_LATER ?
#endif
    TitleShadowAttributeForState(state).shadowBlurRadius
#if __IPHONE_OS_VERSION_MIN_REQUIRED < 60000
    : 0
#endif
    ;
}

+ (void)setTextShadowSize:(CGFloat)textShadowSize forState:(UIControlState)state {
#if __IPHONE_OS_VERSION_MIN_REQUIRED < 60000
    if (IOS6_OR_LATER) {
#endif
        NSShadow *shadow = DefaultTitleShadowAttributeForState(state);
        [shadow setShadowBlurRadius:textShadowSize];
        SetTitleShadowAttributeForState(shadow, state);
#if __IPHONE_OS_VERSION_MIN_REQUIRED < 60000
    }
#endif
}

@end
