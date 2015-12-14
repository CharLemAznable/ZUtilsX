//
//  UITabBar+ZUX.m
//  ZUtilsX
//
//  Created by Char Aznable on 15/12/14.
//  Copyright © 2015年 org.cuc.n3. All rights reserved.
//

#import "UITabBar+ZUX.h"
#import "zappearance.h"

ZUX_CATEGORY_M(ZUX_UITabBar)

@implementation UITabBar (ZUX)

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
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= 70000
    return [APPEARANCE tintColor];
#else
    return [APPEARANCE selectedImageTintColor];
#endif
}

+ (void)setSelectedImageTintColor:(UIColor *)selectedImageTintColor {
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= 70000
    [APPEARANCE setTintColor:selectedImageTintColor];
#else
    [APPEARANCE setSelectedImageTintColor:selectedImageTintColor];
#endif
}

@end
