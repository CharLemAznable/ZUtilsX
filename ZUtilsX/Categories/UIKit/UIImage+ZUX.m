//
//  UIImage+ZUX.m
//  ZUtilsX
//
//  Created by Char Aznable on 15/11/13.
//  Copyright © 2015年 org.cuc.n3. All rights reserved.
//

#import "UIImage+ZUX.h"
#import "ZUXBundle.h"
#import "zobjc.h"
#import "zarc.h"
#import "zadapt.h"

ZUX_CATEGORY_M(ZUX_UIImage)

@implementation UIImage (ZUX)

+ (UIImage *)imageRectWithColor:(UIColor *)color size:(CGSize)size {
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

/*
 * (CGVector)direction specify gradient direction and velocity.
 * For example:
 *    CGVector(1, 1) means gradient start at CGPoint(0, 0) and end at CGPoint(size.width, size.height).
 *    CGVector(-1, -1) means gradient start at CGPoint(size.width, size.height) and end at CGPoint(0, 0).
 */
+ (UIImage *)imageGradientRectWithStartColor:(UIColor *)startColor endColor:(UIColor *)endColor
                                   direction:(CGVector)direction size:(CGSize)size {
    return [self imageGradientRectWithColors:@[startColor, endColor] locations:nil
                                   direction:direction size:size];
}


/**
 * (NSArray *)locations is an optional array of `NSNumber` objects defining the location of each gradient stop.
 * The gradient stops are specified as values between `0` and `1`. The values must be monotonically increasing.
 * If `nil`, the stops are spread uniformly across the range.
 */
+ (UIImage *)imageGradientRectWithColors:(NSArray *)colors locations:(NSArray *)locations
                               direction:(CGVector)direction size:(CGSize)size {
    if (ZUX_EXPECT_F([colors count] < 2)) return nil;
    
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGGradientRef gradient = CreateGradientWithColorsAndLocations(colors, locations);
    if (ZUX_EXPECT_T(gradient)) {
        CGPoint start = CGPointMake(size.width * MAX(0, -direction.dx), size.height * MAX(0, -direction.dy));
        CGPoint end = CGPointMake(size.width * MAX(0, direction.dx), size.height * MAX(0, direction.dy));
        CGContextDrawLinearGradient(context, gradient, start, end,
                                    kCGGradientDrawsBeforeStartLocation |
                                    kCGGradientDrawsAfterEndLocation);
    }
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    CGGradientRelease(gradient);
    UIGraphicsEndImageContext();
    return image;
}

+ (UIImage *)imageEllipseWithColor:(UIColor *)color size:(CGSize)size {
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillEllipseInRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

+ (UIImage *)imageForCurrentDeviceNamed:(NSString *)name {
    return [self imageNamed:[self imageNameForCurrentDeviceNamed:name]];
}

+ (NSString *)imageNameForCurrentDeviceNamed:(NSString *)name {
    return [NSString stringWithFormat:@"%@%@", name, IS_IPHONE6P ? @"-800-Portrait-736h":(IS_IPHONE6 ? @"-800-667h":(IS_IPHONE5 ? @"-700-568h":@""))];
}

#pragma mark - inline function -

ZUX_STATIC_INLINE CGGradientRef CreateGradientWithColorsAndLocations(NSArray *colors, NSArray *locations) {
    NSUInteger colorsCount = [colors count];
    NSUInteger locationsCount = [locations count];
    
    CGColorSpaceRef colorSpace = CGColorGetColorSpace([[colors objectAtIndex:0] CGColor]);
    
    CGFloat *gradientLocations = NULL;
    if (locationsCount == colorsCount) {
        gradientLocations = (CGFloat *)malloc(sizeof(CGFloat) * locationsCount);
        for (NSUInteger i = 0; i < locationsCount; i++) {
            gradientLocations[i] = [[locations objectAtIndex:i] floatValue];
        }
    }
    
    NSMutableArray *gradientColors = [[NSMutableArray alloc] initWithCapacity:colorsCount];
    [colors enumerateObjectsUsingBlock:^(id object, NSUInteger index, BOOL *stop) {
        [gradientColors addObject:(id)[(UIColor *)object CGColor]];
    }];
    
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (ZUX_BRIDGE CFArrayRef)gradientColors, gradientLocations);
    
    ZUX_RELEASE(gradientColors);
    if (gradientLocations) free(gradientLocations);
    
    return gradient;
}

@end

@implementation UIImage (ZUXDirectory)

- (BOOL)writeToUserFile:(NSString *)filePath {
    return [self writeToUserFile:filePath inDirectory:ZUXDocument];
}

+ (UIImage *)imageWithContentsOfUserFile:(NSString *)filePath {
    return [self imageWithContentsOfUserFile:filePath inDirectory:ZUXDocument];
}

- (BOOL)writeToUserFile:(NSString *)filePath inDirectory:(ZUXDirectoryType)directory {
    if (ZUX_EXPECT_F(![ZUXDirectory createDirectory:[filePath stringByDeletingLastPathComponent]
                                        inDirectory:directory])) return NO;
    return [UIImagePNGRepresentation(self) writeToFile:
            [ZUXDirectory fullFilePath:filePath inDirectory:directory]
                                            atomically:YES];
}

+ (UIImage *)imageWithContentsOfUserFile:(NSString *)filePath inDirectory:(ZUXDirectoryType)directory {
    if (ZUX_EXPECT_F(![ZUXDirectory fileExists:filePath inDirectory:directory])) return nil;
    return [UIImage imageWithContentsOfFile:[ZUXDirectory fullFilePath:filePath inDirectory:directory]];
}

@end

@implementation UIImage (ZUXBundle)

+ (UIImage *)imageWithContentsOfUserFile:(NSString *)fileName bundle:(NSString *)bundleName {
    return [self imageWithContentsOfUserFile:fileName bundle:bundleName subpath:nil];
}

+ (UIImage *)imageWithContentsOfUserFile:(NSString *)fileName bundle:(NSString *)bundleName subpath:(NSString *)subpath {
    return [ZUXBundle imageWithName:fileName bundle:bundleName subpath:subpath];
}

@end
