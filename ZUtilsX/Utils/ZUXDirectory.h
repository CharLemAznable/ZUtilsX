//
//  ZUXDirectory.h
//  ZUtilsX
//
//  Created by Char Aznable on 15/11/23.
//  Copyright © 2015年 org.cuc.n3. All rights reserved.
//

#ifndef ZUtilsX_ZUXDirectory_h
#define ZUtilsX_ZUXDirectory_h

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, ZUXDirectoryType) {
    ZUXDocument     = 0,
    ZUXCaches       = 1,
    ZUXTemporary    = 2
};

@interface ZUXDirectory : NSObject

+ (NSString *)fullFilePath:(NSString *)fileName;
+ (BOOL)fileExists:(NSString *)fileName;
+ (BOOL)deleteAllFiles;
+ (BOOL)directoryExists:(NSString *)directoryName;
+ (BOOL)createDirectory:(NSString *)directoryName;

+ (NSString *)fullFilePath:(NSString *)fileName inDirectory:(ZUXDirectoryType)directory;
+ (BOOL)fileExists:(NSString *)fileName inDirectory:(ZUXDirectoryType)directory;
+ (BOOL)deleteAllFilesInDirectory:(ZUXDirectoryType)directory;
+ (BOOL)directoryExists:(NSString *)directoryName inDirectory:(ZUXDirectoryType)directory;
+ (BOOL)createDirectory:(NSString *)directoryName inDirectory:(ZUXDirectoryType)directory;

+ (NSString *)fullFilePath:(NSString *)fileName inDirectory:(ZUXDirectoryType)directory subpath:(NSString *)subpath;
+ (BOOL)fileExists:(NSString *)fileName inDirectory:(ZUXDirectoryType)directory subpath:(NSString *)subpath;
+ (BOOL)deleteAllFilesInDirectory:(ZUXDirectoryType)directory subpath:(NSString *)subpath;
+ (BOOL)directoryExists:(NSString *)directoryName inDirectory:(ZUXDirectoryType)directory subpath:(NSString *)subpath;
+ (BOOL)createDirectory:(NSString *)directoryName inDirectory:(ZUXDirectoryType)directory subpath:(NSString *)subpath;

+ (NSString *)documentDirectoryRoot;
+ (NSString *)cachesDirectoryRoot;
+ (NSString *)temporaryDirectoryRoot;
+ (NSString *)directoryRoot:(ZUXDirectoryType)directory;

@end

#endif /* ZUtilsX_ZUXDirectory_h */
