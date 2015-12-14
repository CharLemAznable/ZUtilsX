//
//  NSArray+ZUX.m
//  ZUtilsX
//
//  Created by Char Aznable on 15/11/13.
//  Copyright © 2015年 org.cuc.n3. All rights reserved.
//

#import "NSArray+ZUX.h"
#import "NSNull+ZUX.h"
#import "ZUXBundle.h"
#import "zarc.h"

ZUX_CATEGORY_M(ZUX_NSArray)

@implementation NSArray (ZUX)

- (NSArray *)deepCopy {
    return [[NSArray alloc] initWithArray:[NSKeyedUnarchiver unarchiveObjectWithData:
                                           [NSKeyedArchiver archivedDataWithRootObject:self]]];
}

- (NSMutableArray *)deepMutableCopy {
    return [[NSMutableArray alloc] initWithArray:[NSKeyedUnarchiver unarchiveObjectWithData:
                                                  [NSKeyedArchiver archivedDataWithRootObject:self]]];
}

- (id)objectAtIndex:(NSUInteger)index defaultValue:(id)defaultValue {
    ZUX_ENABLE_CATEGORY(ZUX_NSNull);
    return index >= [self count] || [NSNull isNull:[self objectAtIndex:index]] ? defaultValue : [self objectAtIndex:index];
}

@end

#if __IPHONE_OS_VERSION_MAX_ALLOWED < 60000
@implementation NSArray (ZUXSubscript)

- (id)objectAtIndexedSubscript:(NSUInteger)idx {
    return [self objectAtIndex:idx];
}

@end

@implementation NSMutableArray (ZUXSubscript)

- (void)setObject:(id)obj atIndexedSubscript:(NSUInteger)idx {
    [self replaceObjectAtIndex:idx withObject:obj];
}

@end
#endif // __IPHONE_OS_VERSION_MAX_ALLOWED < 60000

@implementation NSArray (ZUXDirectory)

- (BOOL)writeToUserFile:(NSString *)filePath {
    return [self writeToUserFile:filePath inDirectory:ZUXDocument];
}

+ (NSArray *)arrayWithContentsOfUserFile:(NSString *)filePath {
    return [self arrayWithContentsOfUserFile:filePath inDirectory:ZUXDocument];
}

- (BOOL)writeToUserFile:(NSString *)filePath inDirectory:(ZUXDirectoryType)directory {
    if (ZUX_EXPECT_F(![ZUXDirectory createDirectory:[filePath stringByDeletingLastPathComponent]
                                        inDirectory:directory])) return NO;
    return [self writeToFile:[ZUXDirectory fullFilePath:filePath inDirectory:directory]
                  atomically:YES];
}

+ (NSArray *)arrayWithContentsOfUserFile:(NSString *)filePath inDirectory:(ZUXDirectoryType)directory {
    if (ZUX_EXPECT_F(![ZUXDirectory fileExists:filePath inDirectory:directory])) return nil;
    return [NSArray arrayWithContentsOfFile:[ZUXDirectory fullFilePath:filePath inDirectory:directory]];
}

@end

@implementation NSArray (ZUXBundle)

+ (NSArray *)arrayWithContentsOfUserFile:(NSString *)fileName bundle:(NSString *)bundleName {
    return [self arrayWithContentsOfUserFile:fileName bundle:bundleName subpath:nil];
}

+ (NSArray *)arrayWithContentsOfUserFile:(NSString *)fileName bundle:(NSString *)bundleName subpath:(NSString *)subpath {
    return [self arrayWithContentsOfFile:[ZUXBundle plistPathWithName:fileName bundle:bundleName subpath:subpath]];
}

@end
