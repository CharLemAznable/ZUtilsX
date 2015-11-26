//
//  UIImage+ZUX.h
//  ZUtilsX
//
//  Created by Char Aznable on 15/11/13.
//  Copyright © 2015年 org.cuc.n3. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZUXCategory.h"
#import "ZUXDirectory.h"

#ifndef ZUtilsX_UIImage_ZUX_h
#define ZUtilsX_UIImage_ZUX_h

ZUX_CATEGORY_H(ZUX_UIImage)

@interface UIImage (ZUX)

+ (UIImage *)imageRectWithColor:(UIColor *)color size:(CGSize)size;
+ (UIImage *)imageGradientRectWithStartColor:(UIColor *)startColor endColor:(UIColor *)endColor direction:(CGVector)direction size:(CGSize)size;
+ (UIImage *)imageGradientRectWithColors:(NSArray *)colors locations:(NSArray *)locations direction:(CGVector)direction size:(CGSize)size;
+ (UIImage *)imageEllipseWithColor:(UIColor *)color size:(CGSize)size;
+ (UIImage *)imageForCurrentDeviceNamed:(NSString *)name;

@end // UIImage (ZUX)

@interface UIImage (ZUXDirectory)

- (BOOL)writeToUserFile:(NSString *)filePath;
+ (UIImage *)imageWithContentsOfUserFile:(NSString *)filePath;

- (BOOL)writeToUserFile:(NSString *)filePath inDirectory:(ZUXDirectoryType)directory;
+ (UIImage *)imageWithContentsOfUserFile:(NSString *)filePath inDirectory:(ZUXDirectoryType)directory;

@end // UIImage (ZUXDirectory)

#endif /* ZUtilsX_UIImage_ZUX_h */
