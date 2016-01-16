//
//  ZUXIvar.m
//  ZUtilsX
//
//  Created by Char Aznable on 16/1/5.
//  Copyright © 2016年 org.cuc.n3. All rights reserved.
//

#import "ZUXIvar.h"
#import "zarc.h"

@interface ZUXObjCIvarInternal : ZUXIvar {
    Ivar _ivar;
}
@end // ZUXObjCIvarInternal

@interface ZUXComponentsIvarInternal : ZUXIvar {
    NSString *_name;
    NSString *_typeEncoding;
}
@end // ZUXComponentsIvarInternal

#pragma mark - Implementation -

@implementation ZUXIvar

+ (ZUXIvar *)ivarWithObjCIvar:(Ivar)ivar {
    return ZUX_AUTORELEASE([[self alloc] initWithObjCIvar:ivar]);
}

+ (ZUXIvar *)instanceIvarWithName:(NSString *)name inClass:(Class)cls {
    return ZUX_AUTORELEASE([[self alloc] initInstanceIvarWithName:name inClass:cls]);
}

+ (ZUXIvar *)classIvarWithName:(NSString *)name inClass:(Class)cls {
    return ZUX_AUTORELEASE([[self alloc] initClassIvarWithName:name inClass:cls]);
}

+ (ZUXIvar *)instanceIvarWithName:(NSString *)name inClassNamed:(NSString *)className {
    return ZUX_AUTORELEASE([[self alloc] initInstanceIvarWithName:name inClassNamed:className]);
}

+ (ZUXIvar *)classIvarWithName:(NSString *)name inClassNamed:(NSString *)className {
    return ZUX_AUTORELEASE([[self alloc] initClassIvarWithName:name inClassNamed:className]);
}

+ (ZUXIvar *)ivarWithName:(NSString *)name typeEncoding:(NSString *)typeEncoding {
    return ZUX_AUTORELEASE([[self alloc] initWithName:name typeEncoding:typeEncoding]);
}

+ (ZUXIvar *)ivarWithName:(NSString *)name encode:(const char *)encodeStr {
    return [self ivarWithName:name typeEncoding:@(encodeStr)];
}

- (ZUX_INSTANCETYPE)initWithObjCIvar:(Ivar)ivar {
    ZUX_RELEASE(self);
    return [[ZUXObjCIvarInternal alloc] initWithObjCIvar:ivar];
}

- (ZUX_INSTANCETYPE)initInstanceIvarWithName:(NSString *)name inClass:(Class)cls {
    ZUX_RELEASE(self);
    return [[ZUXObjCIvarInternal alloc] initInstanceIvarWithName:name inClass:cls];
}

- (ZUX_INSTANCETYPE)initClassIvarWithName:(NSString *)name inClass:(Class)cls {
    ZUX_RELEASE(self);
    return [[ZUXObjCIvarInternal alloc] initClassIvarWithName:name inClass:cls];
}

- (ZUX_INSTANCETYPE)initInstanceIvarWithName:(NSString *)name inClassNamed:(NSString *)className {
    ZUX_RELEASE(self);
    return [[ZUXObjCIvarInternal alloc] initInstanceIvarWithName:name inClassNamed:className];
}

- (ZUX_INSTANCETYPE)initClassIvarWithName:(NSString *)name inClassNamed:(NSString *)className {
    ZUX_RELEASE(self);
    return [[ZUXObjCIvarInternal alloc] initClassIvarWithName:name inClassNamed:className];
}

- (ZUX_INSTANCETYPE)initWithName:(NSString *)name typeEncoding:(NSString *)typeEncoding {
    ZUX_RELEASE(self);
    return [[ZUXComponentsIvarInternal alloc] initWithName:name typeEncoding:typeEncoding];
}

- (NSString *)description {
    return [NSString stringWithFormat:@"<%@ %p: %@ %@ %ld>",
            [self class], self, [self name], [self typeEncoding], (long)[self offset]];
}

- (BOOL)isEqual:(id)other {
    return [other isKindOfClass:[self class]]
    && [[self name] isEqual:[other name]]
    && [[self typeEncoding] isEqual:[other typeEncoding]];
}

- (NSUInteger)hash {
    return [[self name] hash] ^ [[self typeEncoding] hash];
}

- (NSString *)name {
    [self doesNotRecognizeSelector:_cmd];
    return nil;
}

- (NSString *)typeName {
    [self doesNotRecognizeSelector:_cmd];
    return nil;
}

- (NSString *)typeEncoding {
    [self doesNotRecognizeSelector:_cmd];
    return nil;
}

- (ptrdiff_t)offset {
    [self doesNotRecognizeSelector:_cmd];
    return 0;
}

@end

@implementation ZUXObjCIvarInternal

- (ZUX_INSTANCETYPE)initWithObjCIvar:(Ivar)ivar {
    if (ZUX_EXPECT_T(self = [self init])) _ivar = ivar;
    return self;
}

- (ZUX_INSTANCETYPE)initInstanceIvarWithName:(NSString *)name inClass:(Class)cls {
    return [self initWithObjCIvar:class_getInstanceVariable(cls, name.UTF8String)];
}

- (ZUX_INSTANCETYPE)initClassIvarWithName:(NSString *)name inClass:(Class)cls {
    return [self initWithObjCIvar:class_getClassVariable(cls, name.UTF8String)];
}

- (ZUX_INSTANCETYPE)initInstanceIvarWithName:(NSString *)name inClassNamed:(NSString *)className {
    return [self initWithObjCIvar:class_getInstanceVariable(objc_getClass(className.UTF8String), name.UTF8String)];
}

- (ZUX_INSTANCETYPE)initClassIvarWithName:(NSString *)name inClassNamed:(NSString *)className {
    return [self initWithObjCIvar:class_getClassVariable(objc_getClass(className.UTF8String), name.UTF8String)];
}

- (NSString *)name {
    return @(ivar_getName(_ivar));
}

- (NSString *)typeName {
    return [[self typeEncoding] stringByTrimmingCharactersInSet:
            [NSCharacterSet characterSetWithCharactersInString:@"@\""]];
}

- (NSString *)typeEncoding {
    return @(ivar_getTypeEncoding(_ivar));
}

- (ptrdiff_t)offset {
    return ivar_getOffset(_ivar);
}

@end

@implementation ZUXComponentsIvarInternal

- (ZUX_INSTANCETYPE)initWithName:(NSString *)name typeEncoding:(NSString *)typeEncoding {
    if (ZUX_EXPECT_T(self = [self init])) {
        _name = [name copy];
        _typeEncoding = [typeEncoding copy];
    }
    return self;
}

- (void)dealloc {
    ZUX_RELEASE(_name);
    ZUX_RELEASE(_typeEncoding);
    ZUX_SUPER_DEALLOC;
}

- (NSString *)name {
    return _name;
}

- (NSString *)typeEncoding {
    return _typeEncoding;
}

- (ptrdiff_t)offset {
    return -1;
}

@end
