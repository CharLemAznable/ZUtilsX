//
//  UIColor+ZUX.m
//  ZUtilsX
//
//  Created by Char Aznable on 15/11/13.
//  Copyright © 2015年 org.cuc.n3. All rights reserved.
//

#import "UIColor+ZUX.h"
#import "NSString+ZUX.h"

ZUX_CATEGORY_M(ZUX_UIColor)

@implementation UIColor (ZUX)

+ (UIColor *)colorWithIntegerRed:(NSUInteger)red green:(NSUInteger)green blue:(NSUInteger)blue {
    return [self colorWithIntegerRed:red green:green blue:blue alpha:255];
}

+ (UIColor *)colorWithIntegerRed:(NSUInteger)red green:(NSUInteger)green blue:(NSUInteger)blue alpha:(NSUInteger)alpha {
    return [UIColor colorWithRed:MIN(red, 255)/255. green:MIN(green, 255)/255. blue:MIN(blue, 255)/255. alpha:MIN(alpha, 255)/255.];
}

+ (UIColor *)colorWithRGBHexString:(NSString *)hexString {
    NSString *str = [[hexString trim] uppercaseString];
    if (ZUX_EXPECT_F([str length] < 6)) return nil;
    ZUX_ENABLE_CATEGORY(ZUX_NSString);
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

@end
