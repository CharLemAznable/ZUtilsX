//
//  ZUXBundle.m
//  ZUtilsX
//
//  Created by Char Aznable on 15/11/30.
//  Copyright © 2015年 org.cuc.n3. All rights reserved.
//

#import "ZUXBundle.h"
#import "NSString+ZUX.h"
#import "UIImage+ZUX.h"

@implementation ZUXBundle

+ (NSBundle *)appBundle {
    return [NSBundle bundleForClass:[ZUXBundle class]];
}

+ (UIImage *)imageWithName:(NSString *)imageName {
    return [self imageWithName:imageName bundle:nil];
}

+ (UIImage *)imageForCurrentDeviceWithName:(NSString *)imageName {
    return [self imageForCurrentDeviceWithName:imageName bundle:nil];
}

+ (NSString *)plistPathWithName:(NSString *)fileName {
    return [self plistPathWithName:fileName bundle:nil];
}

+ (NSURL *)audioURLWithName:(NSString *)fileName type:(NSString *)fileType {
    return [self audioURLWithName:fileName type:fileType bundle:nil];
}

+ (UIImage *)imageWithName:(NSString *)imageName bundle:(NSString *)bundleName {
    return [self imageWithName:imageName bundle:bundleName subpath:nil];
}

+ (UIImage *)imageForCurrentDeviceWithName:(NSString *)imageName bundle:(NSString *)bundleName {
    return [self imageForCurrentDeviceWithName:imageName bundle:bundleName subpath:nil];
}

+ (NSString *)plistPathWithName:(NSString *)fileName bundle:(NSString *)bundleName {
    return [self plistPathWithName:fileName bundle:bundleName subpath:nil];
}

+ (NSURL *)audioURLWithName:(NSString *)fileName type:(NSString *)fileType bundle:(NSString *)bundleName {
    return [self audioURLWithName:fileName type:fileType bundle:bundleName subpath:nil];
}

+ (UIImage *)imageWithName:(NSString *)imageName bundle:(NSString *)bundleName subpath:(NSString *)subpath {
    return [UIImage imageWithContentsOfFile:bundleFilePath(imageName, @"png", bundleName, subpath)];
}

+ (UIImage *)imageForCurrentDeviceWithName:(NSString *)imageName bundle:(NSString *)bundleName subpath:(NSString *)subpath {
    return [self imageWithName:[UIImage imageNameForCurrentDeviceNamed:imageName] bundle:bundleName subpath:subpath];
}

+ (NSString *)plistPathWithName:(NSString *)fileName bundle:(NSString *)bundleName subpath:(NSString *)subpath {
    return bundleFilePath(fileName, @"plist", bundleName, subpath);
}

+ (NSURL *)audioURLWithName:(NSString *)fileName type:(NSString *)fileType bundle:(NSString *)bundleName subpath:(NSString *)subpath {
    return [NSURL fileURLWithPath:bundleFilePath(fileName, fileType, bundleName, subpath)];
}

#pragma mark - private functions -

NSString *bundleFilePath(NSString *fileName, NSString *fileType, NSString *bundleName, NSString *subpath) {
    NSBundle *bundle = [ZUXBundle appBundle];
    // if bundleName is nil or empty, search file in mainBundle, subpath defines sub folder reference.
    if (!bundleName || [bundleName isEmpty])
        return [bundle pathForResource:fileName ofType:fileType inDirectory:subpath];
    
    return [[[[bundle resourcePath] stringByAppendingPathComponent:
              [NSString stringWithFormat:@"%@.bundle", bundleName]]
             stringByAppendingPathComponent:subpath]
            stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.%@", fileName, fileType]];
}

@end
