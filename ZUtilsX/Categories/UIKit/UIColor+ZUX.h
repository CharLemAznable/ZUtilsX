//
//  UIColor+ZUX.h
//  ZUtilsX
//
//  Created by Char Aznable on 15/11/13.
//  Copyright © 2015年 org.cuc.n3. All rights reserved.
//

#ifndef ZUtilsX_UIColor_ZUX_h
#define ZUtilsX_UIColor_ZUX_h

#import <UIKit/UIKit.h>
#import "ZUXCategory.h"

@category_interface(UIColor, ZUX)

// Convenience methods for creating autoreleased colors with integer between 0 and 255
+ (UIColor *)colorWithIntegerRed:(NSUInteger)red green:(NSUInteger)green blue:(NSUInteger)blue;
// Convenience methods for creating autoreleased colors with integer between 0 and 255
+ (UIColor *)colorWithIntegerRed:(NSUInteger)red green:(NSUInteger)green blue:(NSUInteger)blue alpha:(NSUInteger)alpha;
// Convenience methods for creating autoreleased colors with HEX String like "ff3344"
+ (UIColor *)colorWithRGBHexString:(NSString *)hexString;
// Convenience methods for creating autoreleased colors with HEX String like "ff3344ff"
+ (UIColor *)colorWithRGBAHexString:(NSString *)hexString;

- (CGColorRef)rgbaCGColorRef;
- (BOOL)isEqualToColor:(UIColor *)color;

@end

#endif /* ZUtilsX_UIColor_ZUX_h */
