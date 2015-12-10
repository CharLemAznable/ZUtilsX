//
//  ZUXBundle.m
//  ZUtilsX
//
//  Created by Char Aznable on 15/11/30.
//  Copyright © 2015年 org.cuc.n3. All rights reserved.
//

#import "ZUXBundle.h"
#import "UIImage+ZUX.h"

@implementation ZUXBundle

+ (UIImage *)imageWithName:(NSString *)imageName bundle:(NSString *)bundleName {
    return [UIImage imageWithContentsOfFile:bundleFilePath(bundleName, ZUXBundleImageDirectory, imageName, @"png")];
}

+ (UIImage *)imageForCurrentDeviceWithName:(NSString *)imageName bundle:(NSString *)bundleName {
    ZUX_ENABLE_CATEGORY(ZUX_UIImage);
    return [self imageWithName:[UIImage imageNameForCurrentDeviceNamed:imageName] bundle:bundleName];
}

+ (NSString *)plistPathWithName:(NSString *)fileName bundle:(NSString *)bundleName {
    return bundleFilePath(bundleName, ZUXBundleDocumentDirectory, fileName, @"plist");
}

+ (NSURL *)audioURLWithName:(NSString *)fileName type:(NSString *)fileType bundle:(NSString *)bundleName {
    return [NSURL fileURLWithPath:bundleFilePath(bundleName, ZUXBundleAudioDirectory, fileName, fileType)];
}

#pragma mark - private functions.

NSString *bundleFilePath(NSString *bundleName, NSString *dirName, NSString *fileName, NSString *suffix) {
    // if bundleName is nil, search file in mainBundle, ignore the sub directory(dirName).
    if (!bundleName) return [[NSBundle mainBundle] pathForResource:fileName ofType:suffix];
    
    return [[[[[NSBundle mainBundle] resourcePath]
              stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.bundle", bundleName]]
             stringByAppendingPathComponent:dirName]
            stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.%@", fileName, suffix]];
}

@end
