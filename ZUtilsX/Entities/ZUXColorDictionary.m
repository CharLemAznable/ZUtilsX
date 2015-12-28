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
@end

@implementation ZUXColorDictionary

+ (void)load {
    [super load];
    ZUX_ENABLE_CATEGORY(ZUX_NSDictionary);
    ZUX_ENABLE_CATEGORY(ZUX_UIColor);
}

- (ZUX_INSTANCETYPE)init {
    return [self initWithDictionary:nil];
}

- (void)dealloc {
    ZUX_RELEASE(_colors);
    ZUX_SUPER_DEALLOC;
}

#pragma mark - initializations -

- (ZUX_INSTANCETYPE)initWithDictionary:(NSDictionary *)dictionary {
    if (ZUX_EXPECT_T(self = [super init])) {
        _colors = ZUX_RETAIN(buildColorDictionary(dictionary));
    }
    return self;
}

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
    return [self initWithDictionary:
            [NSDictionary dictionaryWithContentsOfUserFile:fileName inDirectory:directory subpath:subpath]];
}

- (ZUX_INSTANCETYPE)initWithContentsOfUserFile:(NSString *)fileName bundle:(NSString *)bundleName {
    return [self initWithContentsOfUserFile:fileName bundle:bundleName subpath:nil];
}

- (ZUX_INSTANCETYPE)initWithContentsOfUserFile:(NSString *)fileName bundle:(NSString *)bundleName subpath:(NSString *)subpath {
    return [self initWithDictionary:
            [NSDictionary dictionaryWithContentsOfUserFile:fileName bundle:bundleName subpath:subpath]];
}

#pragma mark - Conveniences -

+ (ZUXColorDictionary *)colorDictionaryWithDictionary:(NSDictionary *)dictionary {
    return ZUX_AUTORELEASE([[self alloc] initWithDictionary:dictionary]);
}

+ (ZUXColorDictionary *)colorDictionaryWithContentsOfUserFile:(NSString *)fileName {
    return [self colorDictionaryWithContentsOfUserFile:fileName subpath:nil];
}

+ (ZUXColorDictionary *)colorDictionaryWithContentsOfUserFile:(NSString *)fileName subpath:(NSString *)subpath {
    if ([ZUXDirectory fileExists:fileName inDirectory:ZUXDocument subpath:subpath])
        return [self colorDictionaryWithContentsOfUserFile:fileName inDirectory:ZUXDocument subpath:subpath];
    return [self colorDictionaryWithContentsOfUserFile:fileName bundle:nil subpath:subpath];
}

+ (ZUXColorDictionary *)colorDictionaryWithContentsOfUserFile:(NSString *)fileName inDirectory:(ZUXDirectoryType)directory {
    return [self colorDictionaryWithContentsOfUserFile:fileName inDirectory:directory subpath:nil];
}

+ (ZUXColorDictionary *)colorDictionaryWithContentsOfUserFile:(NSString *)fileName inDirectory:(ZUXDirectoryType)directory subpath:(NSString *)subpath {
    return [self colorDictionaryWithDictionary:
            [NSDictionary dictionaryWithContentsOfUserFile:fileName inDirectory:directory subpath:subpath]];
}

+ (ZUXColorDictionary *)colorDictionaryWithContentsOfUserFile:(NSString *)fileName bundle:(NSString *)bundleName {
    return [self colorDictionaryWithContentsOfUserFile:fileName bundle:bundleName subpath:nil];
}

+ (ZUXColorDictionary *)colorDictionaryWithContentsOfUserFile:(NSString *)fileName bundle:(NSString *)bundleName subpath:(NSString *)subpath {
    return [self colorDictionaryWithDictionary:
            [NSDictionary dictionaryWithContentsOfUserFile:fileName bundle:bundleName subpath:subpath]];
}

#pragma mark - reloaders -

- (void)reloadWithDictionary:(NSDictionary *)dictionary {
    ZUX_RELEASE(_colors);
    _colors = ZUX_RETAIN(buildColorDictionary(dictionary));
}

- (void)reloadWithContentsOfUserFile:(NSString *)fileName {
    [self reloadWithContentsOfUserFile:fileName subpath:nil];
}

- (void)reloadWithContentsOfUserFile:(NSString *)fileName subpath:(NSString *)subpath {
    if ([ZUXDirectory fileExists:fileName inDirectory:ZUXDocument subpath:subpath])
        [self reloadWithContentsOfUserFile:fileName inDirectory:ZUXDocument subpath:subpath];
    [self reloadWithContentsOfUserFile:fileName bundle:nil subpath:subpath];
}

- (void)reloadWithContentsOfUserFile:(NSString *)fileName inDirectory:(ZUXDirectoryType)directory {
    [self reloadWithContentsOfUserFile:fileName inDirectory:directory subpath:nil];
}

- (void)reloadWithContentsOfUserFile:(NSString *)fileName inDirectory:(ZUXDirectoryType)directory subpath:(NSString *)subpath {
    [self reloadWithDictionary:
     [NSDictionary dictionaryWithContentsOfUserFile:fileName inDirectory:directory subpath:subpath]];
}

- (void)reloadWithContentsOfUserFile:(NSString *)fileName bundle:(NSString *)bundleName {
    [self reloadWithContentsOfUserFile:fileName bundle:bundleName subpath:nil];
}

- (void)reloadWithContentsOfUserFile:(NSString *)fileName bundle:(NSString *)bundleName subpath:(NSString *)subpath {
    [self reloadWithDictionary:
     [NSDictionary dictionaryWithContentsOfUserFile:fileName bundle:bundleName subpath:subpath]];
}

#pragma mark -

- (UIColor *)colorForKey:(NSString *)key {
    return [_colors objectForKey:key];
}

- (UIColor *)objectForKeyedSubscript:(NSString *)key {
    return [_colors objectForKey:key];
}

#pragma mark - implementation functions -

ZUX_STATIC_INLINE NSDictionary *buildColorDictionary(NSDictionary *srcDictionary) {
    if (ZUX_EXPECT_F(!srcDictionary)) return nil;
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
