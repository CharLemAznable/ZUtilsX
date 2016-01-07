//
//  UINavigationController+ZUX.h
//  ZUtilsX
//
//  Created by Char Aznable on 16/1/7.
//  Copyright © 2016年 org.cuc.n3. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZUXCategory.h"

#ifndef ZUtilsX_UINavigationController_ZUX_h
#define ZUtilsX_UINavigationController_ZUX_h

ZUX_CATEGORY_H(ZUX_UINavigationController)

@interface UINavigationController (ZUX)

@end // UINavigationController (ZUX)

@interface UIViewController (ZUXNavigation)

@property (nonatomic, readonly) UINavigationBar *navigationBar;

- (void)willNavigatePush:(BOOL)animated; // Called when NavigationController push. Default does nothing
- (void)didNavigatePush:(BOOL)animated; // Called when NavigationController push. Default does nothing
- (void)willNavigatePop:(BOOL)animated; // Called when NavigationController pop. Default does nothing
- (void)didNavigatePop:(BOOL)animated; // Called when NavigationController pop. Default does nothing

@end // UIViewController (ZUXNavigation)

#endif /* ZUtilsX_UINavigationController_ZUX_h */
