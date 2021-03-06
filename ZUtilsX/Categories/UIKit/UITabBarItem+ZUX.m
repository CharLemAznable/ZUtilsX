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

@category_implementation(UITabBarItem, ZUXAppearance)

+ (id)tabBarItemWithTitle:(NSString *)title image:(UIImage *)image selectedImage:(UIImage *)selectedImage {
#if __IPHONE_OS_VERSION_MIN_REQUIRED < 70000
    if (BEFORE_IOS7) {
        UITabBarItem *tabBarItem = [[UITabBarItem alloc] initWithTitle:title image:nil tag:0];
        [tabBarItem setFinishedSelectedImage:selectedImage withFinishedUnselectedImage:image];
        return ZUX_AUTORELEASE(tabBarItem);
    }
#endif
    return ZUX_AUTORELEASE([[UITabBarItem alloc] initWithTitle:title image:image
                                                 selectedImage:selectedImage]);
}

+ (UIOffset)titlePositionAdjustment {
    return [APPEARANCE titlePositionAdjustment];
}

+ (void)setTitlePositionAdjustment:(UIOffset)titlePositionAdjustment {
    [APPEARANCE setTitlePositionAdjustment:titlePositionAdjustment];
}

@end
