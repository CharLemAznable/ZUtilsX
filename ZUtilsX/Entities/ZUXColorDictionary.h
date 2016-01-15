//
//  ZUXColorDictionary.h
//  ZUtilsX
//
//  Created by Char Aznable on 15/12/10.
//  Copyright © 2015年 org.cuc.n3. All rights reserved.
//

#ifndef ZUtilsX_ZUXColorDictionary_h
#define ZUtilsX_ZUXColorDictionary_h

#import <UIKit/UIKit.h>
#import "ZUXDirectory.h"
#import "zobjc.h"

@interface ZUXColorDictionary : NSObject

- (ZUX_INSTANCETYPE)initWithDictionary:(NSDictionary *)dictionary;
- (ZUX_INSTANCETYPE)initWithContentsOfUserFile:(NSString *)fileName;
- (ZUX_INSTANCETYPE)initWithContentsOfUserFile:(NSString *)fileName subpath:(NSString *)subpath;
- (ZUX_INSTANCETYPE)initWithContentsOfUserFile:(NSString *)fileName inDirectory:(ZUXDirectoryType)directory;
- (ZUX_INSTANCETYPE)initWithContentsOfUserFile:(NSString *)fileName inDirectory:(ZUXDirectoryType)directory subpath:(NSString *)subpath;
- (ZUX_INSTANCETYPE)initWithContentsOfUserFile:(NSString *)fileName bundle:(NSString *)bundleName;
- (ZUX_INSTANCETYPE)initWithContentsOfUserFile:(NSString *)fileName bundle:(NSString *)bundleName subpath:(NSString *)subpath;

+ (ZUXColorDictionary *)colorDictionaryWithDictionary:(NSDictionary *)dictionary;
+ (ZUXColorDictionary *)colorDictionaryWithContentsOfUserFile:(NSString *)fileName;
+ (ZUXColorDictionary *)colorDictionaryWithContentsOfUserFile:(NSString *)fileName subpath:(NSString *)subpath;
+ (ZUXColorDictionary *)colorDictionaryWithContentsOfUserFile:(NSString *)fileName inDirectory:(ZUXDirectoryType)directory;
+ (ZUXColorDictionary *)colorDictionaryWithContentsOfUserFile:(NSString *)fileName inDirectory:(ZUXDirectoryType)directory subpath:(NSString *)subpath;
+ (ZUXColorDictionary *)colorDictionaryWithContentsOfUserFile:(NSString *)fileName bundle:(NSString *)bundleName;
+ (ZUXColorDictionary *)colorDictionaryWithContentsOfUserFile:(NSString *)fileName bundle:(NSString *)bundleName subpath:(NSString *)subpath;

- (void)reloadWithDictionary:(NSDictionary *)dictionary;
- (void)reloadWithContentsOfUserFile:(NSString *)fileName;
- (void)reloadWithContentsOfUserFile:(NSString *)fileName subpath:(NSString *)subpath;
- (void)reloadWithContentsOfUserFile:(NSString *)fileName inDirectory:(ZUXDirectoryType)directory;
- (void)reloadWithContentsOfUserFile:(NSString *)fileName inDirectory:(ZUXDirectoryType)directory subpath:(NSString *)subpath;
- (void)reloadWithContentsOfUserFile:(NSString *)fileName bundle:(NSString *)bundleName;
- (void)reloadWithContentsOfUserFile:(NSString *)fileName bundle:(NSString *)bundleName subpath:(NSString *)subpath;

- (UIColor *)colorForKey:(NSString *)key;
- (UIColor *)objectForKeyedSubscript:(NSString *)key;

@end

#endif /* ZUtilsX_ZUXColorDictionary_h */
