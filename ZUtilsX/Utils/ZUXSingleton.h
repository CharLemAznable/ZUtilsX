//
//  ZUXSingleton.h
//  ZUtilsX
//
//  Created by Char Aznable on 15/11/19.
//  Copyright © 2015年 org.cuc.n3. All rights reserved.
//

#ifndef ZUtilsX_ZUXSingleton_h
#define ZUtilsX_ZUXSingleton_h

#import "zobjc.h"
#import "zarc.h"

#define ZUX_SINGLETON_H \
+ (ZUX_INSTANCETYPE)sharedInstance;

#define ZUX_SINGLETOM_M \
static id _sharedInstance; \
+ (ZUX_INSTANCETYPE)sharedInstance { \
    static dispatch_once_t once_t; \
    dispatch_once(&once_t, ^{ \
        if (!_sharedInstance) _sharedInstance = [[self alloc] init]; \
    }); \
    return _sharedInstance; \
} \
+ (ZUX_INSTANCETYPE)allocWithZone:(struct _NSZone *)zone { \
    static dispatch_once_t once_t; \
    __block id alloc = nil; \
    dispatch_once(&once_t, ^{ \
        if (!_sharedInstance) _sharedInstance = [super allocWithZone:zone];\
        alloc = _sharedInstance; \
    }); \
    return alloc; \
} \
- (id)copyWithZone:(struct _NSZone *)zone { \
    return ZUX_RETAIN(self); \
} \
- (id)mutableCopyWithZone:(struct _NSZone *)zone { \
    return [self copyWithZone:zone]; \
}

#endif /* ZUtilsX_ZUXSingleton_h */
