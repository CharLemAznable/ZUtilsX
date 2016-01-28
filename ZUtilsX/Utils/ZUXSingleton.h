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

// singleton_interface
#define singleton_interface(className, superClassName)          \
interface className : superClassName                            \
+ (ZUX_INSTANCETYPE)share##className;                           \
@end                                                            \
@interface className ()

// singleton_implementation
#define singleton_implementation(className)                     \
implementation className                                        \
static id _share##className;                                    \
+ (ZUX_INSTANCETYPE)share##className {                          \
    static dispatch_once_t once_t;                              \
    dispatch_once(&once_t, ^{                                   \
        if (ZUX_EXPECT_F(_share##className)) return;            \
        _share##className = [[self alloc] init];                \
    });                                                         \
    return _share##className;                                   \
}                                                               \
+ (ZUX_INSTANCETYPE)allocWithZone:(struct _NSZone *)zone {      \
    static dispatch_once_t once_t;                              \
    __block id alloc = nil;                                     \
    dispatch_once(&once_t, ^{                                   \
        if (ZUX_EXPECT_T(!_share##className))                   \
            _share##className = [super allocWithZone:zone];     \
        alloc = _share##className;                              \
    });                                                         \
    return alloc;                                               \
}                                                               \
- (id)copyWithZone:(struct _NSZone *)zone {                     \
    return ZUX_RETAIN(self);                                    \
}                                                               \
- (id)mutableCopyWithZone:(struct _NSZone *)zone {              \
    return [self copyWithZone:zone];                            \
}

#endif /* ZUtilsX_ZUXSingleton_h */
