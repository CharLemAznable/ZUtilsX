//
//  ZUXMethod.m
//  ZUtilsX
//
//  Created by Char Aznable on 16/1/5.
//  Copyright © 2016年 org.cuc.n3. All rights reserved.
//

#import "ZUXMethod.h"
#import "zarc.h"

@interface ZUXObjCMethodInternal : ZUXMethod {
    Method _method;
}
@end // ZUXObjCMethodInternal

@interface ZUXComponentsMethodInternal : ZUXMethod {
    SEL _sel;
    IMP _imp;
    NSString *_sig;
}
@end // ZUXComponentsMethodInternal

#pragma mark - Implementation -

@implementation ZUXMethod

+ (ZUXMethod *)methodWithObjCMethod:(Method)method {
    return ZUX_AUTORELEASE([[self alloc] initWithObjCMethod:method]);
}

+ (ZUXMethod *)instanceMethodWithName:(NSString *)name inClass:(Class)cls {
    return ZUX_AUTORELEASE([[self alloc] initInstanceMethodWithName:name inClass:cls]);
}

+ (ZUXMethod *)classMethodWithName:(NSString *)name inClass:(Class)cls {
    return ZUX_AUTORELEASE([[self alloc] initClassMethodWithName:name inClass:cls]);
}

+ (ZUXMethod *)instanceMethodWithName:(NSString *)name inClassNamed:(NSString *)className {
    return ZUX_AUTORELEASE([[self alloc] initInstanceMethodWithName:name inClassNamed:className]);
}

+ (ZUXMethod *)classMethodWithName:(NSString *)name inClassNamed:(NSString *)className {
    return ZUX_AUTORELEASE([[self alloc] initClassMethodWithName:name inClassNamed:className]);
}

+ (ZUXMethod *)methodWithSelector:(SEL)sel implementation:(IMP)imp signature:(NSString *)signature {
    return ZUX_AUTORELEASE([[self alloc] initWithSelector:sel implementation:imp signature:signature]);
}

- (ZUX_INSTANCETYPE)initWithObjCMethod:(Method)method {
    ZUX_RELEASE(self);
    return [[ZUXObjCMethodInternal alloc] initWithObjCMethod:method];
}

- (ZUX_INSTANCETYPE)initInstanceMethodWithName:(NSString *)name inClass:(Class)cls {
    ZUX_RELEASE(self);
    return [[ZUXObjCMethodInternal alloc] initInstanceMethodWithName:name inClass:cls];
}

- (ZUX_INSTANCETYPE)initClassMethodWithName:(NSString *)name inClass:(Class)cls {
    ZUX_RELEASE(self);
    return [[ZUXObjCMethodInternal alloc] initClassMethodWithName:name inClass:cls];
}

- (ZUX_INSTANCETYPE)initInstanceMethodWithName:(NSString *)name inClassNamed:(NSString *)className {
    ZUX_RELEASE(self);
    return [[ZUXObjCMethodInternal alloc] initInstanceMethodWithName:name inClassNamed:className];
}

- (ZUX_INSTANCETYPE)initClassMethodWithName:(NSString *)name inClassNamed:(NSString *)className {
    ZUX_RELEASE(self);
    return [[ZUXObjCMethodInternal alloc] initClassMethodWithName:name inClassNamed:className];
}

- (ZUX_INSTANCETYPE)initWithSelector:(SEL)sel implementation:(IMP)imp signature:(NSString *)signature {
    ZUX_RELEASE(self);
    return [[ZUXComponentsMethodInternal alloc] initWithSelector:sel implementation:imp signature:signature];
}

- (NSString *)description {
    return [NSString stringWithFormat:@"<%@ %p: %@ %p %@>",
            [self class], self, NSStringFromSelector([self selector]), [self implementation], [self signature]];
}

- (BOOL)isEqual:(id)other {
    return [other isKindOfClass:[self class]]
    && [self selector] == [other selector]
    && [self implementation] == [other implementation]
    && [[self signature] isEqual:[other signature]];
}

- (NSUInteger)hash {
    return (NSUInteger)(void *)[self selector] ^ (NSUInteger)[self implementation] ^ [[self signature] hash];
}

- (SEL)selector {
    [self doesNotRecognizeSelector:_cmd];
    return NULL;
}

- (NSString *)selectorName {
    return NSStringFromSelector([self selector]);
}

- (IMP)implementation {
    [self doesNotRecognizeSelector:_cmd];
    return NULL;
}

- (void)setImplementation:(IMP)imp {
    [self doesNotRecognizeSelector:_cmd];
}

- (NSString *)signature {
    [self doesNotRecognizeSelector:_cmd];
    return nil;
}

@end

@implementation ZUXObjCMethodInternal

- (ZUX_INSTANCETYPE)initWithObjCMethod:(Method)method {
    if (ZUX_EXPECT_T(self = [self init])) _method = method;
    return self;
}

- (ZUX_INSTANCETYPE)initInstanceMethodWithName:(NSString *)name inClass:(Class)cls {
    return [self initWithObjCMethod:class_getInstanceMethod(cls, NSSelectorFromString(name))];
}

- (ZUX_INSTANCETYPE)initClassMethodWithName:(NSString *)name inClass:(Class)cls {
    return [self initWithObjCMethod:class_getClassMethod(cls, NSSelectorFromString(name))];
}

- (ZUX_INSTANCETYPE)initInstanceMethodWithName:(NSString *)name inClassNamed:(NSString *)className {
    return [self initWithObjCMethod:
            class_getInstanceMethod(objc_getClass(className.UTF8String), NSSelectorFromString(name))];
}

- (ZUX_INSTANCETYPE)initClassMethodWithName:(NSString *)name inClassNamed:(NSString *)className {
    return [self initWithObjCMethod:
            class_getClassMethod(objc_getClass(className.UTF8String), NSSelectorFromString(name))];
}

- (SEL)selector {
    return method_getName(_method);
}

- (IMP)implementation {
    return method_getImplementation(_method);
}

- (void)setImplementation:(IMP)imp {
    method_setImplementation(_method, imp);
}

- (NSString *)signature {
    return @(method_getTypeEncoding(_method));
}

@end

@implementation ZUXComponentsMethodInternal

- (ZUX_INSTANCETYPE)initWithSelector:(SEL)sel implementation:(IMP)imp signature:(NSString *)signature {
    if (ZUX_EXPECT_T(self = [self init])) {
        _sel = sel;
        _imp = imp;
        _sig = [signature copy];
    }
    return self;
}

- (void)dealloc {
    ZUX_RELEASE(_sig);
    ZUX_SUPER_DEALLOC;
}

- (SEL)selector {
    return _sel;
}

- (IMP)implementation {
    return _imp;
}

- (void)setImplementation:(IMP)imp {
    _imp = imp;
}

- (NSString *)signature {
    return _sig;
}

@end
