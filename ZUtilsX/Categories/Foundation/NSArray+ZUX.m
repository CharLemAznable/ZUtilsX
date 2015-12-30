//
//  NSArray+ZUX.m
//  ZUtilsX
//
//  Created by Char Aznable on 15/11/13.
//  Copyright © 2015年 org.cuc.n3. All rights reserved.
//

#import "NSArray+ZUX.h"
#import "NSObject+ZUX.h"
#import "NSNull+ZUX.h"
#import "ZUXBundle.h"
#import "zarc.h"

ZUX_CATEGORY_M(ZUX_NSArray)

@interface NSArray (ZUXSafe)
@end
@implementation NSArray (ZUXSafe)

- (id)zux_objectAtIndex:(NSUInteger)index {
    if (index >= [self count]) return nil;
    return [self zux_objectAtIndex:index];
}

- (id)zux_objectAtIndexedSubscript:(NSUInteger)index {
    if (index >= [self count]) return nil;
    return [self zux_objectAtIndexedSubscript:index];
}

+ (void)load {
    static dispatch_once_t once_t;
    dispatch_once(&once_t, ^{
        ZUX_ENABLE_CATEGORY(ZUX_NSObject);
        [NSClassFromString(@"__NSArrayI")
         swizzleInstanceOriSelector:@selector(objectAtIndex:)
         withNewSelector:@selector(zux_objectAtIndex:)];
        [NSClassFromString(@"__NSArrayI")
         swizzleInstanceOriSelector:@selector(objectAtIndexedSubscript:)
         withNewSelector:@selector(zux_objectAtIndexedSubscript:)];
    });
}

@end // NSArray (ZUXSafe)

@interface NSMutableArray (ZUXSafe)
@end
@implementation NSMutableArray (ZUXSafe)

- (id)zux_objectAtIndex:(NSUInteger)index {
    if (index >= [self count]) return nil;
    return [self zux_objectAtIndex:index];
}

- (id)zux_objectAtIndexedSubscript:(NSUInteger)index {
    if (index >= [self count]) return nil;
    return [self zux_objectAtIndexedSubscript:index];
}

- (void)zux_setObject:(id)anObject atIndexedSubscript:(NSUInteger)index {
    if (!anObject) return;
    [self zux_setObject:anObject atIndexedSubscript:index];
}

- (void)zux_addObject:(id)anObject {
    if (!anObject) return;
    [self zux_addObject:anObject];
}

- (void)zux_insertObject:(id)anObject atIndex:(NSUInteger)index {
    if (!anObject) return;
    [self zux_insertObject:anObject atIndex:index];
}

- (void)zux_replaceObjectAtIndex:(NSUInteger)index withObject:(id)anObject {
    if (!anObject) return;
    [self zux_replaceObjectAtIndex:index withObject:anObject];
}

+ (void)load {
    static dispatch_once_t once_t;
    dispatch_once(&once_t, ^{
        ZUX_ENABLE_CATEGORY(ZUX_NSObject);
        [NSClassFromString(@"__NSArrayM")
         swizzleInstanceOriSelector:@selector(objectAtIndex:)
         withNewSelector:@selector(zux_objectAtIndex:)];
        [NSClassFromString(@"__NSArrayM")
         swizzleInstanceOriSelector:@selector(objectAtIndexedSubscript:)
         withNewSelector:@selector(zux_objectAtIndexedSubscript:)];
        [NSClassFromString(@"__NSArrayM")
         swizzleInstanceOriSelector:@selector(setObject:atIndexedSubscript:)
         withNewSelector:@selector(zux_setObject:atIndexedSubscript:)];
        
        [NSClassFromString(@"__NSArrayM")
         swizzleInstanceOriSelector:@selector(addObject:)
         withNewSelector:@selector(zux_addObject:)];
        [NSClassFromString(@"__NSArrayM")
         swizzleInstanceOriSelector:@selector(insertObject:atIndex:)
         withNewSelector:@selector(zux_insertObject:atIndex:)];
        [NSClassFromString(@"__NSArrayM")
         swizzleInstanceOriSelector:@selector(replaceObjectAtIndex:withObject:)
         withNewSelector:@selector(zux_replaceObjectAtIndex:withObject:)];
    });
}

@end // NSMutableArray (ZUXSafe)

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
    return [NSNull isNull:[self objectAtIndex:index]] ? defaultValue : [self objectAtIndex:index];
}

@end // NSArray (ZUX)

#if __IPHONE_OS_VERSION_MAX_ALLOWED < 60000
@implementation NSArray (ZUXSubscript)

- (id)objectAtIndexedSubscript:(NSUInteger)index {
    return [self objectAtIndex:index];
}

@end // NSArray (ZUXSubscript)

@implementation NSMutableArray (ZUXSubscript)

- (void)setObject:(id)obj atIndexedSubscript:(NSUInteger)index {
    [self replaceObjectAtIndex:index withObject:obj];
}

