//
//  UINavigationController+ZUX.h
//  ZUtilsX
//
//  Created by Char Aznable on 16/1/7.
//  Copyright © 2016年 org.cuc.n3. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZUXCategory.h"
#import "zobjc.h"

#ifndef ZUtilsX_UINavigationController_ZUX_h
#define ZUtilsX_UINavigationController_ZUX_h

typedef void (^ZUXNavigationCallbackBlock)(UIViewController *viewController);

@category_interface(UINavigationController, ZUX)

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
          initialWithBlock:(ZUXNavigationCallbackBlock)initial
       completionWithBlock:(ZUXNavigationCallbackBlock)completion;
- (UIViewController *)popViewControllerAnimated:(BOOL)animated
                               cleanupWithBlock:(ZUXNavigationCallbackBlock)cleanup
                            completionWithBlock:(ZUXNavigationCallbackBlock)completion;

@end // UINavigationController (ZUX)

@category_interface(UIViewController, ZUXNavigation)

@property (nonatomic, readonly) UINavigationBar *navigationBar;

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated;
- (UIViewController *)popViewControllerAnimated:(BOOL)animated;
- (NSArray ZUX_GENERIC(ZUX_KINDOF(UIViewController *)) *)popToViewController:(UIViewController *)viewController animated:(BOOL)animated;
- (NSArray ZUX_GENERIC(ZUX_KINDOF(UIViewController *)) *)popToRootViewControllerAnimated:(BOOL)animated;

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
          initialWithBlock:(ZUXNavigationCallbackBlock)initial
       completionWithBlock:(ZUXNavigationCallbackBlock)completion;
- (UIViewController *)popViewControllerAnimated:(BOOL)animated
                               cleanupWithBlock:(ZUXNavigationCallbackBlock)cleanup
                            completionWithBlock:(ZUXNavigationCallbackBlock)completion;

- (void)willNavigatePush:(BOOL)animated; // Called when NavigationController push. Default does nothing
- (void)didNavigatePush:(BOOL)animated; // Called when NavigationController push. Default does nothing
- (void)willNavigatePop:(BOOL)animated; // Called when NavigationController pop. Default does nothing
- (void)didNavigatePop:(BOOL)animated; // Called when NavigationController pop. Default does nothing

@end // UIViewController (ZUXNavigation)

#endif /* ZUtilsX_UINavigationController_ZUX_h */
