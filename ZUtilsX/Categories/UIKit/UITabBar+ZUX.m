//
//  UITabBar+ZUX.m
//  ZUtilsX
//
//  Created by Char Aznable on 15/12/14.
//  Copyright © 2015年 org.cuc.n3. All rights reserved.
//

#import "UITabBar+ZUX.h"
#import "zadapt.h"
#import "zappearance.h"

ZUX_CATEGORY_M(ZUX_UITabBar)

@implementation UITabBar (ZUX)

+ (BOOL)isTranslucent {
    return
#if __IPHONE_OS_VERSION_MIN_REQUIRED < 70000
    IOS7_OR_LATER ?
#endif
    [APPEARANCE isTranslucent]
#if __IPHONE_OS_VERSION_MIN_REQUIRED < 70000
    : NO
#endif
    ;
}

+ (void)setTranslucent:(BOOL)translucent {
#if __IPHONE_OS_VERSION_MIN_REQUIRED < 70000
    if (IOS7_OR_LATER)
#endif
        [APPEARANCE setTranslucent:translucent];
}

+ (UIImage *)backgroundImage {
    return [APPEARANCE backgroundImage];
}

+ (void)setBackgroundImage:(UIImage *)backgroundImage {
    [APPEARANCE setBackgroundImage:backgroundImage];
}

+ (UIImage *)selectionIndicatorImage {
    return [APPEARANCE selectionIndicatorImage];
}

+ (void)setSelectionIndicatorImage:(UIImage *)selectionIndicatorImage {
    [APPEARANCE setSelectionIndicatorImage:selectionIndicatorImage];
}

+ (UIColor *)selectedImageTintColor {
    return
#if __IPHONE_OS_VERSION_MIN_REQUIRED < 80000
    IOS8_OR_LATER ?
#endif
    [APPEARANCE tintColor]
#if __IPHONE_OS_VERSION_MIN_REQUIRED < 80000
    : [APPEARANCE selectedImageTintColor]
#endif
    ;
}

+ (void)setSelectedImageTintColor:(UIColor *)selectedImageTintColor {
#if __IPHONE_OS_VERSION_MIN_REQUIRED < 80000
    if (IOS8_OR_LATER) {
#endif
        [APPEARANCE setTintColor:selectedImageTintColor];
#if __IPHONE_OS_VERSION_MIN_REQUIRED < 80000
    } else {
        [APPEARANCE setSelectedImageTintColor:selectedImageTintColor];
    }
#endif
}

@end
