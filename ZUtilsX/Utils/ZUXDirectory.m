//
//  ZUXDirectory.m
//  ZUtilsX
//
//  Created by Char Aznable on 15/11/23.
//  Copyright © 2015年 org.cuc.n3. All rights reserved.
//

#import "ZUXDirectory.h"

@implementation ZUXDirectory

+ (NSString *)fullFilePath:(NSString *)filePath {
    return [self fullFilePath:filePath inDirectory:ZUXDocument];
}

+ (NSString *)fullFilePath:(NSString *)filePath inDirectory:(ZUXDirectoryType)directory {
    return [[self directoryRoot:directory] stringByAppendingPathComponent:filePath];
}

+ (BOOL)fileExists:(NSString *)filePath {
    return [self fileExists:filePath inDirectory:ZUXDocument];
}

+ (BOOL)fileExists:(NSString *)filePath inDirectory:(ZUXDirectoryType)directory {
    NSString *fullFilePath = [self fullFilePath:filePath inDirectory:directory];
    return [[NSFileManager defaultManager] fileExistsAtPath:fullFilePath];
}

+ (BOOL)createDirectory:(NSString *)directoryPath {
    return [self createDirectory:directoryPath inDirectory:ZUXDocument];
}

+ (BOOL)createDirectory:(NSString *)directoryPath inDirectory:(ZUXDirectoryType)directory {
    return [[NSFileManager defaultManager] createDirectoryAtPath:[self fullFilePath:directoryPath
                                                                        inDirectory:directory]
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

#pragma mark - private functions.

NSString *searchPath(NSSearchPathDirectory directory) {
    return [NSSearchPathForDirectoriesInDomains(directory, NSUserDomainMask, YES) objectAtIndex:0];
}

@end
