//
//  ZUXBundle.h
//  ZUtilsX
//
//  Created by Char Aznable on 15/11/30.
//  Copyright © 2015年 org.cuc.n3. All rights reserved.
//

#import <UIKit/UIKit.h>

#ifndef ZUtilsX_ZUXBundle_h
#define ZUtilsX_ZUXBundle_h

@interface ZUXBundle : NSObject

+ (UIImage *)imageWithName:(NSString *)imageName;
+ (UIImage *)imageForCurrentDeviceWithName:(NSString *)imageName;
+ (NSString *)plistPathWithName:(NSString *)fileName;
+ (NSURL *)audioURLWithName:(NSString *)fileName type:(NSString *)fileType;

+ (UIImage *)imageWithName:(NSString *)imageName bundle:(NSString *)bundleName;
+ (UIImage *)imageForCurrentDeviceWithName:(NSString *)imageName bundle:(NSString *)bundleName;
+ (NSString *)plistPathWithName:(NSString *)fileName bundle:(NSString *)bundleName;
+ (NSURL *)audioURLWithName:(NSString *)fileName type:(NSString *)fileType bundle:(NSString *)bundleName;

+ (UIImage *)imageWithName:(NSString *)imageName bundle:(NSString *)bundleName subpath:(NSString *)subpath;
+ (UIImage *)imageForCurrentDeviceWithName:(NSString *)imageName bundle:(NSString *)bundleName subpath:(NSString *)subpath;
+ (NSString *)plistPathWithName:(NSString *)fileName bundle:(NSString *)bundleName subpath:(NSString *)subpath;
+ (NSURL *)audioURLWithName:(NSString *)fileName type:(NSString *)fileType bundle:(NSString *)bundleName subpath:(NSString *)subpath;

@end

#endif /* ZUtilsX_ZUXBundle_h */
