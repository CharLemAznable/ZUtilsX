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

#define singletonface(CLASS_NAME, SUPER_CLASS_NAME) \
interface CLASS_NAME : SUPER_CLASS_NAME \
+ (ZUX_INSTANCETYPE)share##CLASS_NAME;

#define singletonation(CLASS_NAME) \
implementation CLASS_NAME \
static id _share##CLASS_NAME; \
+ (ZUX_INSTANCETYPE)share##CLASS_NAME { \
    static dispatch_once_t once_t; \
    dispatch_once(&once_t, ^{ \
        if (ZUX_EXPECT_F(_share##CLASS_NAME)) return; \
        _share##CLASS_NAME = [[self alloc] init]; \
    }); \
    return _share##CLASS_NAME; \
} \
+ (ZUX_INSTANCETYPE)allocWithZone:(struct _NSZone *)zone { \
    static dispatch_once_t once_t; \
    __block id alloc = nil; \
    dispatch_once(&once_t, ^{ \
        if (ZUX_EXPECT_T(!_share##CLASS_NAME)) \
            _share##CLASS_NAME = [super allocWithZone:zone]; \
        alloc = _share##CLASS_NAME; \
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
