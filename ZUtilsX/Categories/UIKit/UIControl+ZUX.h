//
//  UIControl+ZUX.h
//  ZUtilsX
//
//  Created by Char Aznable on 15/11/13.
//  Copyright © 2015年 org.cuc.n3. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZUXCategory.h"

#ifndef ZUtilsX_UIControl_ZUX_h
#define ZUtilsX_UIControl_ZUX_h

ZUX_CATEGORY_H(ZUX_UIControl)

@interface UIControl (ZUX)

- (CGFloat)borderWidthForState:(UIControlState)state UI_APPEARANCE_SELECTOR;
- (void)setBorderWidth:(CGFloat)width forState:(UIControlState)state UI_APPEARANCE_SELECTOR;

- (UIColor *)borderColorForState:(UIControlState)state UI_APPEARANCE_SELECTOR;
- (void)setBorderColor:(UIColor *)color forState:(UIControlState)state UI_APPEARANCE_SELECTOR;

- (UIColor *)shadowColorForState:(UIControlState)state UI_APPEARANCE_SELECTOR;
- (void)setShadowColor:(UIColor *)color forState:(UIControlState)state UI_APPEARANCE_SELECTOR;

- (float)shadowOpacityForState:(UIControlState)state UI_APPEARANCE_SELECTOR;
- (void)setShadowOpacity:(float)opacity forState:(UIControlState)state UI_APPEARANCE_SELECTOR;

- (CGSize)shadowOffsetForState:(UIControlState)state UI_APPEARANCE_SELECTOR;
- (void)setShadowOffset:(CGSize)offset forState:(UIControlState)state UI_APPEARANCE_SELECTOR;

- (CGFloat)shadowSizeForState:(UIControlState)state UI_APPEARANCE_SELECTOR;
- (void)setShadowSize:(CGFloat)size forState:(UIControlState)state UI_APPEARANCE_SELECTOR;

@end // UIControl (ZUX)

@interface UIControl (ZUXAppearance)

+ (CGFloat)borderWidthForState:(UIControlState)state;
+ (void)setBorderWidth:(CGFloat)width forState:(UIControlState)state;

+ (UIColor *)borderColorForState:(UIControlState)state;
+ (void)setBorderColor:(UIColor *)color forState:(UIControlState)state;

+ (UIColor *)shadowColorForState:(UIControlState)state;
+ (void)setShadowColor:(UIColor *)color forState:(UIControlState)state;

+ (float)shadowOpacityForState:(UIControlState)state;
+ (void)setShadowOpacity:(float)opacity forState:(UIControlState)state;

+ (CGSize)shadowOffsetForState:(UIControlState)state;
+ (void)setShadowOffset:(CGSize)offset forState:(UIControlState)state;

+ (CGFloat)shadowSizeForState:(UIControlState)state;
+ (void)setShadowSize:(CGFloat)size forState:(UIControlState)state;

@end // UIControl (ZUXAppearance)

#endif /* ZUtilsX_UIControl_ZUX_h */
