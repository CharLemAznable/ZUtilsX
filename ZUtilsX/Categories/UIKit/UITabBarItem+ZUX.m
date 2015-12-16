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
#import "zappearance.h"

ZUX_CATEGORY_M(ZUX_UITabBarItem)

@implementation UITabBarItem (ZUX)

+ (id)tabBarItemWithTitle:(NSString *)title image:(UIImage *)image selectedImage:(UIImage *)selectedImage {
#if __IPHONE_OS_VERSION_MIN_REQUIRED < 70000
    if (IOS7_OR_LATER) {
#endif
        return ZUX_AUTORELEASE([[UITabBarItem alloc] initWithTitle:title image:image
                                                     selectedImage:selectedImage]);
#if __IPHONE_OS_VERSION_MIN_REQUIRED < 70000
    } else {
        UITabBarItem *tabBarItem = [[UITabBarItem alloc] initWithTitle:title image:nil tag:0];
        [tabBarItem setFinishedSelectedImage:selectedImage withFinishedUnselectedImage:image];
        return ZUX_AUTORELEASE(tabBarItem);
    }
#endif
}

+ (UIOffset)titlePositionAdjustment {
    return [APPEARANCE titlePositionAdjustment];
}

+ (void)setTitlePositionAdjustment:(UIOffset)titlePositionAdjustment {
    [APPEARANCE setTitlePositionAdjustment:titlePositionAdjustment];
}

@end
