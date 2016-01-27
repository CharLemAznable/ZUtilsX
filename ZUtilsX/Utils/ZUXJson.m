//
//  ZUXJson.m
//  ZUtilsX
//
//  Created by Char Aznable on 15/11/18.
//  Copyright © 2015年 org.cuc.n3. All rights reserved.
//

#import "ZUXJson.h"
#import "ZUXProperty.h"
#import "ZUXGeometry.h"
#import "NSObject+ZUX.h"
#import "NSNumber+ZUX.h"
#import "NSString+ZUX.h"
#import "ZUXJSONKit.h"
#import "zarc.h"
#import "zconstant.h"
#import <CoreGraphics/CGGeometry.h>
#import <UIKit/UIGeometry.h>
#import <objc/runtime.h>

#if NS_BLOCKS_AVAILABLE

NSString *const ZUXJSONABLE_CLASS_NAME = @"ZUXClassName";
NSString *const ZUXJSONABLE_STRUCT_NAME = @"ZUXStructName";
BOOL ZUX_USE_JSONKIT = NO;

ZUX_STATIC BOOL isValidJsonObject(id object);
ZUX_STATIC id parseZUXJsonObject(id jsonObject);

@implementation ZUXJson

+ (id)objectFromJsonData:(NSData *)jsonData {
    if (!jsonData) return nil;
    if (ZUX_USE_JSONKIT) {
        return [jsonData objectFromJSONData];
    } else {
        return [NSJSONSerialization
                JSONObjectWithData:jsonData
                options:NSJSONReadingAllowFragments error:NULL];
    }
}

+ (id)objectFromJsonData:(NSData *)jsonData asClass:(Class)clazz {
    return ZUX_AUTORELEASE([[clazz alloc] initWithValidJsonObject:[self objectFromJsonData:jsonData]]);
}

+ (id)objectFromJsonString:(NSString *)jsonString {
    if (ZUX_USE_JSONKIT) {
        return [jsonString objectFromJSONString];
    } else {
        return [self objectFromJsonData:
                [jsonString dataUsingEncoding:NSUTF8StringEncoding]];
    }
}

+ (id)objectFromJsonString:(NSString *)jsonString asClass:(Class)clazz {
    return ZUX_AUTORELEASE([[clazz alloc] initWithValidJsonObject:[self objectFromJsonString:jsonString]]);
}

+ (NSData *)jsonDataFromObject:(id)object {
    return [self jsonDataFromObject:object withOptions:ZUXJsonableNone];
}

+ (NSData *)jsonDataFromObject:(id)object withOptions:(ZUXJsonableOptions)options {
    if (!object) return nil;
    if (!isValidJsonObject(object)) {
        id jsonObject = [object validJsonObjectWithOptions:options];
        if (ZUX_EXPECT_F(!isValidJsonObject(jsonObject))) {
            return [[jsonObject description] dataUsingEncoding:NSUTF8StringEncoding];
        }
        return ZUX_USE_JSONKIT ? [jsonObject JSONData] :
        [NSJSONSerialization dataWithJSONObject:jsonObject options:0 error:NULL];
    }
    return ZUX_USE_JSONKIT ? [object JSONData] :
    [NSJSONSerialization dataWithJSONObject:object options:0 error:NULL];
}

+ (NSString *)jsonStringFromObject:(id)object {
    return [self jsonStringFromObject:object withOptions:ZUXJsonableNone];
}

