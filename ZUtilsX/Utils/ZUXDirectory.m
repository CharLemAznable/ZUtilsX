//
//  ZUXDirectory.m
//  ZUtilsX
//
//  Created by Char Aznable on 15/11/23.
//  Copyright © 2015年 org.cuc.n3. All rights reserved.
//

#import "ZUXDirectory.h"

@implementation ZUXDirectory

+ (NSString *)fullFilePath:(NSString *)fileName {
    return [self fullFilePath:fileName inDirectory:ZUXDocument];
}

+ (BOOL)fileExists:(NSString *)fileName {
    return [self fileExists:fileName inDirectory:ZUXDocument];
}

+ (BOOL)deleteAllFiles {
    return [self deleteAllFilesInDirectory:ZUXDocument];
}

+ (BOOL)directoryExists:(NSString *)directoryName {
    return [self directoryExists:directoryName inDirectory:ZUXDocument];
}

+ (BOOL)createDirectory:(NSString *)directoryName {
    return [self createDirectory:directoryName inDirectory:ZUXDocument];
}

+ (NSString *)fullFilePath:(NSString *)fileName inDirectory:(ZUXDirectoryType)directory {
    return [self fullFilePath:fileName inDirectory:directory subpath:nil];
}

+ (BOOL)fileExists:(NSString *)fileName inDirectory:(ZUXDirectoryType)directory {
    return [self fileExists:fileName inDirectory:directory subpath:nil];
}

+ (BOOL)deleteAllFilesInDirectory:(ZUXDirectoryType)directory {
    return [self deleteAllFilesInDirectory:directory subpath:nil];
}

+ (BOOL)directoryExists:(NSString *)directoryName inDirectory:(ZUXDirectoryType)directory {
    return [self directoryExists:directoryName inDirectory:directory subpath:nil];
}

+ (BOOL)createDirectory:(NSString *)directoryName inDirectory:(ZUXDirectoryType)directory {
    return [self createDirectory:directoryName inDirectory:directory subpath:nil];
}

+ (NSString *)fullFilePath:(NSString *)fileName inDirectory:(ZUXDirectoryType)directory subpath:(NSString *)subpath {
    return [[[self directoryRoot:directory] stringByAppendingPathComponent:
             subpath] stringByAppendingPathComponent:fileName];
}

+ (BOOL)fileExists:(NSString *)fileName inDirectory:(ZUXDirectoryType)directory subpath:(NSString *)subpath {
    return [[NSFileManager defaultManager] fileExistsAtPath:
            [self fullFilePath:fileName inDirectory:directory subpath:subpath]];
}

+ (BOOL)deleteAllFilesInDirectory:(ZUXDirectoryType)directory subpath:(NSString *)subpath {
    return [[NSFileManager defaultManager] removeItemAtPath:
            [[self directoryRoot:directory] stringByAppendingPathComponent:subpath] error:nil];
}

+ (BOOL)directoryExists:(NSString *)directoryName inDirectory:(ZUXDirectoryType)directory subpath:(NSString *)subpath {
    BOOL isDirectory;
    BOOL exists = [[NSFileManager defaultManager] fileExistsAtPath:
                   [self fullFilePath:directoryName inDirectory:directory subpath:subpath] isDirectory:&isDirectory];
    return exists && isDirectory;
}

+ (BOOL)createDirectory:(NSString *)directoryName inDirectory:(ZUXDirectoryType)directory subpath:(NSString *)subpath {
    return [self directoryExists:directoryName inDirectory:directory subpath:subpath]
    || [[NSFileManager defaultManager] createDirectoryAtPath:[self fullFilePath:directoryName
                                                                    inDirectory:directory subpath:subpath]
                                 withIntermediateDirectories:YES attributes:nil error:nil];
}

+ (NSString *)documentDirectoryRoot {
    return searchPath(NSDocumentDirectory);
}

+ (NSString *)cachesDirectoryRoot {
    return searchPath(NSCachesDirectory);
}

+ (NSString *)temporaryDirectoryRoot {
    return [NSHomeDirectory() stringByAppendingPathComponent:@"tmp"];
}

+ (NSString *)directoryRoot:(ZUXDirectoryType)directory {
    switch (directory) {
        case ZUXDocument:
            return [self documentDirectoryRoot];
        case ZUXCaches:
            return [self cachesDirectoryRoot];
        case ZUXTemporary:
            return [self temporaryDirectoryRoot];
        default:
            return nil;
    }
}

#pragma mark - private functions -

NSString *searchPath(NSSearchPathDirectory directory) {
    return [NSSearchPathForDirectoriesInDomains(directory, NSUserDomainMask, YES) objectAtIndex:0];
}

@end
