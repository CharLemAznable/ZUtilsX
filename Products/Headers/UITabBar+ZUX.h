//
//  UITabBar+ZUX.h
//  ZUtilsX
//
//  Created by Char Aznable on 15/12/14.
//  Copyright © 2015年 org.cuc.n3. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZUXCategory.h"

#ifndef ZUtilsX_UITabBar_ZUX_h
#define ZUtilsX_UITabBar_ZUX_h

ZUX_CATEGORY_H(ZUX_UITabBar)

@interface UITabBar (ZUX)

+ (UIImage *)backgroundImage;
+ (void)setBackgroundImage:(UIImage *)backgroundImage;

+ (UIImage *)selectionIndicatorImage;
+ (void)setSelectionIndicatorImage:(UIImage *)selectionIndicatorImage;

+ (UIColor *)selectedImageTintColor;
+ (void)setSelectedImageTintColor:(UIColor *)selectedImageTintColor;

@end

#endif /* ZUtilsX_UITabBar_ZUX_h */
