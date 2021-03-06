//
//  NSObject+ZUX.h
//  ZUtilsX
//
//  Created by Char Aznable on 15/11/13.
//  Copyright © 2015年 org.cuc.n3. All rights reserved.
//

#ifndef ZUtilsX_NSObject_ZUX_h
#define ZUtilsX_NSObject_ZUX_h

#import <Foundation/Foundation.h>
#import "ZUXCategory.h"

@category_interface(NSObject, ZUX)

+ (void)swizzleInstanceOriSelector:(SEL)oriSelector withNewSelector:(SEL)newSelector;
+ (void)swizzleInstanceOriSelector:(SEL)oriSelector withNewSelector:(SEL)newSelector fromClass:(Class)clazz;
+ (void)swizzleClassOriSelector:(SEL)oriSelector withNewSelector:(SEL)newSelector;
+ (void)swizzleClassOriSelector:(SEL)oriSelector withNewSelector:(SEL)newSelector fromClass:(Class)clazz;

- (void)addObserver:(NSObject *)observer forKeyPaths:(NSArray *)keyPaths options:(NSKeyValueObservingOptions)options context:(void *)context;
- (void)removeObserver:(NSObject *)observer forKeyPaths:(NSArray *)keyPaths context:(void *)context;
- (void)removeObserver:(NSObject *)observer forKeyPaths:(NSArray *)keyPaths;

- (id)propertyForAssociateKey:(NSString *)key;
- (void)setProperty:(id)property forAssociateKey:(NSString *)key;

@end // NSObject (ZUX)

@class ZUXProtocol;
@class ZUXIvar;
@class ZUXProperty;
@class ZUXMethod;

@category_interface(NSObject, ZUXRuntime)

+ (NSArray *)zuxProtocols;
+ (void)enumerateZUXProtocolsWithBlock:(void (^)(ZUXProtocol *protocol))block;
- (void)enumerateZUXProtocolsWithBlock:(void (^)(id object, ZUXProtocol *protocol))block;

+ (NSArray *)zuxIvars;
+ (ZUXIvar *)zuxIvarForName:(NSString *)name;
+ (void)enumerateZUXIvarsWithBlock:(void (^)(ZUXIvar *ivar))block;
- (void)enumerateZUXIvarsWithBlock:(void (^)(id object, ZUXIvar *ivar))block;

+ (NSArray *)zuxProperties;
+ (ZUXProperty *)zuxPropertyForName:(NSString *)name;
+ (void)enumerateZUXPropertiesWithBlock:(void (^)(ZUXProperty *property))block;
- (void)enumerateZUXPropertiesWithBlock:(void (^)(id object, ZUXProperty *property))block;

+ (NSArray *)zuxMethods;
+ (ZUXMethod *)zuxInstanceMethodForName:(NSString *)name;
+ (ZUXMethod *)zuxClassMethodForName:(NSString *)name;
+ (void)enumerateZUXMethodsWithBlock:(void (^)(ZUXMethod *method))block;
- (void)enumerateZUXMethodsWithBlock:(void (^)(id object, ZUXMethod *method))block;

@end // NSObject (ZUXRuntime)

#endif /* ZUtilsX_NSObject_ZUX_h */
