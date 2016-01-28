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

- (void)splashScreenAnimate:(ZUXAnimation)animation {
    NSString *launchImageName = [[ZUXBundle appBundle] infoDictionary][@"UILaunchImageFile"];
    UIImage *launchImage = [UIImage imageForCurrentDeviceNamed:launchImageName];
    if (!launchImage) return;
    
    UIImageView *splashView = [UIImageView imageViewWithImage:launchImage];
    [self addSubview:splashView];
    splashView.frame = [self bounds];
    [splashView zuxAnimate:animation completion:^{ [splashView removeFromSuperview]; }];
}

@end
