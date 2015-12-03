//
//  NSArray+ZUX.h
//  ZUtilsX
//
//  Created by Char Aznable on 15/11/13.
//  Copyright © 2015年 org.cuc.n3. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZUXCategory.h"
#import "ZUXDirectory.h"
#import "zobjc.h"

#ifndef ZUtilsX_NSArray_ZUX_h
#define ZUtilsX_NSArray_ZUX_h

ZUX_CATEGORY_H(ZUX_NSArray)

@interface NSArray ZUX_COVARIANT_GENERIC(ZUX_OBJECT_TYPE) (ZUX)

- (NSArray ZUX_GENERIC(ZUX_OBJECT_TYPE) *)deepCopy NS_RETURNS_RETAINED;
- (NSMutableArray ZUX_GENERIC(ZUX_OBJECT_TYPE) *)deepMutableCopy NS_RETURNS_RETAINED;
- (ZUX_OBJECT_TYPE)objectAtIndex:(NSUInteger)index defaultValue:(ZUX_OBJECT_TYPE)defaultValue;

@end // NSArray (ZUX)

@interface NSArray ZUX_COVARIANT_GENERIC(ZUX_OBJECT_TYPE) (ZUXDirectory)

- (BOOL)writeToUserFile:(NSString *)filePath;
+ (NSArray ZUX_GENERIC(ZUX_OBJECT_TYPE) *)arrayWithContentsOfUserFile:(NSString *)filePath;

- (BOOL)writeToUserFile:(NSString *)filePath inDirectory:(ZUXDirectoryType)directory;
+ (NSArray ZUX_GENERIC(ZUX_OBJECT_TYPE) *)arrayWithContentsOfUserFile:(NSString *)filePath inDirectory:(ZUXDirectoryType)directory;

@end // NSArray (ZUXDirectory)

#endif /* ZUtilsX_NSArray_ZUX_h */