+ (NSString *)jsonStringFromObject:(id)object withOptions:(ZUXJsonableOptions)options {
    NSData *jsonData = [self jsonDataFromObject:object withOptions:options];
    if (!jsonData || [jsonData length] == 0) return nil;
    return ZUX_AUTORELEASE([[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding]);
}

@end

@category_implementation(NSData, ZUXJson)

- (id)zuxJsonObject {
    return [ZUXJson objectFromJsonData:self];
}

- (id)zuxJsonObjectAsClass:(Class)clazz {
    return [ZUXJson objectFromJsonData:self asClass:clazz];
}

@end

@category_implementation(NSString, ZUXJson)

- (id)zuxJsonObject {
    return [ZUXJson objectFromJsonString:self];
}

- (id)zuxJsonObjectAsClass:(Class)clazz {
    return [ZUXJson objectFromJsonString:self asClass:clazz];
}

@end // NSString (ZUXJson)

@category_implementation(NSObject, ZUXJson)

- (NSData *)zuxJsonData {
    return [ZUXJson jsonDataFromObject:self];
}

- (NSData *)zuxJsonDataWithOptions:(ZUXJsonableOptions)options {
    return [ZUXJson jsonDataFromObject:self withOptions:options];
}

- (NSString *)zuxJsonString {
    return [ZUXJson jsonStringFromObject:self];
}

- (NSString *)zuxJsonStringWithOptions:(ZUXJsonableOptions)options {
    return [ZUXJson jsonStringFromObject:self withOptions:options];
}

@end // NSObject (ZUXJson)

@category_implementation(NSObject, ZUXJsonable)

static NSArray *NSObjectProperties = nil;

+ (void)load {
    static dispatch_once_t once_t;
    dispatch_once(&once_t, ^{
        NSMutableArray *properties = [NSMutableArray array];
        [self enumerateZUXPropertiesWithBlock:^(ZUXProperty *property) {
            [properties addObject:[property name]];
        }];
        NSObjectProperties = [properties copy];
    });
}

- (id)validJsonObject {
    return [self validJsonObjectWithOptions:ZUXJsonableNone];
}

- (id)validJsonObjectWithOptions:(ZUXJsonableOptions)options {
    NSMutableDictionary *properties = options & ZUXJsonableWriteClassName
    ? [NSMutableDictionary dictionaryWithObjectsAndKeys:[[self class] description], ZUXJSONABLE_CLASS_NAME, nil]
    : [NSMutableDictionary dictionary];
    
    [self enumerateZUXPropertiesWithBlock:^(id object, ZUXProperty *property) {
        if ([property isWeakReference] || [NSObjectProperties containsObject:[property name]]) return;
        
        @try {
            id jsonObj = [[object valueForKey:[property name]] validJsonObjectWithOptions:options];
            if (!jsonObj) return;
            [properties setObject:jsonObj forKey:[property name]];
        }
        @catch (NSException *exception) {
            ZLog(@"%@", exception);
        }
    }];
    return ZUX_AUTORELEASE([properties copy]);
}

- (ZUX_INSTANCETYPE)initWithValidJsonObject:(id)jsonObject {
    if (ZUX_EXPECT_T(self = [self init])) {
        [self setPropertiesWithValidJsonObject:jsonObject];
    }
    return self;
}

- (void)setPropertiesWithValidJsonObject:(id)jsonObject {
    [self enumerateZUXPropertiesWithBlock:^(id object, ZUXProperty *property) {
        if ([property isReadOnly] || [property isWeakReference]
            || [NSObjectProperties containsObject:[property name]]) return;
        
        id value = [jsonObject objectForKey:[property name]];
        if (!value) return;
        
        Class propertyClass = [property objectClass];
        if (propertyClass == [NSValue class]) value = [NSValue valueWithValidJsonObject:value];
        else if (propertyClass) value = ZUX_AUTORELEASE([[propertyClass alloc] initWithValidJsonObject:value]);
        else value = parseZUXJsonObject(value);
        
        @try {
            [object setValue:value forKey:[property name]];
        }
        @catch (NSException *exception) {
            ZLog(@"%@", exception);
        }
    }];
}

@end

@category_interface(NSNull, ZUXJsonable)
@end
@category_implementation(NSNull, ZUXJsonable)

- (id)validJsonObjectWithOptions:(ZUXJsonableOptions)options {
    return nil;
}

- (ZUX_INSTANCETYPE)initWithValidJsonObject:(id)jsonObject {
    return [NSNull null];
}

- (void)setPropertiesWithValidJsonObject:(id)jsonObject {
}

@end

@category_implementation(NSValue, ZUXJsonable)

static NSString *const ZUXJsonableMappingKey = @"ZUXJsonableMapping";

+ (void)load {
    static dispatch_once_t once_t;
    dispatch_once(&once_t, ^{
        [NSValue setProperty:[NSMutableDictionary dictionaryWithDictionary:
                              @{@(@encode(CGPoint))             :@"CGPoint",
                                @(@encode(CGVector))            :@"CGVector",
                                @(@encode(CGSize))              :@"CGSize",
                                @(@encode(CGRect))              :@"CGRect",
                                @(@encode(CGAffineTransform))   :@"CGAffineTransform",
                                @(@encode(UIEdgeInsets))        :@"UIEdgeInsets",
                                @(@encode(UIOffset))            :@"UIOffset"}]
             forAssociateKey:ZUXJsonableMappingKey];
    });
}

+ (void)addJsonableObjCType:(const char *)objCType withName:(NSString *)typeName {
    [[NSValue propertyForAssociateKey:ZUXJsonableMappingKey] setObject:typeName forKey:@(objCType)];
}

- (id)validJsonObjectWithOptions:(ZUXJsonableOptions)options {
    NSString *objCType = @([self objCType]);
    NSString *typeName = [[NSValue propertyForAssociateKey:ZUXJsonableMappingKey] objectForKey:objCType];
    if (!typeName) return [super validJsonObjectWithOptions:options];
    SEL jsonSel = NSSelectorFromString([NSString stringWithFormat:@"validJsonObjectFor%@", typeName]);
    if (!jsonSel || ![self respondsToSelector:jsonSel]) return [super validJsonObjectWithOptions:options];
    NSMutableDictionary *result = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                   objCType, ZUXJSONABLE_STRUCT_NAME, nil];
    [result addEntriesFromDictionary:[self performSelector:jsonSel]];
    return ZUX_AUTORELEASE([result copy]);
}

