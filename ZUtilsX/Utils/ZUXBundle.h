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

static NSString *ZUXBundleImageDirectory = @"images";
static NSString *ZUXBundleDocumentDirectory = @"files";
static NSString *ZUXBundleAudioDirectory = @"audios";

@interface ZUXBundle : NSObject

+ (UIImage *)imageWithName:(NSString *)imageName bundle:(NSString *)bundleName;
+ (UIImage *)imageForCurrentDeviceWithName:(NSString *)imageName bundle:(NSString *)bundleName;
+ (NSString *)plistPathWithName:(NSString *)fileName bundle:(NSString *)bundleName;
+ (NSURL *)audioURLWithName:(NSString *)fileName type:(NSString *)fileType bundle:(NSString *)bundleName;

@end

#endif /* ZUtilsX_ZUXBundle_h */
