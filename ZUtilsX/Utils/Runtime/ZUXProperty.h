//
//  ZUXProperty.h
//  ZUtilsX
//
//  Created by Char Aznable on 16/1/5.
//  Copyright © 2016年 org.cuc.n3. All rights reserved.
//

#ifndef ZUtilsX_ZUXProperty_h
#define ZUtilsX_ZUXProperty_h

#import <Foundation/Foundation.h>
#import "zobjc.h"
#import <objc/runtime.h>

typedef NS_ENUM(NSUInteger, ZUXPropertyMemoryManagementPolicy) {
    ZUXPropertyMemoryManagementPolicyAssign = 0,
    ZUXPropertyMemoryManagementPolicyRetain,
    ZUXPropertyMemoryManagementPolicyCopy,
};

extern NSString *const ZUXPropertyReadOnlyAttribute;
extern NSString *const ZUXPropertyNonAtomicAttribute;
extern NSString *const ZUXPropertyWeakReferenceAttribute;
extern NSString *const ZUXPropertyEligibleForGarbageCollectionAttribute;
extern NSString *const ZUXPropertyDynamicAttribute;
extern NSString *const ZUXPropertyRetainAttribute;
extern NSString *const ZUXPropertyCopyAttribute;
extern NSString *const ZUXPropertyGetterAttribute;
extern NSString *const ZUXPropertySetterAttribute;
extern NSString *const ZUXPropertyBackingIVarNameAttribute;
extern NSString *const ZUXPropertyTypeEncodingAttribute;

@interface ZUXProperty : NSObject

+ (ZUXProperty *)propertyWithObjCProperty:(objc_property_t)property;
+ (ZUXProperty *)propertyWithName:(NSString *)name inClass:(Class)cls;
+ (ZUXProperty *)propertyWithName:(NSString *)name inClassNamed:(NSString *)className;
+ (ZUXProperty *)propertyWithName:(NSString *)name attributes:(NSDictionary *)attributes;

- (ZUX_INSTANCETYPE)initWithObjCProperty:(objc_property_t)property;
- (ZUX_INSTANCETYPE)initWithName:(NSString *)name inClass:(Class)cls;
- (ZUX_INSTANCETYPE)initWithName:(NSString *)name inClassNamed:(NSString *)className;
- (ZUX_INSTANCETYPE)initWithName:(NSString *)name attributes:(NSDictionary *)attributes;

- (objc_property_t)property;
- (NSDictionary *)attributes;
- (BOOL)addToClass:(Class)classToAddTo;

- (NSString *)attributeEncodings;
- (BOOL)isReadOnly;
- (BOOL)isNonAtomic;
- (BOOL)isWeakReference;
- (BOOL)isEligibleForGarbageCollection;
- (BOOL)isDynamic;
- (ZUXPropertyMemoryManagementPolicy)memoryManagementPolicy;
- (SEL)getter;
- (SEL)setter;
- (NSString *)name;
- (NSString *)ivarName;
- (NSString *)typeName;
- (NSString *)typeEncoding;
- (Class)objectClass;

@end

#endif /* ZUtilsX_ZUXProperty_h */
