//
//  UINavigationController+ZUX.m
//  ZUtilsX
//
//  Created by Char Aznable on 16/1/7.
//  Copyright © 2016年 org.cuc.n3. All rights reserved.
//

#import "UINavigationController+ZUX.h"
#import "NSObject+ZUX.h"

ZUX_CATEGORY_M(ZUX_UINavigationController)

@implementation UIViewController (ZUXNavigation)

- (UINavigationBar *)navigationBar {
    return self.navigationController.navigationBar;
}

- (void)willNavigatePush:(BOOL)animated {}
- (void)didNavigatePush:(BOOL)animated {}
- (void)willNavigatePop:(BOOL)animated {}
- (void)didNavigatePop:(BOOL)animated {}

#pragma mark - Navigate callback implementation -

- (void)zuxViewWillAppear:(BOOL)animated {
    [[self class] swizzleZuxViewDidAppear:NO];
    [self willNavigatePush:animated];
    [self zuxViewWillAppear:animated];
}

- (void)zuxViewDidAppear:(BOOL)animated {
    [self zuxViewDidAppear:animated];
    [self didNavigatePush:animated];
    [[self class] swizzleZuxViewWillAppear:YES];
    [[self class] swizzleZuxViewDidAppear:YES];
}

- (void)zuxViewWillDisappear:(BOOL)animated {
    [[self class] swizzleZuxViewDidDisappear:NO];
    [self willNavigatePop:animated];
    [self zuxViewWillDisappear:animated];
}

- (void)zuxViewDidDisappear:(BOOL)animated {
    [self zuxViewDidDisappear:animated];
    [self didNavigatePop:animated];
    [[self class] swizzleZuxViewWillDisappear:YES];
    [[self class] swizzleZuxViewDidDisappear:YES];
}

#define ZUXSwizzledKey_implement(SwizzleKey) \
static NSString *const ZUXView ## SwizzleKey ## SwizzledKey = @"zuxView" @#SwizzleKey @"SwizzledKey"; \
+ (BOOL)zuxView ## SwizzleKey ## Swizzled { \
    return [[self propertyForAssociateKey:ZUXView ## SwizzleKey ## SwizzledKey] boolValue]; \
} \
+ (void)setZuxView ## SwizzleKey ## Swizzled:(BOOL)swizzled { \
    [self setProperty:@(swizzled) forAssociateKey:ZUXView ## SwizzleKey ## SwizzledKey]; \
} \
+ (void)swizzleZuxView ## SwizzleKey:(BOOL)swizzled { \
    @synchronized(self) { \
        if ([self zuxView ## SwizzleKey ## Swizzled] == swizzled) { \
            [self swizzleInstanceOriSelector:@selector(view ## SwizzleKey:) \
                             withNewSelector:@selector(zuxView ## SwizzleKey:)]; \
            [self setZuxView ## SwizzleKey ## Swizzled:!swizzled]; \
        } \
    } \
}

ZUXSwizzledKey_implement(WillAppear);
ZUXSwizzledKey_implement(DidAppear);
ZUXSwizzledKey_implement(WillDisappear);
ZUXSwizzledKey_implement(DidDisappear);

@end

@implementation UINavigationController (ZUX)

+ (void)load {
    static dispatch_once_t once_t;
    dispatch_once(&once_t, ^{
        ZUX_ENABLE_CATEGORY(ZUX_NSObject);
        [self swizzleInstanceOriSelector:@selector(pushViewController:animated:)
                         withNewSelector:@selector(zuxPushViewController:animated:)];
        [self swizzleInstanceOriSelector:@selector(popViewControllerAnimated:)
                         withNewSelector:@selector(zuxPopViewControllerAnimated:)];
    });
}

- (void)zuxPushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    [[viewController class] swizzleZuxViewWillAppear:NO];
    [self zuxPushViewController:viewController animated:animated];
}

- (UIViewController *)zuxPopViewControllerAnimated:(BOOL)animated {
    [[self.topViewController class] swizzleZuxViewWillDisappear:NO];
    return [self zuxPopViewControllerAnimated:animated];
}

@end
