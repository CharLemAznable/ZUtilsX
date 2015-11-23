//
//  NSArray+ZUX.m
//  ZUtilsX
//
//  Created by Char Aznable on 15/11/13.
//  Copyright © 2015年 org.cuc.n3. All rights reserved.
//

#import "NSArray+ZUX.h"
#import "NSNull+ZUX.h"

ZUX_CATEGORY_M(ZUX_NSArray)

@implementation NSArray (ZUX)

- (NSArray *)deepCopy {
    return [[NSArray alloc] initWithArray:self copyItems:YES];
}

- (NSMutableArray *)deepMutableCopy {
    return [[NSMutableArray alloc] initWithArray:self copyItems:YES];
}

- (id)objectAtIndex:(NSUInteger)index defaultValue:(id)defaultValue {
    ZUX_ENABLE_CATEGORY(ZUX_NSNull);
    return index >= [self count] || [NSNull isNull:[self objectAtIndex:index]] ? defaultValue : [self objectAtIndex:index];
}

@end

@implementation NSArray (ZUXDirectory)

- (BOOL)writeToUserFile:(NSString *)filePath {
    return [self writeToUserFile:filePath inDirectory:ZUXDocument];
}

+ (NSArray *)arrayWithContentsOfUserFile:(NSString *)filePath {
    return [self arrayWithContentsOfUserFile:filePath inDirectory:ZUXDocument];
}

- (BOOL)writeToUserFile:(NSString *)filePath inDirectory:(ZUXDirectoryType)directory {
    if (![ZUXDirectory createDirectory:[filePath stringByDeletingLastPathComponent]
                           inDirectory:directory]) return NO;
    return [self writeToFile:[ZUXDirectory fullFilePath:filePath inDirectory:directory]
                  atomically:YES];
}

+ (NSArray *)arrayWithContentsOfUserFile:(NSString *)filePath inDirectory:(ZUXDirectoryType)directory {
    if (![ZUXDirectory fileExists:filePath inDirectory:directory]) return nil;
    return [NSArray arrayWithContentsOfFile:[ZUXDirectory fullFilePath:filePath inDirectory:directory]];
}

@end