+ (NSValue *)valueWithValidJsonObject:(id)jsonObject {
    if (![jsonObject isKindOfClass:[NSDictionary class]]) return nil;
    NSString *typeName = [[NSValue propertyForAssociateKey:ZUXJsonableMappingKey]
                          objectForKey:jsonObject[ZUXJSONABLE_STRUCT_NAME]];
    if (!typeName) return nil;
    SEL jsonSel = NSSelectorFromString([NSString stringWithFormat:@"valueWithValidJsonObjectFor%@:", typeName]);
    if (!jsonSel || ![self respondsToSelector:jsonSel]) return nil;
    return [self performSelector:jsonSel withObject:jsonObject];
}

- (ZUX_INSTANCETYPE)initWithValidJsonObject:(id)jsonObject {
    return [self init];
}

- (void)setPropertiesWithValidJsonObject:(id)jsonObject {
}

#pragma mark - json encode/decode implementation

#define selfIsStructType(type) \
(strcmp([self objCType], @encode(type)) == 0)
#define jsonIsStructType(jsonObject, type) \
(strcmp([jsonObject[ZUXJSONABLE_STRUCT_NAME] UTF8String], @encode(type)) == 0)

- (id)validJsonObjectForCGPoint {
    if (!selfIsStructType(CGPoint)) return nil;
    CGPoint p = [self CGPointValue];
    return @{@"x": @(p.x), @"y": @(p.y)};
}

+ (NSValue *)valueWithValidJsonObjectForCGPoint:(id)jsonObject {
    if (!jsonIsStructType(jsonObject, CGPoint)) return nil;
    CGFloat x = [[jsonObject objectForKey:@"x"] cgfloatValue];
    CGFloat y = [[jsonObject objectForKey:@"y"] cgfloatValue];
    return [NSValue valueWithCGPoint:CGPointMake(x, y)];
}

- (id)validJsonObjectForCGVector {
    if (!selfIsStructType(CGVector)) return nil;
    CGVector v = [self CGVectorValue];
    return @{@"dx": @(v.dx), @"dy": @(v.dy)};
}

+ (NSValue *)valueWithValidJsonObjectForCGVector:(id)jsonObject {
    if (!jsonIsStructType(jsonObject, CGVector)) return nil;
    CGFloat dx = [[jsonObject objectForKey:@"dx"] cgfloatValue];
    CGFloat dy = [[jsonObject objectForKey:@"dy"] cgfloatValue];
    return [NSValue valueWithCGVector:CGVectorMake(dx, dy)];
}

- (id)validJsonObjectForCGSize {
    if (!selfIsStructType(CGSize)) return nil;
    CGSize s = [self CGSizeValue];
    return @{@"width": @(s.width), @"height": @(s.height)};
}

+ (NSValue *)valueWithValidJsonObjectForCGSize:(id)jsonObject {
    if (!jsonIsStructType(jsonObject, CGSize)) return nil;
    CGFloat width = [[jsonObject objectForKey:@"width"] cgfloatValue];
    CGFloat height = [[jsonObject objectForKey:@"height"] cgfloatValue];
    return [NSValue valueWithCGSize:CGSizeMake(width, height)];
}

- (id)validJsonObjectForCGRect {
    if (!selfIsStructType(CGRect)) return nil;
    CGRect r = [self CGRectValue];
    return @{@"origin": [[NSValue valueWithCGPoint:r.origin] validJsonObject],
             @"size": [[NSValue valueWithCGSize:r.size] validJsonObject]};
}

