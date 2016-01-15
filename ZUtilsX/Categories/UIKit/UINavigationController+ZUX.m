//
//  UINavigationController+ZUX.m
//  ZUtilsX
//
//  Created by Char Aznable on 16/1/7.
//  Copyright © 2016年 org.cuc.n3. All rights reserved.
//

#import "UINavigationController+ZUX.h"
#import "NSObject+ZUX.h"
#import "zarc.h"
#import <objc/runtime.h>

@category_implementation(UIViewController, ZUXNavigation)

- (UINavigationBar *)navigationBar {
    return self.navigationController.navigationBar;
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    [self.navigationController pushViewController:viewController animated:animated];
}

- (UIViewController *)popViewControllerAnimated:(BOOL)animated {
    return [self.navigationController popViewControllerAnimated:animated];
}

- (NSArray *)popToViewController:(UIViewController *)viewController animated:(BOOL)animated {
    return [self.navigationController popToViewController:viewController animated:animated];
}

- (NSArray *)popToRootViewControllerAnimated:(BOOL)animated {
    return [self.navigationController popToRootViewControllerAnimated:animated];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated initialWithBlock:(ZUXNavigationCallbackBlock)initial completionWithBlock:(ZUXNavigationCallbackBlock)completion {
    [self.navigationController pushViewController:viewController animated:animated
                                 initialWithBlock:initial completionWithBlock:completion];
}

- (UIViewController *)popViewControllerAnimated:(BOOL)animated cleanupWithBlock:(ZUXNavigationCallbackBlock)cleanup completionWithBlock:(ZUXNavigationCallbackBlock)completion {
    return [self.navigationController popViewControllerAnimated:animated
                                               cleanupWithBlock:cleanup completionWithBlock:completion];
}

- (void)willNavigatePush:(BOOL)animated {}
- (void)didNavigatePush:(BOOL)animated {}
- (void)willNavigatePop:(BOOL)animated {}
- (void)didNavigatePop:(BOOL)animated {}

#pragma mark - Navigate callback implementation -

- (void)zuxViewWillAppear:(BOOL)animated {
    [[self class] swizzleZuxViewDidAppear:NO];
    
    [self zuxViewWillAppearCallback];
    [self willNavigatePush:animated];
    [self zuxViewWillAppear:animated];
}

- (void)zuxViewDidAppear:(BOOL)animated {
    [self zuxViewDidAppear:animated];
    [self didNavigatePush:animated];
    [self zuxViewDidAppearCallback];
    
    [self setZuxViewWillAppearCallbackBlock:NULL];
    [self setZuxViewDidAppearCallbackBlock:NULL];
    [[self class] swizzleZuxViewWillAppear:YES];
    [[self class] swizzleZuxViewDidAppear:YES];
}

- (void)zuxViewWillDisappear:(BOOL)animated {
    [[self class] swizzleZuxViewDidDisappear:NO];
    
    [self zuxViewWillDisappearCallback];
    [self willNavigatePop:animated];
    [self zuxViewWillDisappear:animated];
}

- (void)zuxViewDidDisappear:(BOOL)animated {
    [self zuxViewDidDisappear:animated];
    [self didNavigatePop:animated];
    [self zuxViewDidDisappearCallback];
    
    [self setZuxViewWillDisappearCallbackBlock:NULL];
    [self setZuxViewDidDisappearCallbackBlock:NULL];
    [[self class] swizzleZuxViewWillDisappear:YES];
    [[self class] swizzleZuxViewDidDisappear:YES];
}

#define ZUXCallbackBlockImplementation(blockKey)                                                            \
static NSString *const ZUXView##blockKey##CallbackBlockKey = @"zuxView" @#blockKey @"CallbackBlockKey";     \
- (ZUXNavigationCallbackBlock)zuxView##blockKey##CallbackBlock {                                            \
    return (ZUXNavigationCallbackBlock)[self propertyForAssociateKey:ZUXView##blockKey##CallbackBlockKey];  \
}                                                                                                           \
- (void)setZuxView##blockKey##CallbackBlock:(ZUXNavigationCallbackBlock)block {                             \
    [self setProperty:(id)block forAssociateKey:ZUXView##blockKey##CallbackBlockKey];                       \
}                                                                                                           \
- (void)zuxView##blockKey##Callback {                                                                       \
    ZUXNavigationCallbackBlock block = [self zuxView##blockKey##CallbackBlock];                             \
    if (block) block(self);                                                                                 \
}

ZUXCallbackBlockImplementation(WillAppear);
ZUXCallbackBlockImplementation(DidAppear);
ZUXCallbackBlockImplementation(WillDisappear);
ZUXCallbackBlockImplementation(DidDisappear);

+ (void)load {
    static dispatch_once_t once_t;
    dispatch_once(&once_t, ^{
#if !IS_ARC
        [self swizzleInstanceOriSelector:@selector(dealloc)
                         withNewSelector:@selector(zuxNavigationDealloc)];
#endif
    });
}

- (void)zuxNavigationDealloc {
    [self setProperty:NULL forAssociateKey:ZUXViewWillAppearCallbackBlockKey];
    [self setProperty:NULL forAssociateKey:ZUXViewDidAppearCallbackBlockKey];
    [self setProperty:NULL forAssociateKey:ZUXViewWillDisappearCallbackBlockKey];
    [self setProperty:NULL forAssociateKey:ZUXViewDidDisappearCallbackBlockKey];
    [self zuxNavigationDealloc];
}

#define ZUXCallbackSwizzleImplementation(swizzleKey)                                                \
static NSString *const ZUXView##swizzleKey##SwizzledKey = @"zuxView" @#swizzleKey @"SwizzledKey";   \
+ (BOOL)zuxView##swizzleKey##Swizzled {                                                             \
    return [[self propertyForAssociateKey:ZUXView##swizzleKey##SwizzledKey] boolValue];             \
}                                                                                                   \
+ (void)setZuxView##swizzleKey##Swizzled:(BOOL)swizzled {                                           \
    [self setProperty:@(swizzled) forAssociateKey:ZUXView##swizzleKey##SwizzledKey];                \
}                                                                                                   \
+ (void)swizzleZuxView##swizzleKey:(BOOL)swizzled {                                                 \
    @synchronized(self) {                                                                           \
        if ([self zuxView##swizzleKey##Swizzled] == swizzled) {                                     \
            [self swizzleInstanceOriSelector:@selector(view##swizzleKey:)                           \
                             withNewSelector:@selector(zuxView##swizzleKey:)];                      \
            [self setZuxView##swizzleKey##Swizzled:!swizzled];                                      \
        }                                                                                           \
    }                                                                                               \
}

ZUXCallbackSwizzleImplementation(WillAppear);
ZUXCallbackSwizzleImplementation(DidAppear);
ZUXCallbackSwizzleImplementation(WillDisappear);
ZUXCallbackSwizzleImplementation(DidDisappear);

@end

@category_implementation(UINavigationController, ZUX)

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
          initialWithBlock:(ZUXNavigationCallbackBlock)initial
       completionWithBlock:(ZUXNavigationCallbackBlock)completion {
    [viewController setZuxViewWillAppearCallbackBlock:initial];
    [viewController setZuxViewDidAppearCallbackBlock:completion];
    [self pushViewController:viewController animated:animated];
}

- (UIViewController *)popViewControllerAnimated:(BOOL)animated
                               cleanupWithBlock:(ZUXNavigationCallbackBlock)cleanup
                            completionWithBlock:(ZUXNavigationCallbackBlock)completion {
    [self.topViewController setZuxViewWillDisappearCallbackBlock:cleanup];
    [self.topViewController setZuxViewDidDisappearCallbackBlock:completion];
    return [self popViewControllerAnimated:animated];
}

+ (void)load {
    static dispatch_once_t once_t;
    dispatch_once(&once_t, ^{
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
