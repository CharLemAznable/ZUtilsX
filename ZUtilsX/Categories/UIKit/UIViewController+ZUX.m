//
//  UIViewController+ZUX.m
//  ZUtilsX
//
//  Created by Char Aznable on 15/11/17.
//  Copyright © 2015年 org.cuc.n3. All rights reserved.
//

#import "UIViewController+ZUX.h"
#import "NSObject+ZUX.h"
#import "ZUXRuntime.h"
#import "zarc.h"
#import "zadapt.h"
#import <objc/runtime.h>

ZUX_CATEGORY_M(ZUX_UIViewController)

#if __IPHONE_OS_VERSION_MIN_REQUIRED >= 90000

@interface UIViewController (ZUX_Private)

- (UIStatusBarStyle)p_StatusBarStyle;
- (void)setP_StatusBarStyle:(UIStatusBarStyle)p_StatusBarStyle;

@end

ZUX_STATIC_INLINE UIViewController *controllerForStatusBarStyle() {
    UIViewController *root = [UIApplication sharedApplication].keyWindow.rootViewController;
    return root.childViewControllerForStatusBarStyle ?: root;
}

#endif

@implementation UIViewController (ZUX)

#pragma mark - Swizzle & Override Methods.

+ (void)load {
    [super load];
    
    ZUX_ENABLE_CATEGORY(ZUX_NSObject);
    // swizzle loadView
    [self swizzleInstanceOriSelector:@selector(loadView)
                     withNewSelector:@selector(zuxLoadView)];
}

- (void)zuxLoadView {
    [self zuxLoadView];
    
    NSString *viewClassName = ZUX_GetPropertyClassName([self class], @"view");
    if (!viewClassName || [@"UIView" isEqualToString:viewClassName]) return;
    
    Class viewClass = NSClassFromString(viewClassName);
    if (ZUX_EXPECT_F(![viewClass isSubclassOfClass:[UIView class]])) return;
    
    self.view = ZUX_AUTORELEASE([[viewClass alloc] initWithFrame:self.view.frame]);
}

- (UIStatusBarStyle)statusBarStyle {
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= 90000
    return [controllerForStatusBarStyle() p_StatusBarStyle];
#else
    return [UIApplication sharedApplication].statusBarStyle;
#endif
}

- (void)setStatusBarStyle:(UIStatusBarStyle)statusBarStyle {
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= 90000
    UIViewController *controller = controllerForStatusBarStyle();
    [controller setP_StatusBarStyle:statusBarStyle];
    [controller setNeedsStatusBarAppearanceUpdate];
#else
    [[UIApplication sharedApplication] setStatusBarStyle:statusBarStyle];
#endif
}

- (void)setStatusBarStyle:(UIStatusBarStyle)statusBarStyle animated:(BOOL)animated {
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= 90000
    UIViewController *controller = controllerForStatusBarStyle();
    [controller setP_StatusBarStyle:statusBarStyle];
    [controller setNeedsStatusBarAppearanceUpdate];
#else
    [[UIApplication sharedApplication] setStatusBarStyle:statusBarStyle animated:animated];
#endif
}

@end

#if __IPHONE_OS_VERSION_MIN_REQUIRED >= 90000

@implementation UIViewController (ZUX_Private)

+ (void)load {
    [super load];
    
    ZUX_ENABLE_CATEGORY(ZUX_NSObject);
    // preferredStatusBarStyle
    [self swizzleInstanceOriSelector:@selector(preferredStatusBarStyle)
                     withNewSelector:@selector(zuxPreferredStatusBarStyle)];
#if !IS_ARC
    // dealloc
    [self swizzleInstanceOriSelector:@selector(dealloc)
                     withNewSelector:@selector(zuxDealloc)];
#endif
}

- (UIStatusBarStyle)zuxPreferredStatusBarStyle {
    return [self p_StatusBarStyle];
}

- (void)zuxDealloc {
    ZUX_ENABLE_CATEGORY(ZUX_NSObject);
    [self setProperty:nil forAssociateKey:p_StatusBarStyleKey];
    [self zuxDealloc];
}

NSString *const p_StatusBarStyleKey = @"p_StatusBarStyle";

- (UIStatusBarStyle)p_StatusBarStyle {
    return [[self propertyForAssociateKey:p_StatusBarStyleKey] integerValue];
}

- (void)setP_StatusBarStyle:(UIStatusBarStyle)p_StatusBarStyle {
    [self setProperty:@(p_StatusBarStyle) forAssociateKey:p_StatusBarStyleKey];
}

@end

#endif
