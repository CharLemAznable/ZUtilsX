//
//  ZUXProperty.m
//  ZUtilsX
//
//  Created by Char Aznable on 16/1/5.
//  Copyright © 2016年 org.cuc.n3. All rights reserved.
//

#import "ZUXProperty.h"
#import "NSString+ZUX.h"
#import "zarc.h"

NSString *const ZUXPropertyReadOnlyAttribute                        = @"R";
NSString *const ZUXPropertyNonAtomicAttribute                       = @"N";
NSString *const ZUXPropertyWeakReferenceAttribute                   = @"W";
NSString *const ZUXPropertyEligibleForGarbageCollectionAttribute    = @"P";
NSString *const ZUXPropertyDynamicAttribute                         = @"D";
NSString *const ZUXPropertyRetainAttribute                          = @"&";
NSString *const ZUXPropertyCopyAttribute                            = @"C";
NSString *const ZUXPropertyGetterAttribute                          = @"G";
NSString *const ZUXPropertySetterAttribute                          = @"S";
NSString *const ZUXPropertyBackingIVarNameAttribute                 = @"V";
NSString *const ZUXPropertyTypeEncodingAttribute                    = @"T";

@interface ZUXPropertyInternal : ZUXProperty {
    objc_property_t _property;
    NSMutableDictionary *_attrs;
    NSString *_name;
    SEL _getter;
    SEL _setter;
    Class _objectClass;
}
@end // ZUXPropertyInternal

#pragma mark - Implementation -

@implementation ZUXProperty

+ (ZUXProperty *)propertyWithObjCProperty:(objc_property_t)property {
    return ZUX_AUTORELEASE([[self alloc] initWithObjCProperty:property]);
}

+ (ZUXProperty *)propertyWithName:(NSString *)name inClass:(Class)cls {
    return ZUX_AUTORELEASE([[self alloc] initWithName:name inClass:cls]);
}

+ (ZUXProperty *)propertyWithName:(NSString *)name attributes:(NSDictionary *)attributes {
    return ZUX_AUTORELEASE([[self alloc] initWithName:name attributes:attributes]);
}

- (ZUX_INSTANCETYPE)initWithObjCProperty:(objc_property_t)property {
    ZUX_RELEASE(self);
    return [[ZUXPropertyInternal alloc] initWithObjCProperty:property];
}

- (ZUX_INSTANCETYPE)initWithName:(NSString *)name inClass:(Class)cls {
    ZUX_RELEASE(self);
    return [[ZUXPropertyInternal alloc] initWithName:name inClass:cls];
}

- (ZUX_INSTANCETYPE)initWithName:(NSString *)name attributes:(NSDictionary *)attributes {
    ZUX_RELEASE(self);
    return [[ZUXPropertyInternal alloc] initWithName:name attributes:attributes];
}

- (NSString *)description {
    return [NSString stringWithFormat:@"<%@ %p: %@ %@ %@ %@>",
            [self class], self, [self name], [self attributeEncodings], [self typeEncoding], [self ivarName]];
}

- (BOOL)isEqual:(id)other {
    return [other isKindOfClass:[self class]]
    && [[self name] isEqual:[other name]]
    && (![self attributeEncodings] ? ![other attributeEncodings]
        : [[self attributeEncodings] isEqual:[other attributeEncodings]])
    && [[self typeEncoding] isEqual:[other typeEncoding]]
    && (![self ivarName] ? ![other ivarName]
        : [[self ivarName] isEqual:[other ivarName]]);
}

- (NSUInteger)hash {
    return [[self name] hash] ^ [[self typeEncoding] hash];
}

- (NSDictionary *)attributes {
    [self doesNotRecognizeSelector:_cmd];
    return nil;
}

- (BOOL)addToClass:(Class)classToAddTo {
    [self doesNotRecognizeSelector:_cmd];
    return NO;
}

- (NSString *)attributeEncodings {
    [self doesNotRecognizeSelector:_cmd];
    return nil;
}

- (BOOL)isReadOnly {
    [self doesNotRecognizeSelector:_cmd];
    return NO;
}

- (BOOL)isNonAtomic {
    [self doesNotRecognizeSelector:_cmd];
    return NO;
}

- (BOOL)isWeakReference {
    [self doesNotRecognizeSelector:_cmd];
    return NO;
}

- (BOOL)isEligibleForGarbageCollection {
    [self doesNotRecognizeSelector:_cmd];
    return NO;
}

- (BOOL)isDynamic {
    [self doesNotRecognizeSelector:_cmd];
    return NO;
}

- (ZUXPropertyMemoryManagementPolicy)memoryManagementPolicy {
    [self doesNotRecognizeSelector:_cmd];
    return ZUXPropertyMemoryManagementPolicyAssign;
}

- (SEL)getter {
    [self doesNotRecognizeSelector:_cmd];
    return (SEL)0;
}

- (SEL)setter {
    [self doesNotRecognizeSelector:_cmd];
    return (SEL)0;
}

- (NSString *)name {
    [self doesNotRecognizeSelector:_cmd];
    return nil;
}

