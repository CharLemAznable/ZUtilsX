//
//  ZUXColorDictionary.h
//  ZUtilsX
//
//  Created by Char Aznable on 15/12/10.
//  Copyright © 2015年 org.cuc.n3. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZUXDirectory.h"
#import "zobjc.h"

#ifndef ZUtilsX_ZUXColorDictionary_h
#define ZUtilsX_ZUXColorDictionary_h

@interface ZUXColorDictionary : NSObject

- (ZUX_INSTANCETYPE)initWithDictionary:(NSDictionary *)dictionary;
- (ZUX_INSTANCETYPE)initWithContentsOfUserFile:(NSString *)filePath;
- (ZUX_INSTANCETYPE)initWithContentsOfUserFile:(NSString *)filePath inDirectory:(ZUXDirectoryType)directory;
- (ZUX_INSTANCETYPE)initWithContentsOfUserFile:(NSString *)fileName bundle:(NSString *)bundleName;
- (ZUX_INSTANCETYPE)initWithContentsOfUserFile:(NSString *)fileName bundle:(NSString *)bundleName subpath:(NSString *)subpath;

- (void)reloadWithDictionary:(NSDictionary *)dictionary;
- (void)reloadWithContentsOfUserFile:(NSString *)filePath;
- (void)reloadWithContentsOfUserFile:(NSString *)filePath inDirectory:(ZUXDirectoryType)directory;
- (void)reloadWithContentsOfUserFile:(NSString *)fileName bundle:(NSString *)bundleName;
- (void)reloadWithContentsOfUserFile:(NSString *)fileName bundle:(NSString *)bundleName subpath:(NSString *)subpath;

- (UIColor *)colorForKey:(NSString *)key;
- (UIColor *)objectForKeyedSubscript:(NSString *)key;

@end

#endif /* ZUtilsX_ZUXColorDictionary_h */