+ (NSValue *)valueWithValidJsonObjectForCGRect:(id)jsonObject {
    if (!jsonIsStructType(jsonObject, CGRect)) return nil;
    NSValue *origin = [NSValue valueWithValidJsonObject:[jsonObject objectForKey:@"origin"]];
    NSValue *size = [NSValue valueWithValidJsonObject:[jsonObject objectForKey:@"size"]];
    return [NSValue valueWithCGRect:ZUX_CGRectMake([origin CGPointValue], [size CGSizeValue])];
}

- (id)validJsonObjectForCGAffineTransform {
    if (!selfIsStructType(CGAffineTransform)) return nil;
    CGAffineTransform t = [self CGAffineTransformValue];
    return @{@"a": @(t.a), @"b": @(t.b), @"c": @(t.c), @"d": @(t.d),
             @"tx": @(t.tx), @"ty": @(t.ty)};
}

+ (NSValue *)valueWithValidJsonObjectForCGAffineTransform:(id)jsonObject {
    if (!jsonIsStructType(jsonObject, CGAffineTransform)) return nil;
    CGFloat a = [[jsonObject objectForKey:@"a"] cgfloatValue];
    CGFloat b = [[jsonObject objectForKey:@"b"] cgfloatValue];
    CGFloat c = [[jsonObject objectForKey:@"c"] cgfloatValue];
    CGFloat d = [[jsonObject objectForKey:@"d"] cgfloatValue];
    CGFloat tx = [[jsonObject objectForKey:@"tx"] cgfloatValue];
    CGFloat ty = [[jsonObject objectForKey:@"ty"] cgfloatValue];
    return [NSValue valueWithCGAffineTransform:CGAffineTransformMake(a, b, c, d, tx, ty)];
}

- (id)validJsonObjectForUIEdgeInsets {
    if (!selfIsStructType(UIEdgeInsets)) return nil;
    UIEdgeInsets e = [self UIEdgeInsetsValue];
    return @{@"top": @(e.top), @"left": @(e.left),
             @"bottom": @(e.bottom), @"right": @(e.right)};
}

+ (NSValue *)valueWithValidJsonObjectForUIEdgeInsets:(id)jsonObject {
    if (!jsonIsStructType(jsonObject, UIEdgeInsets)) return nil;
    CGFloat top = [[jsonObject objectForKey:@"top"] cgfloatValue];
    CGFloat left = [[jsonObject objectForKey:@"left"] cgfloatValue];
    CGFloat bottom = [[jsonObject objectForKey:@"bottom"] cgfloatValue];
    CGFloat right = [[jsonObject objectForKey:@"right"] cgfloatValue];
    return [NSValue valueWithUIEdgeInsets:UIEdgeInsetsMake(top, left, bottom, right)];
}

- (id)validJsonObjectForUIOffset {
    if (!selfIsStructType(UIOffset)) return nil;
    UIOffset o = [self UIOffsetValue];
    return @{@"horizontal": @(o.horizontal), @"vertical": @(o.vertical)};
}

+ (NSValue *)valueWithValidJsonObjectForUIOffset:(id)jsonObject {
    if (!jsonIsStructType(jsonObject, UIOffset)) return nil;
    CGFloat horizontal = [[jsonObject objectForKey:@"horizontal"] cgfloatValue];
    CGFloat vertical = [[jsonObject objectForKey:@"vertical"] cgfloatValue];
    return [NSValue valueWithUIOffset:UIOffsetMake(horizontal, vertical)];
}

@end

@category_interface(NSNumber, ZUXJsonable)
@end
@category_implementation(NSNumber, ZUXJsonable)

- (id)validJsonObjectWithOptions:(ZUXJsonableOptions)options {
    if (isnan([self doubleValue]) || isinf([self doubleValue])) return nil;
    return self;
}

- (ZUX_INSTANCETYPE)initWithValidJsonObject:(id)jsonObject {
    if ([jsonObject isKindOfClass:[NSNumber class]]) {
        return [self initWithDouble:[jsonObject doubleValue]];
    }
    return [self init];
}

- (void)setPropertiesWithValidJsonObject:(id)jsonObject {
}

@end

@category_interface(NSString, ZUXJsonable)
@end
@category_implementation(NSString, ZUXJsonable)

- (id)validJsonObjectWithOptions:(ZUXJsonableOptions)options {
    return self;
}

- (ZUX_INSTANCETYPE)initWithValidJsonObject:(id)jsonObject {
    if ([jsonObject isKindOfClass:[NSString class]]) {
        return [self initWithString:jsonObject];
    }
    return [self init];
}

- (void)setPropertiesWithValidJsonObject:(id)jsonObject {
}

