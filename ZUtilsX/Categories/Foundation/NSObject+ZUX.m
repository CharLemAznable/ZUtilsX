//
//  NSObject+ZUX.m
//  ZUtilsX
//
//  Created by Char Aznable on 15/11/13.
//  Copyright © 2015年 org.cuc.n3. All rights reserved.
//

#import "NSObject+ZUX.h"
#import "UIColor+ZUX.h"
#import "zobjc.h"
#import "zarc.h"
#import <objc/runtime.h>

ZUX_CATEGORY_M(ZUX_NSObject)

@implementation NSObject (ZUX)

+ (void)swizzleInstanceOriSelector:(SEL)oriSelector
                   withNewSelector:(SEL)newSelector {
    swizzleInstanceMethod([self class], oriSelector, newSelector);
}

+ (void)swizzleClassOriSelector:(SEL)oriSelector
                withNewSelector:(SEL)newSelector {
    swizzleInstanceMethod(object_getClass([self class]), oriSelector, newSelector);
}

ZUX_STATIC_INLINE void swizzleInstanceMethod(Class clazz, SEL oriSelector, SEL newSelector) {
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

+ (void)load {
    static dispatch_once_t once_t;
    dispatch_once(&once_t, ^{
        ZUX_ENABLE_CATEGORY(ZUX_UIColor);
    });
}

- (id)propertyForAssociateKey:(NSString *)key {
    return objc_getAssociatedObject(self, (ZUX_BRIDGE const void *)(key));
}

- (void)setProperty:(id)property forAssociateKey:(NSString *)key {
    id originalProperty = objc_getAssociatedObject(self, (ZUX_BRIDGE const void *)(key));
    if (ZUX_EXPECT_F([property isEqual:originalProperty])) return;
    
    [self willChangeValueForKey:key];
    objc_setAssociatedObject(self, (ZUX_BRIDGE const void *)(key),
                             property, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self didChangeValueForKey:key];
}

@end
