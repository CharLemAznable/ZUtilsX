//
//  UIWindow+ZUX.m
//  ZUtilsX
//
//  Created by Char Aznable on 16/1/28.
//  Copyright © 2016年 org.cuc.n3. All rights reserved.
//

#import "UIWindow+ZUX.h"
#import "NSDictionary+ZUX.h"
#import "UIImage+ZUX.h"
#import "UIImageView+ZUX.h"
#import "ZUXBundle.h"

@category_implementation(UIWindow, ZUX)

- (void)showSplashLaunchWithAnimation:(ZUXAnimation)animation {
    NSString *launchImageName = [[ZUXBundle appBundle] infoDictionary][@"UILaunchImageFile"];
    [self showSplashImage:[UIImage imageForCurrentDeviceNamed:launchImageName] withAnimation:animation];
}

- (void)showSplashImage:(UIImage *)splashImage withAnimation:(ZUXAnimation)animation {
    if (!splashImage) return;
    [self showSplashView:[UIImageView imageViewWithImage:splashImage] withAnimation:animation];
}

- (void)showSplashView:(UIView *)splashView withAnimation:(ZUXAnimation)animation {
    [self addSubview:splashView];
    splashView.frame = [self bounds];
    [splashView zuxAnimate:animation completion:^{ [splashView removeFromSuperview]; }];
}

@end
