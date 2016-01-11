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

#define ZUX_SINGLETON_H(SHARE_INSTANCE) \
+ (ZUX_INSTANCETYPE)SHARE_INSTANCE;

#define ZUX_SINGLETOM_M(SHARE_INSTANCE) \
static id _##SHARE_INSTANCE; \
+ (ZUX_INSTANCETYPE)SHARE_INSTANCE { \
    static dispatch_once_t once_t; \
    dispatch_once(&once_t, ^{ \
        if (ZUX_EXPECT_F(_##SHARE_INSTANCE)) return; \
        _##SHARE_INSTANCE = [[self alloc] init]; \
    }); \
    return _##SHARE_INSTANCE; \
} \
+ (ZUX_INSTANCETYPE)allocWithZone:(struct _NSZone *)zone { \
    static dispatch_once_t once_t; \
    __block id alloc = nil; \
    dispatch_once(&once_t, ^{ \
        if (ZUX_EXPECT_T(!_##SHARE_INSTANCE)) _##SHARE_INSTANCE = [super allocWithZone:zone]; \
        alloc = _##SHARE_INSTANCE; \
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
