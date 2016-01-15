//
//  UIImage+ZUX.h
//  ZUtilsX
//
//  Created by Char Aznable on 15/11/13.
//  Copyright © 2015年 org.cuc.n3. All rights reserved.
//

#ifndef ZUtilsX_UIImage_ZUX_h
#define ZUtilsX_UIImage_ZUX_h

#import <UIKit/UIKit.h>
#import "ZUXCategory.h"
#import "ZUXDirectory.h"

@category_interface(UIImage, ZUX)

+ (UIImage *)imagePointWithColor:(UIColor *)color;
+ (UIImage *)imageRectWithColor:(UIColor *)color size:(CGSize)size;
+ (UIImage *)imageGradientRectWithStartColor:(UIColor *)startColor endColor:(UIColor *)endColor direction:(CGVector)direction size:(CGSize)size;
+ (UIImage *)imageGradientRectWithColors:(NSArray *)colors locations:(NSArray *)locations direction:(CGVector)direction size:(CGSize)size;
+ (UIImage *)imageEllipseWithColor:(UIColor *)color size:(CGSize)size;
+ (UIImage *)imageForCurrentDeviceNamed:(NSString *)name;
+ (NSString *)imageNameForCurrentDeviceNamed:(NSString *)name;
- (UIColor *)dominantColor;

@end // UIImage (ZUX)

@category_interface(UIImage, ZUXCreation)

+ (UIImage *)imageWithContentsOfUserFile:(NSString *)fileName;
+ (UIImage *)imageWithContentsOfUserFile:(NSString *)fileName subpath:(NSString *)subpath;
+ (UIImage *)imageWithContentsOfUserFile:(NSString *)fileName inDirectory:(ZUXDirectoryType)directory;
+ (UIImage *)imageWithContentsOfUserFile:(NSString *)fileName inDirectory:(ZUXDirectoryType)directory subpath:(NSString *)subpath;
+ (UIImage *)imageWithContentsOfUserFile:(NSString *)fileName bundle:(NSString *)bundleName;
+ (UIImage *)imageWithContentsOfUserFile:(NSString *)fileName bundle:(NSString *)bundleName subpath:(NSString *)subpath;

@end // UIImage (ZUXCreation)

@category_interface(UIImage, ZUXSerialization)

- (BOOL)writeToUserFile:(NSString *)fileName;
- (BOOL)writeToUserFile:(NSString *)fileName inDirectory:(ZUXDirectoryType)directory;
- (BOOL)writeToUserFile:(NSString *)fileName inDirectory:(ZUXDirectoryType)directory subpath:(NSString *)subpath;

@end // UIImage (ZUXSerialization)

#endif /* ZUtilsX_UIImage_ZUX_h */
