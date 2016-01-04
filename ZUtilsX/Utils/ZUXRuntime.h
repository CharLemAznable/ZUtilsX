//
//  ZUXRuntime.h
//  ZUtilsX
//
//  Created by Char Aznable on 15/11/17.
//  Copyright © 2015年 org.cuc.n3. All rights reserved.
//

#ifndef ZUtilsX_ZUXRuntime_h
#define ZUtilsX_ZUXRuntime_h

#import <Foundation/Foundation.h>
#import "zobjc.h"
#import <objc/runtime.h>

typedef NS_ENUM(NSUInteger, ZUXPropertyMemoryManagementPolicy) {
    ZUXPropertyMemoryManagementPolicyAssign = 0,
    ZUXPropertyMemoryManagementPolicyRetain,
    ZUXPropertyMemoryManagementPolicyCopy,
};

@interface ZUXPropertyAttribute : NSObject

@property (nonatomic, readonly, getter=isReadonly) BOOL readonly;
@property (nonatomic, readonly, getter=isNonatomic) BOOL nonatomic;
@property (nonatomic, readonly, getter=isWeak) BOOL weak;
@property (nonatomic, readonly) BOOL canBeCollected;
@property (nonatomic, readonly, getter=isDynamic) BOOL dynamic;
@property (nonatomic, readonly) ZUXPropertyMemoryManagementPolicy memoryManagementPolicy;
@property (nonatomic, readonly) SEL getter;
@property (nonatomic, readonly) SEL setter;
@property (nonatomic, readonly) NSString *name;
@property (nonatomic, readonly) NSString *ivar;
@property (nonatomic, readonly) NSString *type;
@property (nonatomic, readonly) Class objectClass;

@end

ZUX_EXTERN ZUXPropertyAttribute *ZUX_GetPropertyAttributeByName(Class cls, NSString *propertyName);
ZUX_EXTERN ZUXPropertyAttribute *ZUX_GetPropertyAttribute(objc_property_t property);

typedef void (^ZUXObjectPropertyProcessor)(id object, objc_property_t property);
ZUX_EXTERN void enumerateObjectProperties(id object, ZUXObjectPropertyProcessor processor);

typedef void (^ZUXPropertyProcessor)(objc_property_t property);
ZUX_EXTERN void enumerateClassProperties(Class cls, ZUXPropertyProcessor processor);

#endif /* ZUtilsX_ZUXRuntime_h */
