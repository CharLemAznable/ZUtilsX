//
//  ZUXColorDictionary.m
//  ZUtilsX
//
//  Created by Char Aznable on 15/12/10.
//  Copyright © 2015年 org.cuc.n3. All rights reserved.
//

#import "ZUXColorDictionary.h"
#import "NSDictionary+ZUX.h"
#import "UIColor+ZUX.h"
#import "zarc.h"

@interface ZUXColorDictionary () {
    NSDictionary *_colors;
}
- (UIColor *)objectForKeyedSubscript:(NSString *)key;
@end

@implementation ZUXColorDictionary

- (ZUX_INSTANCETYPE)init {
    return [self initWithDictionary:nil];
}

- (ZUX_INSTANCETYPE)initWithDictionary:(NSDictionary *)dictionary {
    if (ZUX_EXPECT_T(self = [super init])) {
        _colors = ZUX_RETAIN(buildColorDictionary(dictionary));
    }
    return self;
}

- (ZUX_INSTANCETYPE)initWithContentsOfUserFile:(NSString *)filePath {
    return [self initWithContentsOfUserFile:filePath inDirectory:ZUXDocument];
}

- (ZUX_INSTANCETYPE)initWithContentsOfUserFile:(NSString *)filePath inDirectory:(ZUXDirectoryType)directory {
    ZUX_ENABLE_CATEGORY(ZUX_NSDictionary);
    return [self initWithDictionary:[NSDictionary dictionaryWithContentsOfUserFile:filePath inDirectory:directory]];
}

- (ZUX_INSTANCETYPE)initWithContentsOfUserFile:(NSString *)fileName bundle:(NSString *)bundleName {
    return [self initWithContentsOfUserFile:fileName bundle:bundleName subpath:nil];
}

- (ZUX_INSTANCETYPE)initWithContentsOfUserFile:(NSString *)fileName bundle:(NSString *)bundleName subpath:(NSString *)subpath {
    ZUX_ENABLE_CATEGORY(ZUX_NSDictionary);
    return [self initWithDictionary:[NSDictionary dictionaryWithContentsOfUserFile:fileName bundle:bundleName subpath:subpath]];
}

- (void)dealloc {
    ZUX_RELEASE(_colors);
    ZUX_SUPER_DEALLOC;
}

- (void)reloadWithDictionary:(NSDictionary *)dictionary {
    ZUX_RELEASE(_colors);
    _colors = ZUX_RETAIN(buildColorDictionary(dictionary));
}

- (void)reloadWithContentsOfUserFile:(NSString *)filePath {
    [self reloadWithContentsOfUserFile:filePath inDirectory:ZUXDocument];
}

- (void)reloadWithContentsOfUserFile:(NSString *)filePath inDirectory:(ZUXDirectoryType)directory {
    ZUX_ENABLE_CATEGORY(ZUX_NSDictionary);
    [self reloadWithDictionary:[NSDictionary dictionaryWithContentsOfUserFile:filePath inDirectory:directory]];
}

- (void)reloadWithContentsOfUserFile:(NSString *)fileName bundle:(NSString *)bundleName {
    [self reloadWithContentsOfUserFile:fileName bundle:bundleName subpath:nil];
}

- (void)reloadWithContentsOfUserFile:(NSString *)fileName bundle:(NSString *)bundleName subpath:(NSString *)subpath {
    ZUX_ENABLE_CATEGORY(ZUX_NSDictionary);
    [self reloadWithDictionary:[NSDictionary dictionaryWithContentsOfUserFile:fileName bundle:bundleName subpath:subpath]];
}

- (UIColor *)colorForKey:(NSString *)key {
    return [_colors objectForKey:key];
}

- (UIColor *)objectForKeyedSubscript:(NSString *)key {
    return [_colors objectForKey:key];
}

#pragma mark - implementation functions.

ZUX_STATIC_INLINE NSDictionary *buildColorDictionary(NSDictionary *srcDictionary) {
    if (ZUX_EXPECT_F(!srcDictionary)) return nil;
    ZUX_ENABLE_CATEGORY(ZUX_UIColor);
    NSMutableDictionary *dstDictionary = ZUX_AUTORELEASE([[NSMutableDictionary alloc] init]);
    [srcDictionary enumerateKeysAndObjectsUsingBlock:
     ^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
         if ([obj isKindOfClass:[UIColor class]]) {
             [dstDictionary setObject:obj forKey:key];
         } else if ([obj isKindOfClass:[NSString class]]) {
             [dstDictionary setObject:[UIColor colorWithRGBAHexString:obj] forKey:key];
         }
     }];
    return ZUX_AUTORELEASE([dstDictionary copy]);
}

@end
