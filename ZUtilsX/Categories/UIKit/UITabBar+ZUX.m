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

- (NSArray ZUX_GENERIC(UIView *) *)barButtons {
    NSMutableArray *barButtons = [NSMutableArray array];
    [self.subviews enumerateObjectsUsingBlock:
     ^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
         if ([NSStringFromClass([obj class]) isEqualToString:@"UITabBarButton"])
             [barButtons addObject:obj];
     }];
    return barButtons;
}

@end

@implementation UITabBar (ZUXAppearance)

#pragma mark - translucent -

#if __IPHONE_OS_VERSION_MAX_ALLOWED < 70000
- (BOOL)isTranslucent {
    return NO;
}

- (void)setTranslucent:(BOOL)translucent {
}
#endif

+ (BOOL)isTranslucent {
    return
#if __IPHONE_OS_VERSION_MIN_REQUIRED < 70000
    !IOS7_OR_LATER ? NO :
#endif
    [APPEARANCE isTranslucent];
}

+ (void)setTranslucent:(BOOL)translucent {
#if __IPHONE_OS_VERSION_MIN_REQUIRED < 70000
    if (!IOS7_OR_LATER) return;
#endif
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
    !IOS7_OR_LATER ? nil :
#endif
    [APPEARANCE barTintColor];
}

+ (void)setBarTintColor:(UIColor *)barTintColor {
#if __IPHONE_OS_VERSION_MIN_REQUIRED < 70000
    if (!IOS7_OR_LATER) return;
#endif
    [APPEARANCE setBarTintColor:barTintColor];
}

#pragma mark - backgroundImage -

+ (UIImage *)backgroundImage {
    return [APPEARANCE backgroundImage];
}

+ (void)setBackgroundImage:(UIImage *)backgroundImage {
    [APPEARANCE setBackgroundImage:backgroundImage];
}

#pragma mark - backgroundColor -

+ (UIColor *)backgroundColor {
    return [APPEARANCE backgroundColor];
}

+ (void)setBackgroundColor:(UIColor *)backgroundColor {
    [APPEARANCE setBackgroundColor:backgroundColor];
}

#pragma mark - indicatorImage -

+ (UIImage *)selectionIndicatorImage {
    return [APPEARANCE selectionIndicatorImage];
}

+ (void)setSelectionIndicatorImage:(UIImage *)selectionIndicatorImage {
    [APPEARANCE setSelectionIndicatorImage:selectionIndicatorImage];
}

#pragma mark - indicatorColor -

- (UIColor *)selectionIndicatorColor {
    return selectionIndicatorColor(self);
}

- (void)setSelectionIndicatorColor:(UIColor *)selectionIndicatorColor {
    setSelectionIndicatorColor(self, selectionIndicatorColor);
}

+ (UIColor *)selectionIndicatorColor {
    return selectionIndicatorColor(APPEARANCE);
}

+ (void)setSelectionIndicatorColor:(UIColor *)selectionIndicatorColor {
    setSelectionIndicatorColor(APPEARANCE, selectionIndicatorColor);
}

#pragma mark - selectedTintColor -

#if __IPHONE_OS_VERSION_MIN_REQUIRED >= 80000
- (UIColor *)selectedImageTintColor {
    return [self tintColor];
}

- (void)setSelectedImageTintColor:(UIColor *)selectedImageTintColor {
    [self setTintColor:selectedImageTintColor];
}
#endif

+ (UIColor *)selectedImageTintColor {
    return [APPEARANCE selectedImageTintColor];
}

+ (void)setSelectedImageTintColor:(UIColor *)selectedImageTintColor {
    [APPEARANCE setSelectedImageTintColor:selectedImageTintColor];
}

@end
