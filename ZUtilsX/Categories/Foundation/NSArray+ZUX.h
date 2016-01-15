//
//  NSArray+ZUX.h
//  ZUtilsX
//
//  Created by Char Aznable on 15/11/13.
//  Copyright © 2015年 org.cuc.n3. All rights reserved.
//

#ifndef ZUtilsX_NSArray_ZUX_h
#define ZUtilsX_NSArray_ZUX_h

#import <Foundation/Foundation.h>
#import "ZUXCategory.h"
#import "ZUXDirectory.h"
#import "zobjc.h"

@category_interface_generic(NSArray, ZUX_COVARIANT_GENERIC(ZUX_OBJECT_TYPE), ZUX)

- (NSArray ZUX_GENERIC(ZUX_OBJECT_TYPE) *)deepCopy NS_RETURNS_RETAINED;
- (NSMutableArray ZUX_GENERIC(ZUX_OBJECT_TYPE) *)deepMutableCopy NS_RETURNS_RETAINED;
- (ZUX_OBJECT_TYPE)objectAtIndex:(NSUInteger)index defaultValue:(ZUX_OBJECT_TYPE)defaultValue;

@end // NSArray (ZUX)

#if __IPHONE_OS_VERSION_MAX_ALLOWED < 60000
@category_interface_generic(NSArray, ZUX_COVARIANT_GENERIC(ZUX_OBJECT_TYPE), ZUXSubscript)

- (ZUX_OBJECT_TYPE)objectAtIndexedSubscript:(NSUInteger)idx;

@end // NSArray (ZUXSubscript)

@category_interface_generic(NSMutableArray, ZUX_GENERIC(ZUX_OBJECT_TYPE), ZUXSubscript)

- (void)setObject:(ZUX_OBJECT_TYPE)obj atIndexedSubscript:(NSUInteger)idx;

@end // NSMutableArray (ZUXSubscript)
#endif // __IPHONE_OS_VERSION_MAX_ALLOWED < 60000

@category_interface_generic(NSArray, ZUX_COVARIANT_GENERIC(ZUX_OBJECT_TYPE), ZUXCreation)

- (ZUX_INSTANCETYPE)initWithContentsOfUserFile:(NSString *)fileName;
- (ZUX_INSTANCETYPE)initWithContentsOfUserFile:(NSString *)fileName subpath:(NSString *)subpath;
- (ZUX_INSTANCETYPE)initWithContentsOfUserFile:(NSString *)fileName inDirectory:(ZUXDirectoryType)directory;
- (ZUX_INSTANCETYPE)initWithContentsOfUserFile:(NSString *)fileName inDirectory:(ZUXDirectoryType)directory subpath:(NSString *)subpath;
- (ZUX_INSTANCETYPE)initWithContentsOfUserFile:(NSString *)fileName bundle:(NSString *)bundleName;
- (ZUX_INSTANCETYPE)initWithContentsOfUserFile:(NSString *)fileName bundle:(NSString *)bundleName subpath:(NSString *)subpath;

+ (NSArray ZUX_GENERIC(ZUX_OBJECT_TYPE) *)arrayWithContentsOfUserFile:(NSString *)fileName;
+ (NSArray ZUX_GENERIC(ZUX_OBJECT_TYPE) *)arrayWithContentsOfUserFile:(NSString *)fileName subpath:(NSString *)subpath;
+ (NSArray ZUX_GENERIC(ZUX_OBJECT_TYPE) *)arrayWithContentsOfUserFile:(NSString *)fileName inDirectory:(ZUXDirectoryType)directory;
+ (NSArray ZUX_GENERIC(ZUX_OBJECT_TYPE) *)arrayWithContentsOfUserFile:(NSString *)fileName inDirectory:(ZUXDirectoryType)directory subpath:(NSString *)subpath;
+ (NSArray ZUX_GENERIC(ZUX_OBJECT_TYPE) *)arrayWithContentsOfUserFile:(NSString *)fileName bundle:(NSString *)bundleName;
+ (NSArray ZUX_GENERIC(ZUX_OBJECT_TYPE) *)arrayWithContentsOfUserFile:(NSString *)fileName bundle:(NSString *)bundleName subpath:(NSString *)subpath;

@end // NSArray (ZUXCreation)

@category_interface_generic(NSArray, ZUX_COVARIANT_GENERIC(ZUX_OBJECT_TYPE), ZUXSerialization)

- (BOOL)writeToUserFile:(NSString *)fileName;
- (BOOL)writeToUserFile:(NSString *)fileName inDirectory:(ZUXDirectoryType)directory;
- (BOOL)writeToUserFile:(NSString *)fileName inDirectory:(ZUXDirectoryType)directory subpath:(NSString *)subpath;

@end // NSArray (ZUXSerialization)

#endif /* ZUtilsX_NSArray_ZUX_h */
