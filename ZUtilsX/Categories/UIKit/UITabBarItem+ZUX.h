//
//  UITabBarItem+ZUX.h
//  ZUtilsX
//
//  Created by Char Aznable on 15/11/25.
//  Copyright © 2015年 org.cuc.n3. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZUXCategory.h"

#ifndef ZUtilsX_UITabBarItem_ZUX_h
#define ZUtilsX_UITabBarItem_ZUX_h

@category_interface(UITabBarItem, ZUXAppearance)

+ (id)tabBarItemWithTitle:(NSString *)title image:(UIImage *)image selectedImage:(UIImage *)selectedImage;

+ (UIOffset)titlePositionAdjustment;
+ (void)setTitlePositionAdjustment:(UIOffset)titlePositionAdjustment;

@end

#endif /* ZUtilsX_UITabBarItem_ZUX_h */
