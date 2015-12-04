//
//  NSObject+ZUXJson.m
//  ZUtilsX
//
//  Created by Char Aznable on 15/11/20.
//  Copyright © 2015年 org.cuc.n3. All rights reserved.
//

#import "NSObject+ZUXJson.h"
#import "NSString+ZUX.h"
#import "ZUXRuntime.h"
#import "ZUXJson.h"
#import "zobjc.h"
#import "zarc.h"
#import <objc/runtime.h>

ZUX_CATEGORY_M(ZUXJson_NSObject)

#if NS_BLOCKS_AVAILABLE

@implementation NSObject (ZUXJson)

- (id)zuxJsonObject {
    NSMutableDictionary *properties = [NSMutableDictionary dictionary];
    enumerateObjectPropertiesWithVerifierAndProcessor(self, ^BOOL(NSString *propertyAttrs) {
        return !isWeakReferenceProperty(propertyAttrs)
            && !isStructureTypeProperty(propertyAttrs);
        
    }, ^(id object, id propertyKey) {
        id jsonObj = [[object valueForKey:propertyKey] zuxJsonObject];
        if (!jsonObj) return;
        [properties setObject:jsonObj forKey:propertyKey];
        
    });
    return ZUX_AUTORELEASE([properties copy]);
}

- (NSData *)zuxJsonData {
    return [ZUXJson jsonDataFromObject:[self zuxJsonObject]];
}

- (NSString *)zuxJsonString {
    return [ZUXJson jsonStringFromObject:[self zuxJsonObject]];
}

- (ZUX_INSTANCETYPE)initWithJsonObject:(id)jsonObject {
    if (ZUX_EXPECT_T(self = [self init])) {
        enumerateObjectPropertiesWithVerifierAndProcessor(self, ^BOOL(NSString *propertyAttrs) {
            return !isWeakReferenceProperty(propertyAttrs)
            && !isReadOnlyProperty(propertyAttrs)
            && !isStructureTypeProperty(propertyAttrs);
            
        }, ^(id object, id propertyKey) {
            id value = ZUX_RETAIN([jsonObject valueForKey:propertyKey]);
            if (!value) return;
            
            NSString *propertyClassName = ZUX_GetPropertyClassName([object class], propertyKey);
            Class propertyClass = NSClassFromString(propertyClassName);
            if (propertyClass) {
                id newValue = [[propertyClass alloc] initWithJsonObject:value];
                ZUX_RELEASE(value);
                value = newValue;
            }
            
            [object setValue:value forKey:propertyKey];
            ZUX_RELEASE(value);
        });
    }
    return self;
}

typedef BOOL (^ZUXJsonPropertyVerifier)(NSString *propertyAttrs);

typedef void (^ZUXJsonPropertyProcessor)(id object, id propertyKey);

ZUX_STATIC_INLINE void enumerateObjectPropertiesWithVerifierAndProcessor
(id object, ZUXJsonPropertyVerifier verifier, ZUXJsonPropertyProcessor processor) {
    Class class = [object class];
    while (class != [NSObject class]) {
        if (![class respondsToSelector:@selector(zuxJsonPropertyNames)]) {
            class = [class superclass]; continue;
        }
        
        [[class zuxJsonPropertyNames] enumerateObjectsUsingBlock:
         ^(id _Nonnull propertyName, NSUInteger idx, BOOL *_Nonnull stop) {
             objc_property_t property = class_getProperty([object class], [propertyName UTF8String]);
             NSString* propertyAttrs = @(property_getAttributes(property));
             
             if (verifier && !verifier(propertyAttrs)) return;
             processor(object, propertyName);
         }];
        class = [class superclass];
    }
}

ZUX_STATIC_INLINE bool isWeakReferenceProperty(NSString *propertyAttrs) {
    ZUX_ENABLE_CATEGORY(ZUX_NSString);
    return [propertyAttrs containsString:@",W,"];
}

ZUX_STATIC_INLINE bool isReadOnlyProperty(NSString *propertyAttrs) {
    ZUX_ENABLE_CATEGORY(ZUX_NSString);
    return [propertyAttrs containsString:@",R,"];
}

ZUX_STATIC_INLINE bool isStructureTypeProperty(NSString *propertyAttrs) {
    NSScanner *scanner = [NSScanner scannerWithString:propertyAttrs];
    [scanner scanUpToString:@"T" intoString: nil];
    [scanner scanString:@"T" intoString:nil];
    return [scanner scanString:@"{" intoString:nil];
}

@end

@implementation NSNull (ZUXJson)

- (id)zuxJsonObject {
    return nil;
}

- (ZUX_INSTANCETYPE)initWithJsonObject:(id)jsonObject {
    return [NSNull null];
}

@end

@implementation NSNumber (ZUXJson)

- (id)zuxJsonObject {
    if (isnan([self doubleValue]) || isinf([self doubleValue])) return nil;
    return self;
}

- (ZUX_INSTANCETYPE)initWithJsonObject:(id)jsonObject {
    if ([jsonObject isKindOfClass:[NSNumber class]]) {
        return [self initWithDouble:[jsonObject doubleValue]];
    }
    return nil;
}

@end

@implementation NSString (ZUXJson)

- (id)zuxJsonObject {
    return self;
}

- (ZUX_INSTANCETYPE)initWithJsonObject:(id)jsonObject {
    if ([jsonObject isKindOfClass:[NSString class]]) {
        return [self initWithString:jsonObject];
    }
    return nil;
}

@end

@implementation NSArray (ZUXJson)

- (id)zuxJsonObject {
    if ([NSJSONSerialization isValidJSONObject:self]) return self;
    
    NSMutableArray *array = [NSMutableArray array];
    [self enumerateObjectsUsingBlock:
     ^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
         id jsonObj = [obj zuxJsonObject];
         if (!jsonObj) return;
         [array addObject:jsonObj];
     }];
    return ZUX_AUTORELEASE([array copy]);
}

- (ZUX_INSTANCETYPE)initWithJsonObject:(id)jsonObject {
    if ([jsonObject isKindOfClass:[NSArray class]]) {
        return [self initWithArray:jsonObject copyItems:YES];
    }
    return nil;
}

@end

@implementation NSDictionary (ZUXJson)

- (id)zuxJsonObject {
    if ([NSJSONSerialization isValidJSONObject:self]) return self;
    
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    [self enumerateKeysAndObjectsUsingBlock:
     ^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
         id jsonObj = [obj zuxJsonObject];
         if (!jsonObj) return;
         [dictionary setObject:jsonObj forKey:[key description]];
     }];
    return ZUX_AUTORELEASE([dictionary copy]);
}

- (ZUX_INSTANCETYPE)initWithJsonObject:(id)jsonObject {
    if ([jsonObject isKindOfClass:[NSDictionary class]]) {
        return [self initWithDictionary:jsonObject copyItems:YES];
    }
    return nil;
}

@end

#endif
