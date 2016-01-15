//
//  NSDictionary+ZUX.m
//  ZUtilsX
//
//  Created by Char Aznable on 15/11/13.
//  Copyright © 2015年 org.cuc.n3. All rights reserved.
//

#import "NSDictionary+ZUX.h"
#import "NSObject+ZUX.h"
#import "NSNull+ZUX.h"
#import "ZUXBundle.h"
#import "zarc.h"

@category_interface_generic(NSDictionary, ZUX_COVARIANT_GENERIC2(ZUX_KEY_TYPE, ZUX_OBJECT_TYPE), ZUXSafe)
@end
@category_implementation(NSDictionary, ZUXSafe)

- (id)zux_objectForKey:(id)key {
    if (!key) return nil;
    return [self zux_objectForKey:key];
}

- (id)zux_objectForKeyedSubscript:(id)key {
    if (!key) return nil;
    return [self zux_objectForKeyedSubscript:key];
}

+ (void)load {
    static dispatch_once_t once_t;
    dispatch_once(&once_t, ^{
        [NSClassFromString(@"__NSDictionaryI")
         swizzleInstanceOriSelector:@selector(objectForKey:)
         withNewSelector:@selector(zux_objectForKey:)];
        [NSClassFromString(@"__NSDictionaryI")
         swizzleInstanceOriSelector:@selector(objectForKeyedSubscript:)
         withNewSelector:@selector(zux_objectForKeyedSubscript:)];
    });
}

@end // NSDictionary (ZUXSafe)

@category_interface_generic(NSMutableDictionary, ZUX_GENERIC2(ZUX_KEY_TYPE, ZUX_OBJECT_TYPE), ZUXSafe)
@end
@category_implementation(NSMutableDictionary, ZUXSafe)

- (id)zux_objectForKey:(id)key {
    if (!key) return nil;
    return [self zux_objectForKey:key];
}

- (id)zux_objectForKeyedSubscript:(id)key {
    if (!key) return nil;
    return [self zux_objectForKeyedSubscript:key];
}

- (void)zux_setObject:(id)anObject forKey:(id<NSCopying>)aKey {
    if (!aKey) return;
    if (!anObject) { [self removeObjectForKey:aKey]; return; }
    [self zux_setObject:anObject forKey:aKey];
}

- (void)zux_setObject:(id)anObject forKeyedSubscript:(id<NSCopying>)aKey {
    if (!aKey) return;
    if (!anObject) { [self removeObjectForKey:aKey]; return; }
    [self zux_setObject:anObject forKeyedSubscript:aKey];
}

+ (void)load {
    static dispatch_once_t once_t;
    dispatch_once(&once_t, ^{
        [NSClassFromString(@"__NSDictionaryM")
         swizzleInstanceOriSelector:@selector(objectForKey:)
         withNewSelector:@selector(zux_objectForKey:)];
        [NSClassFromString(@"__NSDictionaryI")
         swizzleInstanceOriSelector:@selector(objectForKeyedSubscript:)
         withNewSelector:@selector(zux_objectForKeyedSubscript:)];
        
        [NSClassFromString(@"__NSDictionaryM")
         swizzleInstanceOriSelector:@selector(setObject:forKey:)
         withNewSelector:@selector(zux_setObject:forKey:)];
        [NSClassFromString(@"__NSDictionaryM")
         swizzleInstanceOriSelector:@selector(setObject:forKeyedSubscript:)
         withNewSelector:@selector(zux_setObject:forKeyedSubscript:)];
    });
}

@end // NSMutableDictionary (ZUXSafe)

@category_implementation(NSDictionary, ZUX)

- (NSDictionary *)deepCopy {
    return [[NSDictionary alloc] initWithDictionary:[NSKeyedUnarchiver unarchiveObjectWithData:
                                                     [NSKeyedArchiver archivedDataWithRootObject:self]]];
}

- (NSMutableDictionary *)deepMutableCopy {
    return [[NSMutableDictionary alloc] initWithDictionary:[NSKeyedUnarchiver unarchiveObjectWithData:
                                                            [NSKeyedArchiver archivedDataWithRootObject:self]]];
}

- (id)objectForKey:(id)key defaultValue:(id)defaultValue {
    id value = [self objectForKey:key];
    return [NSNull isNull:value] ? defaultValue : value;
}

- (NSDictionary *)subDictionaryForKeys:(NSArray *)keys {
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [self enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        if ([keys containsObject:key]) [dict setValue:obj forKey:key];
    }];
    return ZUX_AUTORELEASE([dict copy]);
}

@end // NSDictionary (ZUX)

#if __IPHONE_OS_VERSION_MAX_ALLOWED < 60000
@category_implementation(NSDictionary, ZUXSubscript)

- (id)objectForKeyedSubscript:(id)key {
    return [self objectForKey:key];
}

@end // NSDictionary (ZUXSubscript)

@category_implementation(NSMutableDictionary, ZUXSubscript)

- (void)setObject:(id)obj forKeyedSubscript:(id<NSCopying>)key {
    [self setObject:obj forKey:key];
}

@end // NSMutableDictionary (ZUXSubscript)
#endif // __IPHONE_OS_VERSION_MAX_ALLOWED < 60000

@category_implementation(NSDictionary, ZUXCreation)

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

+ (NSDictionary *)dictionaryWithContentsOfUserFile:(NSString *)fileName {
    return [self dictionaryWithContentsOfUserFile:fileName subpath:nil];
}

+ (NSDictionary *)dictionaryWithContentsOfUserFile:(NSString *)fileName subpath:(NSString *)subpath {
    if ([ZUXDirectory fileExists:fileName inDirectory:ZUXDocument subpath:subpath])
        return [self dictionaryWithContentsOfUserFile:fileName inDirectory:ZUXDocument subpath:subpath];
    return [self dictionaryWithContentsOfUserFile:fileName bundle:nil subpath:subpath];
}

+ (NSDictionary *)dictionaryWithContentsOfUserFile:(NSString *)fileName inDirectory:(ZUXDirectoryType)directory {
    return [self dictionaryWithContentsOfUserFile:fileName inDirectory:directory subpath:nil];
}

+ (NSDictionary *)dictionaryWithContentsOfUserFile:(NSString *)fileName inDirectory:(ZUXDirectoryType)directory subpath:(NSString *)subpath {
    if (ZUX_EXPECT_F(![ZUXDirectory fileExists:fileName inDirectory:directory subpath:subpath])) return nil;
    return [self dictionaryWithContentsOfFile:[ZUXDirectory fullFilePath:fileName inDirectory:directory subpath:subpath]];
}

+ (NSDictionary *)dictionaryWithContentsOfUserFile:(NSString *)fileName bundle:(NSString *)bundleName {
    return [self dictionaryWithContentsOfUserFile:fileName bundle:bundleName subpath:nil];
}

+ (NSDictionary *)dictionaryWithContentsOfUserFile:(NSString *)fileName bundle:(NSString *)bundleName subpath:(NSString *)subpath {
    return [self dictionaryWithContentsOfFile:[ZUXBundle plistPathWithName:fileName bundle:bundleName subpath:subpath]];
}

@end // NSDictionary (ZUXCreation)

@category_implementation(NSDictionary, ZUXSerialization)

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

@end // NSDictionary (ZUXSerialization)
