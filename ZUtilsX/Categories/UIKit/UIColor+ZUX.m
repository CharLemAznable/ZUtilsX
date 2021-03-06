//
//  UIColor+ZUX.m
//  ZUtilsX
//
//  Created by Char Aznable on 15/11/13.
//  Copyright © 2015年 org.cuc.n3. All rights reserved.
//

#import "UIColor+ZUX.h"
#import "NSString+ZUX.h"
#import "zarc.h"

@category_implementation(UIColor, ZUX)

+ (UIColor *)colorWithIntegerRed:(NSUInteger)red green:(NSUInteger)green blue:(NSUInteger)blue {
    return [self colorWithIntegerRed:red green:green blue:blue alpha:255];
}

+ (UIColor *)colorWithIntegerRed:(NSUInteger)red green:(NSUInteger)green blue:(NSUInteger)blue alpha:(NSUInteger)alpha {
    return [UIColor colorWithRed:MIN(red, 255)/255. green:MIN(green, 255)/255. blue:MIN(blue, 255)/255. alpha:MIN(alpha, 255)/255.];
}

+ (UIColor *)colorWithRGBHexString:(NSString *)hexString {
    NSString *str = [[hexString trim] uppercaseString];
    if (ZUX_EXPECT_F([str length] < 6)) return nil;
    return [self colorWithRGBAHexString:[[str substringWithRange:NSMakeRange(0, 6)] appendWithObjects:@"FF", nil]];
}

+ (UIColor *)colorWithRGBAHexString:(NSString *)hexString {
    NSString *str = [[hexString trim] uppercaseString];
    if (ZUX_EXPECT_F([str length] < 6)) return nil;
    if (ZUX_EXPECT_F([str length] < 8))
        str = [[str substringWithRange:NSMakeRange(0, 6)] appendWithObjects:@"FF", nil];
    
    unsigned int red, green, blue, alpha;
    [[NSScanner scannerWithString:[str substringWithRange:NSMakeRange(0, 2)]] scanHexInt:&red];
    [[NSScanner scannerWithString:[str substringWithRange:NSMakeRange(2, 2)]] scanHexInt:&green];
    [[NSScanner scannerWithString:[str substringWithRange:NSMakeRange(4, 2)]] scanHexInt:&blue];
    [[NSScanner scannerWithString:[str substringWithRange:NSMakeRange(6, 2)]] scanHexInt:&alpha];
    return [self colorWithIntegerRed:red green:green blue:blue alpha:alpha];
}

- (CGColorRef)rgbaCGColorRef {
    CGColorSpaceRef rgb = CGColorSpaceCreateDeviceRGB();
    CGFloat components[4] = {0, 0, 0, 0};
    [self getRed:&components[0] green:&components[1]
            blue:&components[2] alpha:&components[3]];
    CGColorRef colorRef = CGColorCreate(rgb, components);
    CGColorSpaceRelease(rgb);
    return (ZUX_BRIDGE CGColorRef)ZUX_AUTORELEASE((ZUX_BRIDGE_TRANSFER id)colorRef);
}

- (BOOL)isEqual:(id)object {
    if (object == self) return YES;
    if (!object || ![object isKindOfClass:[self class]]) return NO;
    return [self isEqualToColor:object];
}

- (BOOL)isEqualToColor:(UIColor *)color {
    if (color == self) return YES;
    return CGColorEqualToColor(self.rgbaCGColorRef, color.rgbaCGColorRef);
}

@end
