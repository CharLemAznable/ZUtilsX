//
//  UIWindow+ZUX.h
//  ZUtilsX
//
//  Created by Char Aznable on 16/1/28.
//  Copyright © 2016年 org.cuc.n3. All rights reserved.
//

#ifndef ZUtilsX_UIWindow_ZUX_h
#define ZUtilsX_UIWindow_ZUX_h

#import <UIKit/UIKit.h>
#import "ZUXCategory.h"
#import "UIView+ZUX.h"

@category_interface(UIWindow, ZUX)

- (void)showSplashLaunchWithAnimation:(ZUXAnimation)animation;
- (void)showSplashImage:(UIImage *)splashImage withAnimation:(ZUXAnimation)animation;
- (void)showSplashView:(UIView *)splashView withAnimation:(ZUXAnimation)animation;

@end

#endif /* ZUtilsX_UIWindow_ZUX_h */