- (NSString *)ivarName {
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

- (Class)objectClass {
    [self doesNotRecognizeSelector:_cmd];
    return nil;
}

@end

@interface ZUXPropertyInternal () {
    dispatch_once_t once_getter;
    dispatch_once_t once_setter;
    dispatch_once_t once_objectClass;
}
@end

@implementation ZUXPropertyInternal

+ (void)load {
    static dispatch_once_t once_t;
    dispatch_once(&once_t, ^{
        ZUX_ENABLE_CATEGORY(ZUX_NSString);
    });
}

- (ZUX_INSTANCETYPE)initWithObjCProperty:(objc_property_t)property {
    if (ZUX_EXPECT_T(self = [self init])) {
        _property = property;
        if (ZUX_EXPECT_T(_property)) _name = [@(property_getName(_property)) copy];
        NSArray *attrs = [@(property_getAttributes(property)) arraySplitedByString:@","];
        _attrs = [[NSMutableDictionary alloc] initWithCapacity:[attrs count]];
        for(NSString *attrPair in attrs)
            [_attrs setObject:[attrPair substringFromIndex:1]
                       forKey:[attrPair substringToIndex:1]];
    }
    return self;
}

- (ZUX_INSTANCETYPE)initWithName:(NSString *)name inClass:(Class)cls {
    return [self initWithObjCProperty:class_getProperty(cls, name.UTF8String)];
}

- (ZUX_INSTANCETYPE)initWithName:(NSString *)name attributes:(NSDictionary *)attributes {
    if (ZUX_EXPECT_T(self = [self init])) {
        _name = [name copy];
        _attrs = [attributes copy];
    }
    return self;
}

- (void)dealloc {
    ZUX_RELEASE(_name);
    ZUX_RELEASE(_attrs);
    ZUX_SUPER_DEALLOC;
}

- (NSDictionary *)attributes {
    return ZUX_AUTORELEASE([_attrs copy]);
}

- (BOOL)addToClass:(Class)classToAddTo {
    objc_property_attribute_t *cattrs = calloc([_attrs count], sizeof(objc_property_attribute_t));
    unsigned attrIdx = 0;
    for (NSString *attrKey in _attrs) {
        cattrs[attrIdx].name = [attrKey UTF8String];
        cattrs[attrIdx].value = [[_attrs objectForKey:attrKey] UTF8String];
        attrIdx++;
    }
    BOOL result = class_addProperty(classToAddTo, [[self name] UTF8String],
                                    cattrs, (unsigned int)[_attrs count]);
    free(cattrs);
    return result;
}

- (NSString *)attributeEncodings {
    NSMutableArray *filteredAttributes = [NSMutableArray arrayWithCapacity:[_attrs count] - 2];
    for (NSString *attrKey in _attrs) {
        if (![attrKey isEqualToString:ZUXPropertyTypeEncodingAttribute] &&
            ![attrKey isEqualToString:ZUXPropertyBackingIVarNameAttribute])
            [filteredAttributes addObject:[_attrs objectForKey:attrKey]];
    }
    return [filteredAttributes componentsJoinedByString:@","];
}

- (BOOL)isReadOnly {
    return [self hasAttribute:ZUXPropertyReadOnlyAttribute];
}

- (BOOL)isNonAtomic {
    return [self hasAttribute:ZUXPropertyNonAtomicAttribute];
}

- (BOOL)isWeakReference {
    if ([self memoryManagementPolicy] == ZUXPropertyMemoryManagementPolicyAssign
        && [[[self typeEncoding] substringToIndex:1] isEqualToString:@"@"]) return YES;
    return [self hasAttribute:ZUXPropertyWeakReferenceAttribute];
}

- (BOOL)isEligibleForGarbageCollection {
    return [self hasAttribute:ZUXPropertyEligibleForGarbageCollectionAttribute];
}

- (BOOL)isDynamic {
    return [self hasAttribute:ZUXPropertyDynamicAttribute];
}

- (ZUXPropertyMemoryManagementPolicy)memoryManagementPolicy {
    if ([self hasAttribute:ZUXPropertyRetainAttribute]) return ZUXPropertyMemoryManagementPolicyRetain;
    if ([self hasAttribute:ZUXPropertyCopyAttribute]) return ZUXPropertyMemoryManagementPolicyCopy;
    return ZUXPropertyMemoryManagementPolicyAssign;
}

- (SEL)getter {
    dispatch_once(&once_getter, ^{
        _getter = sel_registerName(([self valueOfAttribute:ZUXPropertyGetterAttribute] ?:
                                    _name).UTF8String);
    });
    return _getter;
}

- (SEL)setter {
    dispatch_once(&once_setter, ^{
        if ([self isReadOnly]) return;
        _setter = sel_registerName(([self valueOfAttribute:ZUXPropertySetterAttribute] ?:
                                    [NSString stringWithFormat:@"set%@:", [_name capitalizedString]]).UTF8String);
    });
    return _setter;
}

- (NSString *)name {
    return _name;
}

- (NSString *)ivarName {
    return [self valueOfAttribute:ZUXPropertyBackingIVarNameAttribute];
}

- (NSString *)typeName {
    return [[self typeEncoding] stringByTrimmingCharactersInSet:
            [NSCharacterSet characterSetWithCharactersInString:@"@\""]];
}

- (NSString *)typeEncoding {
    return [self valueOfAttribute:ZUXPropertyTypeEncodingAttribute];
}

- (Class)objectClass {
    dispatch_once(&once_objectClass, ^{
        if ([self typeEncoding].length >= 2 && [[[self typeEncoding] substringToIndex:2] isEqualToString:@"@\""]) {
            _objectClass = objc_getClass([self typeName].UTF8String);
        } else if ([[[self typeEncoding] substringToIndex:1] isEqualToString:@"{"]) {
            _objectClass = [NSValue class];
        }
    });
    return _objectClass;
}

#pragma mark - Privates -

- (BOOL)hasAttribute:(NSString *)code {
    return [_attrs objectForKey:code] != nil;
}

- (NSString *)valueOfAttribute:(NSString *)code {
    return [_attrs objectForKey:code];
}

@end
