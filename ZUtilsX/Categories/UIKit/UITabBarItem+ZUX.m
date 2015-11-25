//
//  UITabBarItem+ZUX.m
//  ZUtilsX
//
//  Created by Char Aznable on 15/11/25.
//  Copyright © 2015年 org.cuc.n3. All rights reserved.
//

#import "UITabBarItem+ZUX.h"
#import "zarc.h"
#import "zadapt.h"

ZUX_CATEGORY_M(ZUX_UITabBarItem)

@implementation UITabBarItem (ZUX)

+ (id)tabBarItemWithTitle:(NSString *)title image:(UIImage *)image selectedImage:(UIImage *)selectedImage {
    if (IOS7_OR_LATER) {
        return ZUX_AUTORELEASE([[UITabBarItem alloc] initWithTitle:title image:image
                                                     selectedImage:selectedImage]);
    } else {
        UITabBarItem *tabBarItem = [[UITabBarItem alloc] initWithTitle:title image:nil tag:0];
        [tabBarItem setFinishedSelectedImage:selectedImage withFinishedUnselectedImage:image];
        return ZUX_AUTORELEASE(tabBarItem);
    }
}

@end