@end // NSMutableArray (ZUXSubscript)
#endif // __IPHONE_OS_VERSION_MAX_ALLOWED < 60000

@implementation NSArray (ZUXCreation)

- (ZUX_INSTANCETYPE)initWithContentsOfUserFile:(NSString *)fileName {
    return [self initWithContentsOfUserFile:fileName subpath:nil];
}

- (ZUX_INSTANCETYPE)initWithContentsOfUserFile:(NSString *)fileName subpath:(NSString *)subpath {
    if ([ZUXDirectory fileExists:fileName inDirectory:ZUXDocument subpath:subpath])
        return [self initWithContentsOfUserFile:fileName inDirectory:ZUXDocument subpath:subpath];
    return [self initWithContentsOfUserFile:fileName bundle:nil subpath:subpath];
}

- (ZUX_INSTANCETYPE)initWithContentsOfUserFile:(NSString *)fileName inDirectory:(ZUXDirectoryType)directory {
    return [self initWithContentsOfUserFile:fileName inDirectory:directory subpath:nil];
}

- (ZUX_INSTANCETYPE)initWithContentsOfUserFile:(NSString *)fileName inDirectory:(ZUXDirectoryType)directory subpath:(NSString *)subpath {
    if (ZUX_EXPECT_F(![ZUXDirectory fileExists:fileName inDirectory:directory subpath:subpath])) return nil;
    return [self initWithContentsOfFile:[ZUXDirectory fullFilePath:fileName inDirectory:directory subpath:subpath]];
}

- (ZUX_INSTANCETYPE)initWithContentsOfUserFile:(NSString *)fileName bundle:(NSString *)bundleName {
    return [self initWithContentsOfUserFile:fileName bundle:bundleName subpath:nil];
}

- (ZUX_INSTANCETYPE)initWithContentsOfUserFile:(NSString *)fileName bundle:(NSString *)bundleName subpath:(NSString *)subpath {
    return [self initWithContentsOfFile:[ZUXBundle plistPathWithName:fileName bundle:bundleName subpath:subpath]];
}

+ (NSArray *)arrayWithContentsOfUserFile:(NSString *)fileName {
    return [self arrayWithContentsOfUserFile:fileName subpath:nil];
}

+ (NSArray *)arrayWithContentsOfUserFile:(NSString *)fileName subpath:(NSString *)subpath {
    if ([ZUXDirectory fileExists:fileName inDirectory:ZUXDocument subpath:subpath])
        return [self arrayWithContentsOfUserFile:fileName inDirectory:ZUXDocument subpath:subpath];
    return [self arrayWithContentsOfUserFile:fileName bundle:nil subpath:subpath];
}

+ (NSArray *)arrayWithContentsOfUserFile:(NSString *)fileName inDirectory:(ZUXDirectoryType)directory {
    return [self arrayWithContentsOfUserFile:fileName inDirectory:directory subpath:nil];
}

+ (NSArray *)arrayWithContentsOfUserFile:(NSString *)fileName inDirectory:(ZUXDirectoryType)directory subpath:(NSString *)subpath {
    if (ZUX_EXPECT_F(![ZUXDirectory fileExists:fileName inDirectory:directory subpath:subpath])) return nil;
    return [self arrayWithContentsOfFile:[ZUXDirectory fullFilePath:fileName inDirectory:directory subpath:subpath]];
}

+ (NSArray *)arrayWithContentsOfUserFile:(NSString *)fileName bundle:(NSString *)bundleName {
    return [self arrayWithContentsOfUserFile:fileName bundle:bundleName subpath:nil];
}

+ (NSArray *)arrayWithContentsOfUserFile:(NSString *)fileName bundle:(NSString *)bundleName subpath:(NSString *)subpath {
    return [self arrayWithContentsOfFile:[ZUXBundle plistPathWithName:fileName bundle:bundleName subpath:subpath]];
}

@end // NSArray (ZUXCreation)

@implementation NSArray (ZUXSerialization)

- (BOOL)writeToUserFile:(NSString *)fileName {
    return [self writeToUserFile:fileName inDirectory:ZUXDocument];
}

- (BOOL)writeToUserFile:(NSString *)fileName inDirectory:(ZUXDirectoryType)directory {
    return [self writeToUserFile:fileName inDirectory:directory subpath:nil];
}

- (BOOL)writeToUserFile:(NSString *)fileName inDirectory:(ZUXDirectoryType)directory subpath:(NSString *)subpath {
    if (ZUX_EXPECT_F(![ZUXDirectory createDirectory:[fileName stringByDeletingLastPathComponent]
                                        inDirectory:directory subpath:subpath])) return NO;
    return [self writeToFile:[ZUXDirectory fullFilePath:fileName inDirectory:directory subpath:subpath] atomically:YES];
}

@end // NSArray (ZUXSerialization)
