//
//  UIViewController+ZUX.h
//  ZUtilsX
//
//  Created by Char Aznable on 15/11/17.
//  Copyright © 2015年 org.cuc.n3. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "zarc.h"
#import "ZUXCategory.h"

#ifndef ZUtilsX_UIViewController_ZUX_h
#define ZUtilsX_UIViewController_ZUX_h

ZUX_CATEGORY_H(ZUX_UIViewController)

@interface UIViewController (ZUX)

@property (nonatomic) UIStatusBarStyle statusBarStyle;
- (void)setStatusBarStyle:(UIStatusBarStyle)statusBarStyle animated:(BOOL)animated;

@end

#endif /* ZUtilsX_UIViewController_ZUX_h */
