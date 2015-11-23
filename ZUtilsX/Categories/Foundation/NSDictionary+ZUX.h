//
//  NSDictionary+ZUX.h
//  ZUtilsX
//
//  Created by Char Aznable on 15/11/13.
//  Copyright © 2015年 org.cuc.n3. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZUXCategory.h"
#import "ZUXDirectory.h"
#import "zobjc.h"

ZUX_CATEGORY_H(ZUX_NSDictionary)

@interface NSDictionary ZUX_COVARIANT_GENERIC2(ZUX_KEY_TYPE, ZUX_OBJECT_TYPE) (ZUX)

- (NSDictionary ZUX_GENERIC2(ZUX_KEY_TYPE, ZUX_OBJECT_TYPE) *)deepCopy NS_RETURNS_RETAINED;
- (NSMutableDictionary ZUX_GENERIC2(ZUX_KEY_TYPE, ZUX_OBJECT_TYPE) *)deepMutableCopy NS_RETURNS_RETAINED;
- (ZUX_OBJECT_TYPE)objectForKey:(ZUX_KEY_TYPE)key defaultValue:(ZUX_OBJECT_TYPE)defaultValue;
- (NSDictionary ZUX_GENERIC2(ZUX_KEY_TYPE, ZUX_OBJECT_TYPE) *)subDictionaryForKeys:(NSArray ZUX_GENERIC(ZUX_KEY_TYPE) *)keys;

@end

@interface NSDictionary ZUX_COVARIANT_GENERIC2(ZUX_KEY_TYPE, ZUX_OBJECT_TYPE) (ZUXDirectory)

- (BOOL)writeToUserFile:(NSString *)filePath;
+ (NSDictionary ZUX_GENERIC2(ZUX_KEY_TYPE, ZUX_OBJECT_TYPE) *)dictionaryWithContentsOfUserFile:(NSString *)filePath;

- (BOOL)writeToUserFile:(NSString *)filePath inDirectory:(ZUXDirectoryType)directory;
+ (NSDictionary ZUX_GENERIC2(ZUX_KEY_TYPE, ZUX_OBJECT_TYPE) *)dictionaryWithContentsOfUserFile:(NSString *)filePath inDirectory:(ZUXDirectoryType)directory;

@end
