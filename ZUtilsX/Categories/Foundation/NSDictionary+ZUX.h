//
//  NSDictionary+ZUX.h
//  ZUtilsX
//
//  Created by Char Aznable on 15/11/13.
//  Copyright © 2015年 org.cuc.n3. All rights reserved.
//

#ifndef ZUtilsX_NSDictionary_ZUX_h
#define ZUtilsX_NSDictionary_ZUX_h

#import <Foundation/Foundation.h>
#import "ZUXCategory.h"
#import "ZUXDirectory.h"
#import "zobjc.h"

@category_interface_generic(NSDictionary, ZUX_COVARIANT_GENERIC2(ZUX_KEY_TYPE, ZUX_OBJECT_TYPE), ZUX)

- (NSDictionary ZUX_GENERIC2(ZUX_KEY_TYPE, ZUX_OBJECT_TYPE) *)deepCopy NS_RETURNS_RETAINED;
- (NSMutableDictionary ZUX_GENERIC2(ZUX_KEY_TYPE, ZUX_OBJECT_TYPE) *)deepMutableCopy NS_RETURNS_RETAINED;
- (ZUX_OBJECT_TYPE)objectForKey:(ZUX_KEY_TYPE)key defaultValue:(ZUX_OBJECT_TYPE)defaultValue;
- (NSDictionary ZUX_GENERIC2(ZUX_KEY_TYPE, ZUX_OBJECT_TYPE) *)subDictionaryForKeys:(NSArray ZUX_GENERIC(ZUX_KEY_TYPE) *)keys;

@end // NSDictionary (ZUX)

#if __IPHONE_OS_VERSION_MAX_ALLOWED < 60000
@category_interface_generic(NSDictionary, ZUX_COVARIANT_GENERIC2(ZUX_KEY_TYPE, ZUX_OBJECT_TYPE), ZUXSubscript)

- (ZUX_OBJECT_TYPE)objectForKeyedSubscript:(ZUX_KEY_TYPE)key;

@end // NSDictionary (ZUXSubscript)

@category_interface_generic(NSMutableDictionary, ZUX_GENERIC2(ZUX_KEY_TYPE, ZUX_OBJECT_TYPE), ZUXSubscript)

- (void)setObject:(ZUX_OBJECT_TYPE)obj forKeyedSubscript:(ZUX_KEY_TYPE <NSCopying>)key;

@end // NSMutableDictionary (ZUXSubscript)
#endif // __IPHONE_OS_VERSION_MAX_ALLOWED < 60000

@category_interface_generic(NSDictionary, ZUX_COVARIANT_GENERIC2(ZUX_KEY_TYPE, ZUX_OBJECT_TYPE), ZUXCreation)

- (ZUX_INSTANCETYPE)initWithContentsOfUserFile:(NSString *)fileName;
- (ZUX_INSTANCETYPE)initWithContentsOfUserFile:(NSString *)fileName subpath:(NSString *)subpath;
- (ZUX_INSTANCETYPE)initWithContentsOfUserFile:(NSString *)fileName inDirectory:(ZUXDirectoryType)directory;
- (ZUX_INSTANCETYPE)initWithContentsOfUserFile:(NSString *)fileName inDirectory:(ZUXDirectoryType)directory subpath:(NSString *)subpath;
- (ZUX_INSTANCETYPE)initWithContentsOfUserFile:(NSString *)fileName bundle:(NSString *)bundleName;
- (ZUX_INSTANCETYPE)initWithContentsOfUserFile:(NSString *)fileName bundle:(NSString *)bundleName subpath:(NSString *)subpath;

+ (NSDictionary ZUX_GENERIC2(ZUX_KEY_TYPE, ZUX_OBJECT_TYPE) *)dictionaryWithContentsOfUserFile:(NSString *)fileName;
+ (NSDictionary ZUX_GENERIC2(ZUX_KEY_TYPE, ZUX_OBJECT_TYPE) *)dictionaryWithContentsOfUserFile:(NSString *)fileName subpath:(NSString *)subpath;
+ (NSDictionary ZUX_GENERIC2(ZUX_KEY_TYPE, ZUX_OBJECT_TYPE) *)dictionaryWithContentsOfUserFile:(NSString *)fileName inDirectory:(ZUXDirectoryType)directory;
+ (NSDictionary ZUX_GENERIC2(ZUX_KEY_TYPE, ZUX_OBJECT_TYPE) *)dictionaryWithContentsOfUserFile:(NSString *)fileName inDirectory:(ZUXDirectoryType)directory subpath:(NSString *)subpath;
+ (NSDictionary ZUX_GENERIC2(ZUX_KEY_TYPE, ZUX_OBJECT_TYPE) *)dictionaryWithContentsOfUserFile:(NSString *)fileName bundle:(NSString *)bundleName;
+ (NSDictionary ZUX_GENERIC2(ZUX_KEY_TYPE, ZUX_OBJECT_TYPE) *)dictionaryWithContentsOfUserFile:(NSString *)fileName bundle:(NSString *)bundleName subpath:(NSString *)subpath;

@end // NSDictionary (ZUXCreation)

@category_interface_generic(NSDictionary, ZUX_COVARIANT_GENERIC2(ZUX_KEY_TYPE, ZUX_OBJECT_TYPE), ZUXSerialization)

- (BOOL)writeToUserFile:(NSString *)fileName;
- (BOOL)writeToUserFile:(NSString *)fileName inDirectory:(ZUXDirectoryType)directory;
- (BOOL)writeToUserFile:(NSString *)fileName inDirectory:(ZUXDirectoryType)directory subpath:(NSString *)subpath;

@end // NSDictionary (ZUXSerialization)

#endif /* ZUtilsX_NSDictionary_ZUX_h */
