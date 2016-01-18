//
//  NSObject+ZUX.m
//  ZUtilsX
//
//  Created by Char Aznable on 15/11/13.
//  Copyright © 2015年 org.cuc.n3. All rights reserved.
//

#import "NSObject+ZUX.h"
#import "UIColor+ZUX.h"
#import "ZUXProtocol.h"
#import "ZUXIvar.h"
#import "ZUXProperty.h"
#import "ZUXMethod.h"
#import "zobjc.h"
#import "zarc.h"
#import <objc/runtime.h>

@category_implementation(NSObject, ZUX)

#pragma mark - swizzle -

+ (void)swizzleInstanceOriSelector:(SEL)oriSelector withNewSelector:(SEL)newSelector {
    [self swizzleInstanceOriSelector:oriSelector withNewSelector:newSelector fromClass:self];
}

+ (void)swizzleInstanceOriSelector:(SEL)oriSelector withNewSelector:(SEL)newSelector fromClass:(Class)clazz {
    swizzleInstanceMethod(self, oriSelector, newSelector, clazz);
}

+ (void)swizzleClassOriSelector:(SEL)oriSelector withNewSelector:(SEL)newSelector {
    [self swizzleClassOriSelector:oriSelector withNewSelector:newSelector fromClass:object_getClass(self)];
}

+ (void)swizzleClassOriSelector:(SEL)oriSelector withNewSelector:(SEL)newSelector fromClass:(Class)clazz {
    swizzleInstanceMethod(object_getClass(self), oriSelector, newSelector, clazz);
}

ZUX_STATIC void swizzleInstanceMethod(Class swiClass, SEL oriSelector, SEL newSelector, Class impClass) {
    Method oriMethod = class_getInstanceMethod(impClass, oriSelector);
    Method newMethod = class_getInstanceMethod(impClass, newSelector);
    class_addMethod(swiClass, oriSelector, method_getImplementation(oriMethod),
                    method_getTypeEncoding(oriMethod));
    class_addMethod(swiClass, newSelector, method_getImplementation(newMethod),
                    method_getTypeEncoding(newMethod));
    method_exchangeImplementations(class_getInstanceMethod(swiClass, oriSelector),
                                   class_getInstanceMethod(swiClass, newSelector));
}

#pragma mark - observe -

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

#pragma mark - associate -

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

@category_implementation(NSObject, ZUXRuntime)

+ (NSArray *)zuxProtocols {
    unsigned int count;
    Protocol * __unsafe_unretained *protocols = class_copyProtocolList(self, &count);
    
    NSMutableArray *array = [NSMutableArray array];
    for(unsigned i = 0; i < count; i++)
        [array addObject:[ZUXProtocol protocolWithObjCProtocol:protocols[i]]];
    
    free(protocols);
    return ZUX_AUTORELEASE([array copy]);
}

+ (void)enumerateZUXProtocolsWithBlock:(void (^)(ZUXProtocol *))block {
    if (ZUX_EXPECT_F(!block)) return;
    [[self zuxProtocols] enumerateObjectsUsingBlock:
     ^(id _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) { block(obj); }];
}

- (void)enumerateZUXProtocolsWithBlock:(void (^)(id, ZUXProtocol *))block {
    if (ZUX_EXPECT_F(!block)) return;
    [[[self class] zuxProtocols] enumerateObjectsUsingBlock:
     ^(id _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) { block(self, obj); }];
}

+ (NSArray *)zuxIvars {
    unsigned int count;
    Ivar *ivars = class_copyIvarList(self, &count);
    
    NSMutableArray *array = [NSMutableArray array];
    for(unsigned i = 0; i < count; i++)
        [array addObject:[ZUXIvar ivarWithObjCIvar:ivars[i]]];
    
    free(ivars);
    return ZUX_AUTORELEASE([array copy]);
}

+ (ZUXIvar *)zuxIvarForName:(NSString *)name {
    return [ZUXIvar instanceIvarWithName:name inClass:self];
}

+ (void)enumerateZUXIvarsWithBlock:(void (^)(ZUXIvar *))block {
    if (ZUX_EXPECT_F(!block)) return;
    [[self zuxIvars] enumerateObjectsUsingBlock:
     ^(id _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) { block(obj); }];
}

- (void)enumerateZUXIvarsWithBlock:(void (^)(id, ZUXIvar *))block {
    if (ZUX_EXPECT_F(!block)) return;
    [[[self class] zuxIvars] enumerateObjectsUsingBlock:
     ^(id _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) { block(self, obj); }];
}

+ (NSArray *)zuxProperties {
    unsigned int count;
    objc_property_t *properties = class_copyPropertyList(self, &count);
    
    NSMutableArray *array = [NSMutableArray array];
    for(unsigned i = 0; i < count; i++)
        [array addObject:[ZUXProperty propertyWithObjCProperty:properties[i]]];
    
    free(properties);
    return ZUX_AUTORELEASE([array copy]);
}

+ (ZUXProperty *)zuxPropertyForName:(NSString *)name {
    return [ZUXProperty propertyWithName:name inClass:self];
}

+ (void)enumerateZUXPropertiesWithBlock:(void (^)(ZUXProperty *))block {
    if (ZUX_EXPECT_F(!block)) return;
    [[self zuxProperties] enumerateObjectsUsingBlock:
     ^(id _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) { block(obj); }];
}

- (void)enumerateZUXPropertiesWithBlock:(void (^)(id, ZUXProperty *))block {
    if (ZUX_EXPECT_F(!block)) return;
    [[[self class] zuxProperties] enumerateObjectsUsingBlock:
     ^(id _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) { block(self, obj); }];
}

+ (NSArray *)zuxMethods {
    unsigned int count;
    Method *methods = class_copyMethodList(self, &count);
    
    NSMutableArray *array = [NSMutableArray array];
    for(unsigned i = 0; i < count; i++)
        [array addObject:[ZUXMethod methodWithObjCMethod:methods[i]]];
    
    free(methods);
    return ZUX_AUTORELEASE([array copy]);
}

+ (ZUXMethod *)zuxInstanceMethodForName:(NSString *)name {
    return [ZUXMethod instanceMethodWithName:name inClass:self];
}

+ (ZUXMethod *)zuxClassMethodForName:(NSString *)name {
    return [ZUXMethod classMethodWithName:name inClass:self];
}

+ (void)enumerateZUXMethodsWithBlock:(void (^)(ZUXMethod *))block {
    if (ZUX_EXPECT_F(!block)) return;
    [[self zuxMethods] enumerateObjectsUsingBlock:
     ^(id _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) { block(obj); }];
}

- (void)enumerateZUXMethodsWithBlock:(void (^)(id, ZUXMethod *))block {
    if (ZUX_EXPECT_F(!block)) return;
    [[[self class] zuxMethods] enumerateObjectsUsingBlock:
     ^(id _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) { block(self, obj); }];
}

@end
