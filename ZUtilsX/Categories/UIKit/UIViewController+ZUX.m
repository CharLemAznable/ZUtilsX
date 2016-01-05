//
//  UIViewController+ZUX.m
//  ZUtilsX
//
//  Created by Char Aznable on 15/11/17.
//  Copyright © 2015年 org.cuc.n3. All rights reserved.
//

#import "UIViewController+ZUX.h"
#import "NSObject+ZUX.h"
#import "ZUXProperty.h"
#import "zarc.h"
#import "zadapt.h"

ZUX_CATEGORY_M(ZUX_UIViewController)

@interface UIViewController (ZUX_Private)

- (UIStatusBarStyle)p_StatusBarStyle;
- (void)setP_StatusBarStyle:(UIStatusBarStyle)p_StatusBarStyle;

@end

ZUX_STATIC_INLINE UIViewController *controllerForStatusBarStyle() {
    UIViewController *root = [UIApplication sharedApplication].keyWindow.rootViewController;
    return root.childViewControllerForStatusBarStyle ?: root;
}

@implementation UIViewController (ZUX)

#pragma mark - Swizzle & Override Methods -

+ (void)load {
    static dispatch_once_t once_t;
    dispatch_once(&once_t, ^{
        ZUX_ENABLE_CATEGORY(ZUX_NSObject);
        // swizzle loadView
        [self swizzleInstanceOriSelector:@selector(loadView)
                         withNewSelector:@selector(zuxLoadView)];
    });
}

- (void)zuxLoadView {
    [self zuxLoadView];
    
    Class viewClass = [[[self class] zuxPropertyForName:@"view"] objectClass];
    if (![viewClass isSubclassOfClass:[UIView class]]) return;
    self.view = ZUX_AUTORELEASE([[viewClass alloc] initWithFrame:self.view.frame]);
}

- (UINavigationBar *)navigationBar {
    return self.navigationController.navigationBar;
}

- (UIStatusBarStyle)statusBarStyle {
    return
#if __IPHONE_OS_VERSION_MIN_REQUIRED < 70000
    !IOS7_OR_LATER ? [UIApplication sharedApplication].statusBarStyle :
#endif
    [controllerForStatusBarStyle() p_StatusBarStyle];
}

- (void)setStatusBarStyle:(UIStatusBarStyle)statusBarStyle {
    [self setStatusBarStyle:statusBarStyle animated:NO];
}

- (void)setStatusBarStyle:(UIStatusBarStyle)statusBarStyle animated:(BOOL)animated {
#if __IPHONE_OS_VERSION_MIN_REQUIRED < 70000
    if (!IOS7_OR_LATER) {
        [[UIApplication sharedApplication] setStatusBarStyle:statusBarStyle animated:animated];
        return;
    }
#endif
    UIViewController *controller = controllerForStatusBarStyle();
    [controller setP_StatusBarStyle:statusBarStyle];
    [controller setNeedsStatusBarAppearanceUpdate];
}

@end

@implementation UIViewController (ZUX_Private)

+ (void)load {
    static dispatch_once_t once_t;
    dispatch_once(&once_t, ^{
        ZUX_ENABLE_CATEGORY(ZUX_NSObject);
        // preferredStatusBarStyle
        [self swizzleInstanceOriSelector:@selector(preferredStatusBarStyle)
                         withNewSelector:@selector(zuxPreferredStatusBarStyle)];
#if !IS_ARC
        // dealloc
        [self swizzleInstanceOriSelector:@selector(dealloc)
                         withNewSelector:@selector(zuxPrivateDealloc)];
#endif
    });
}

- (UIStatusBarStyle)zuxPreferredStatusBarStyle {
    return [self p_StatusBarStyle];
}

- (void)zuxPrivateDealloc {
    ZUX_ENABLE_CATEGORY(ZUX_NSObject);
    [self setProperty:nil forAssociateKey:p_StatusBarStyleKey];
    [self zuxPrivateDealloc];
}

NSString *const p_StatusBarStyleKey = @"p_StatusBarStyle";

- (UIStatusBarStyle)p_StatusBarStyle {
    return [[self propertyForAssociateKey:p_StatusBarStyleKey] integerValue];
}

- (void)setP_StatusBarStyle:(UIStatusBarStyle)p_StatusBarStyle {
    [self setProperty:@(p_StatusBarStyle) forAssociateKey:p_StatusBarStyleKey];
}

@end
