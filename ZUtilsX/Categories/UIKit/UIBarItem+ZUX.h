//
//  UIBarItem+ZUX.h
//  ZUtilsX
//
//  Created by Char Aznable on 15/12/14.
//  Copyright © 2015年 org.cuc.n3. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZUXCategory.h"

#ifndef ZUtilsX_UIBarItem_ZUX_h
#define ZUtilsX_UIBarItem_ZUX_h

ZUX_CATEGORY_H(ZUX_UIBarItem)

@interface UIBarItem (ZUXAppearance)

- (UIFont *)textFontForState:(UIControlState)state;
- (void)setTextFont:(UIFont *)textFont forState:(UIControlState)state;
+ (UIFont *)textFontForState:(UIControlState)state;
+ (void)setTextFont:(UIFont *)textFont forState:(UIControlState)state;

- (UIColor *)textColorForState:(UIControlState)state;
- (void)setTextColor:(UIColor *)textColor forState:(UIControlState)state;
+ (UIColor *)textColorForState:(UIControlState)state;
+ (void)setTextColor:(UIColor *)textColor forState:(UIControlState)state;

- (UIColor *)textShadowColorForState:(UIControlState)state;
- (void)setTextShadowColor:(UIColor *)textShadowColor forState:(UIControlState)state;
+ (UIColor *)textShadowColorForState:(UIControlState)state;
+ (void)setTextShadowColor:(UIColor *)textShadowColor forState:(UIControlState)state;

- (CGSize)textShadowOffsetForState:(UIControlState)state;
- (void)setTextShadowOffset:(CGSize)textShadowOffset forState:(UIControlState)state;
+ (CGSize)textShadowOffsetForState:(UIControlState)state;
+ (void)setTextShadowOffset:(CGSize)textShadowOffset forState:(UIControlState)state;

- (CGFloat)textShadowSizeForState:(UIControlState)state;
- (void)setTextShadowSize:(CGFloat)textShadowSize forState:(UIControlState)state;
+ (CGFloat)textShadowSizeForState:(UIControlState)state;
+ (void)setTextShadowSize:(CGFloat)textShadowSize forState:(UIControlState)state;

@end

#endif /* ZUtilsX_UIBarItem_ZUX_h */
