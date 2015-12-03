//
//  ZUXDirectory.h
//  ZUtilsX
//
//  Created by Char Aznable on 15/11/23.
//  Copyright © 2015年 org.cuc.n3. All rights reserved.
//

#import <Foundation/Foundation.h>

#ifndef ZUtilsX_ZUXDirectory_h
#define ZUtilsX_ZUXDirectory_h

typedef NS_ENUM(NSUInteger, ZUXDirectoryType) {
    ZUXDocument     = 0,
    ZUXCaches       = 1,
    ZUXTemporary    = 2
};

@interface ZUXDirectory : NSObject

+ (NSString *)fullFilePath:(NSString *)filePath;
+ (BOOL)fileExists:(NSString *)filePath;
+ (BOOL)createDirectory:(NSString *)directoryPath;
+ (BOOL)deleteAllFiles;

+ (NSString *)fullFilePath:(NSString *)filePath inDirectory:(ZUXDirectoryType)directory;
+ (BOOL)fileExists:(NSString *)filePath inDirectory:(ZUXDirectoryType)directory;
+ (BOOL)createDirectory:(NSString *)directoryPath inDirectory:(ZUXDirectoryType)directory;
+ (BOOL)deleteAllFilesInDirectory:(ZUXDirectoryType)directory;

+ (NSString *)documentDirectoryRoot;
+ (NSString *)cachesDirectoryRoot;
+ (NSString *)temporaryDirectoryRoot;
+ (NSString *)directoryRoot:(ZUXDirectoryType)directory;

@end

#endif /* ZUtilsX_ZUXDirectory_h */
