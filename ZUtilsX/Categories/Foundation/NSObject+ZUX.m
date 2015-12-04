//
//  NSObject+ZUX.m
//  ZUtilsX
//
//  Created by Char Aznable on 15/11/13.
//  Copyright © 2015年 org.cuc.n3. All rights reserved.
//

#import "NSObject+ZUX.h"
#import "zobjc.h"
#import <objc/runtime.h>

ZUX_CATEGORY_M(ZUX_NSObject)

@implementation NSObject (ZUX)

+ (void)swizzleInstanceOriSelector:(SEL)oriSelector
                   withNewSelector:(SEL)newSelector {
    swizzleClassMethod([self class], oriSelector, newSelector);
}

+ (void)swizzleClassOriSelector:(SEL)oriSelector
                withNewSelector:(SEL)newSelector {
    swizzleClassMethod(object_getClass([self class]), oriSelector, newSelector);
}

ZUX_STATIC_INLINE void swizzleClassMethod(Class clazz, SEL oriSelector, SEL newSelector) {
    Method oriMethod = class_getInstanceMethod(clazz, oriSelector);
    Method newMethod = class_getInstanceMethod(clazz, newSelector);
    if(class_addMethod(clazz, oriSelector,
                       method_getImplementation(newMethod),
                       method_getTypeEncoding(newMethod))) {
        class_replaceMethod(clazz, newSelector,
                            method_getImplementation(oriMethod),
                            method_getTypeEncoding(oriMethod));
    } else method_exchangeImplementations(oriMethod, newMethod);
}


- (void)addObserver:(NSObject *)observer
        forKeyPaths:(NSArray *)keyPaths
            options:(NSKeyValueObservingOptions)options
            context:(void *)context {
    if (ZUX_EXPECT_F(!keyPaths)) return;
    for (id keyPath in keyPaths) {
        NSString *k = [keyPath isKindOfClass:[NSString class]] ? keyPath : [keyPath description];
        [self addObserver:observer forKeyPath:k options:options context:context];
    }
}

- (void)removeObserver:(NSObject *)observer
           forKeyPaths:(NSArray *)keyPaths
               context:(void *)context {
    if (ZUX_EXPECT_F(!keyPaths)) return;
    for (id keyPath in keyPaths) {
        NSString *k = [keyPath isKindOfClass:[NSString class]] ? keyPath : [keyPath description];
        [self removeObserver:observer forKeyPath:k context:context];
    }
}

- (void)removeObserver:(NSObject *)observer
           forKeyPaths:(NSArray *)keyPaths {
    [self removeObserver:observer forKeyPaths:keyPaths context:NULL];
}

@end