@end

@category_implementation(NSArray, ZUXJsonable)

- (id)validJsonObjectWithOptions:(ZUXJsonableOptions)options {
    if ([NSJSONSerialization isValidJSONObject:self]) return self;
    
    NSMutableArray *array = [NSMutableArray array];
    [self enumerateObjectsUsingBlock:
     ^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
         id jsonObj = [obj validJsonObjectWithOptions:options];
         if (!jsonObj) return;
         [array addObject:jsonObj];
     }];
    return ZUX_AUTORELEASE([array copy]);
}

+ (NSArray *)arrayWithValidJsonObject:(id)jsonObject {
    return ZUX_AUTORELEASE([[self alloc] initWithValidJsonObject:jsonObject]);
}

- (ZUX_INSTANCETYPE)initWithValidJsonObject:(id)jsonObject {
    if ([jsonObject isKindOfClass:[NSArray class]]) {
        NSMutableArray *unjsonArray = [NSMutableArray array];
        [jsonObject enumerateObjectsUsingBlock:
         ^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
             [unjsonArray addObject:parseZUXJsonObject(obj)];
         }];
        return [self initWithArray:unjsonArray copyItems:YES];
    }
    return [self init];
}

- (void)setPropertiesWithValidJsonObject:(id)jsonObject {
}

@end

@category_implementation(NSMutableArray, ZUXJsonable)

+ (NSMutableArray *)arrayWithValidJsonObject:(id)jsonObject {
    return ZUX_AUTORELEASE([[self alloc] initWithValidJsonObject:jsonObject]);
}

@end

@category_implementation(NSDictionary, ZUXJsonable)

- (id)validJsonObjectWithOptions:(ZUXJsonableOptions)options {
    if ([NSJSONSerialization isValidJSONObject:self]) return self;
    
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    [self enumerateKeysAndObjectsUsingBlock:
     ^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
         [dictionary setObject:[obj validJsonObjectWithOptions:options]
                        forKey:[key validJsonObjectWithOptions:options]];
     }];
    return ZUX_AUTORELEASE([dictionary copy]);
}

+ (NSDictionary *)dictionaryWithValidJsonObject:(id)jsonObject {
    return ZUX_AUTORELEASE([[self alloc] initWithValidJsonObject:jsonObject]);
}

- (ZUX_INSTANCETYPE)initWithValidJsonObject:(id)jsonObject {
    if ([jsonObject isKindOfClass:[NSDictionary class]]) {
        NSMutableDictionary *unjsonDictionary = [NSMutableDictionary dictionary];
        [jsonObject enumerateKeysAndObjectsUsingBlock:
         ^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
             [unjsonDictionary setObject:parseZUXJsonObject(obj)
                                  forKey:parseZUXJsonObject(key)];
         }];
        return [self initWithDictionary:unjsonDictionary copyItems:YES];
    }
    return [self init];
}

- (void)setPropertiesWithValidJsonObject:(id)jsonObject {
}

@end

@category_implementation(NSMutableDictionary, ZUXJsonable)

+ (NSMutableDictionary *)dictionaryWithValidJsonObject:(id)jsonObject {
    return ZUX_AUTORELEASE([[self alloc] initWithValidJsonObject:jsonObject]);
}

@end

ZUX_STATIC BOOL isValidJsonObject(id object) {
    return ZUX_USE_JSONKIT ? [object isKindOfClass:[NSString class]]
    || [object isKindOfClass:[NSArray class]]
    || [object isKindOfClass:[NSDictionary class]] :
    [NSJSONSerialization isValidJSONObject:object];
}

ZUX_STATIC id parseZUXJsonObject(id jsonObject) {
    if ([jsonObject isKindOfClass:[NSArray class]]) return [NSArray arrayWithValidJsonObject:jsonObject];
    if ([jsonObject isKindOfClass:[NSDictionary class]]) {
        if ([jsonObject objectForKey:ZUXJSONABLE_STRUCT_NAME])
            return [NSValue valueWithValidJsonObject:jsonObject];
        if ([jsonObject objectForKey:ZUXJSONABLE_CLASS_NAME]) {
            Class clz = objc_getClass([[jsonObject objectForKey:ZUXJSONABLE_CLASS_NAME] UTF8String]);
            if (clz) return ZUX_AUTORELEASE([[clz alloc] initWithValidJsonObject:jsonObject]);
        }
        return [NSDictionary dictionaryWithValidJsonObject:jsonObject];
    } return jsonObject;
}

#endif
