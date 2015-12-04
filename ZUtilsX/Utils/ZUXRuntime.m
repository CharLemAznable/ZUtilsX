//
//  ZUXRuntime.m
//  ZUtilsX
//
//  Created by Char Aznable on 15/11/18.
//  Copyright © 2015年 org.cuc.n3. All rights reserved.
//

#import "ZUXRuntime.h"
#import "zobjc.h"
#import "zarc.h"
#import <objc/runtime.h>

static NSDictionary *primitiveTypeDictionary = nil;

ZUX_INLINE NSString *ZUX_GetPropertyClassName(Class cls, NSString *propertyName) {
    static dispatch_once_t once_t;
    dispatch_once(&once_t, ^{
        primitiveTypeDictionary = ZUX_RETAIN((@{@"f":@"float", @"i":@"int", @"d":@"double",
                                                @"l":@"long", @"c":@"BOOL", @"s":@"short",
                                                @"q":@"long", @"I":@"NSInteger", @"Q":@"NSUInteger",
                                                @"B":@"BOOL", @"@?":@"Block"}));
    });
    objc_property_t property = class_getProperty(cls, propertyName.UTF8String);
    if (ZUX_EXPECT_F(property == NULL)) return nil;
    
    NSString *propertyAttr = @(property_getAttributes(property));
    NSScanner *scanner = [NSScanner scannerWithString:propertyAttr];
    [scanner scanUpToString:@"T" intoString:nil];
    [scanner scanString:@"T" intoString:nil];
    NSString *propertyClassName = nil;
    if ([scanner scanString:@"@\"" intoString:&propertyClassName]) {
        [scanner scanUpToCharactersFromSet:[NSCharacterSet characterSetWithCharactersInString:@"\"<"]
                                intoString:&propertyClassName];
    } else if ([scanner scanString:@"{" intoString:&propertyClassName]) {
        [scanner scanCharactersFromSet:[NSCharacterSet alphanumericCharacterSet]
                            intoString:&propertyClassName];
    } else {
        [scanner scanUpToCharactersFromSet:[NSCharacterSet characterSetWithCharactersInString:@","]
                                intoString:&propertyClassName];
        propertyClassName = primitiveTypeDictionary[propertyClassName];
    }
    return propertyClassName;
}
