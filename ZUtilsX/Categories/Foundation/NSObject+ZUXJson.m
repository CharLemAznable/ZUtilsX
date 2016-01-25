//
//  NSObject+ZUXJson.m
//  ZUtilsX
//
//  Created by Char Aznable on 15/11/20.
//  Copyright © 2015年 org.cuc.n3. All rights reserved.
//

#import "NSObject+ZUXJson.h"
#import "NSObject+ZUX.h"
#import "NSString+ZUX.h"
#import "NSNumber+ZUX.h"
#import "ZUXProperty.h"
#import "ZUXGeometry.h"
#import "ZUXJson.h"
#import "zobjc.h"
#import "zarc.h"
#import "zconstant.h"
#import <objc/runtime.h>

#if NS_BLOCKS_AVAILABLE

@category_implementation(NSObject, ZUXJson)

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

- (id)zuxJsonObject {
    NSMutableDictionary *properties = [NSMutableDictionary dictionary];
    [self enumerateZUXPropertiesWithBlock:^(id object, ZUXProperty *property) {
        if ([property isWeakReference] || [NSObjectProperties containsObject:[property name]]) return;
        
        @try {
            id jsonObj = [[object valueForKey:[property name]] zuxJsonObject];
            if (!jsonObj) return;
            [properties setObject:jsonObj forKey:[property name]];
        }
        @catch (NSException *exception) {
            ZLog(@"%@", exception);
        }
    }];
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
        [self enumerateZUXPropertiesWithBlock:^(id object, ZUXProperty *property) {
            if ([property isReadOnly] || [property isWeakReference]
                || [NSObjectProperties containsObject:[property name]]) return;
            
            id value = [jsonObject objectForKey:[property name]];
            if (!value) return;
            
            Class propertyClass = [property objectClass];
            if (propertyClass == [NSValue class]) value = [NSValue valueWithJsonObject:value];
            else if (propertyClass) value = ZUX_AUTORELEASE([[propertyClass alloc] initWithJsonObject:value]);
            
            @try {
                [object setValue:value forKey:[property name]];
            }
            @catch (NSException *exception) {
                ZLog(@"%@", exception);
            }
        }];
    }
    return self;
}

@end

@category_implementation(NSNull, ZUXJson)

- (id)zuxJsonObject {
    return nil;
}

- (ZUX_INSTANCETYPE)initWithJsonObject:(id)jsonObject {
    return [NSNull null];
}

@end

@category_implementation(NSValue, ZUXJson)

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

+ (void)addSupportedObjCType:(const char *)objCType withName:(NSString *)typeName {
    [[NSValue propertyForAssociateKey:ZUXJsonableMappingKey] setObject:typeName forKey:@(objCType)];
}

- (id)zuxJsonObject {
    NSString *objCType = @([self objCType]);
    NSString *typeName = [[NSValue propertyForAssociateKey:ZUXJsonableMappingKey] objectForKey:objCType];
    if (!typeName) return [super zuxJsonObject];
    SEL jsonSel = NSSelectorFromString([NSString stringWithFormat:@"zuxJsonObjectFor%@", typeName]);
    if (!jsonSel || ![self respondsToSelector:jsonSel]) return [super zuxJsonObject];
    NSMutableDictionary *result = [NSMutableDictionary dictionaryWithObjectsAndKeys:objCType, @"type", nil];
    [result addEntriesFromDictionary:[self performSelector:jsonSel]];
    return ZUX_AUTORELEASE([result copy]);
}

+ (NSValue *)valueWithJsonObject:(id)jsonObject {
    if (![jsonObject isKindOfClass:[NSDictionary class]]) return nil;
    NSString *typeName = [[NSValue propertyForAssociateKey:ZUXJsonableMappingKey] objectForKey:jsonObject[@"type"]];
    if (!typeName) return nil;
    SEL jsonSel = NSSelectorFromString([NSString stringWithFormat:@"valueWithJsonObjectFor%@:", typeName]);
    if (!jsonSel || ![self respondsToSelector:jsonSel]) return nil;
    return [self performSelector:jsonSel withObject:jsonObject];
}

#pragma mark - json encode/decode implementation

- (id)zuxJsonObjectForCGPoint {
    if (strcmp([self objCType], @encode(CGPoint)) != 0) return nil;
    CGPoint p = [self CGPointValue];
    return @{@"x": @(p.x), @"y": @(p.y)};
}

+ (NSValue *)valueWithJsonObjectForCGPoint:(id)jsonObject {
    if (strcmp([jsonObject[@"type"] UTF8String], @encode(CGPoint)) != 0) return nil;
    CGFloat x = [[jsonObject objectForKey:@"x"] cgfloatValue];
    CGFloat y = [[jsonObject objectForKey:@"y"] cgfloatValue];
    return [NSValue valueWithCGPoint:CGPointMake(x, y)];
}

- (id)zuxJsonObjectForCGVector {
    if (strcmp([self objCType], @encode(CGVector)) != 0) return nil;
    CGVector v = [self CGVectorValue];
    return @{@"dx": @(v.dx), @"dy": @(v.dy)};
}

+ (NSValue *)valueWithJsonObjectForCGVector:(id)jsonObject {
    if (strcmp([jsonObject[@"type"] UTF8String], @encode(CGVector)) != 0) return nil;
    CGFloat dx = [[jsonObject objectForKey:@"dx"] cgfloatValue];
    CGFloat dy = [[jsonObject objectForKey:@"dy"] cgfloatValue];
    return [NSValue valueWithCGVector:CGVectorMake(dx, dy)];
}

- (id)zuxJsonObjectForCGSize {
    if (strcmp([self objCType], @encode(CGSize)) != 0) return nil;
    CGSize s = [self CGSizeValue];
    return @{@"width": @(s.width), @"height": @(s.height)};
}

+ (NSValue *)valueWithJsonObjectForCGSize:(id)jsonObject {
    if (strcmp([jsonObject[@"type"] UTF8String], @encode(CGSize)) != 0) return nil;
    CGFloat width = [[jsonObject objectForKey:@"width"] cgfloatValue];
    CGFloat height = [[jsonObject objectForKey:@"height"] cgfloatValue];
    return [NSValue valueWithCGSize:CGSizeMake(width, height)];
}

- (id)zuxJsonObjectForCGRect {
    if (strcmp([self objCType], @encode(CGRect)) != 0) return nil;
    CGRect r = [self CGRectValue];
    return @{@"origin": [[NSValue valueWithCGPoint:r.origin] zuxJsonObject],
             @"size": [[NSValue valueWithCGSize:r.size] zuxJsonObject]};
}

+ (NSValue *)valueWithJsonObjectForCGRect:(id)jsonObject {
    if (strcmp([jsonObject[@"type"] UTF8String], @encode(CGRect)) != 0) return nil;
    NSValue *origin = [NSValue valueWithJsonObject:[jsonObject objectForKey:@"origin"]];
    NSValue *size = [NSValue valueWithJsonObject:[jsonObject objectForKey:@"size"]];
    return [NSValue valueWithCGRect:ZUX_CGRectMake([origin CGPointValue], [size CGSizeValue])];
}

- (id)zuxJsonObjectForCGAffineTransform {
    if (strcmp([self objCType], @encode(CGAffineTransform)) != 0) return nil;
    CGAffineTransform t = [self CGAffineTransformValue];
    return @{@"a": @(t.a), @"b": @(t.b), @"c": @(t.c), @"d": @(t.d),
             @"tx": @(t.tx), @"ty": @(t.ty)};
}

+ (NSValue *)valueWithJsonObjectForCGAffineTransform:(id)jsonObject {
    if (strcmp([jsonObject[@"type"] UTF8String], @encode(CGAffineTransform)) != 0) return nil;
    CGFloat a = [[jsonObject objectForKey:@"a"] cgfloatValue];
    CGFloat b = [[jsonObject objectForKey:@"b"] cgfloatValue];
    CGFloat c = [[jsonObject objectForKey:@"c"] cgfloatValue];
    CGFloat d = [[jsonObject objectForKey:@"d"] cgfloatValue];
    CGFloat tx = [[jsonObject objectForKey:@"tx"] cgfloatValue];
    CGFloat ty = [[jsonObject objectForKey:@"ty"] cgfloatValue];
    return [NSValue valueWithCGAffineTransform:CGAffineTransformMake(a, b, c, d, tx, ty)];
}

- (id)zuxJsonObjectForUIEdgeInsets {
    if (strcmp([self objCType], @encode(UIEdgeInsets)) != 0) return nil;
    UIEdgeInsets e = [self UIEdgeInsetsValue];
    return @{@"top": @(e.top), @"left": @(e.left),
             @"bottom": @(e.bottom), @"right": @(e.right)};
}

+ (NSValue *)valueWithJsonObjectForUIEdgeInsets:(id)jsonObject {
    if (strcmp([jsonObject[@"type"] UTF8String], @encode(UIEdgeInsets)) != 0) return nil;
    CGFloat top = [[jsonObject objectForKey:@"top"] cgfloatValue];
    CGFloat left = [[jsonObject objectForKey:@"left"] cgfloatValue];
    CGFloat bottom = [[jsonObject objectForKey:@"bottom"] cgfloatValue];
    CGFloat right = [[jsonObject objectForKey:@"right"] cgfloatValue];
    return [NSValue valueWithUIEdgeInsets:UIEdgeInsetsMake(top, left, bottom, right)];
}

- (id)zuxJsonObjectForUIOffset {
    if (strcmp([self objCType], @encode(UIOffset)) != 0) return nil;
    UIOffset o = [self UIOffsetValue];
    return @{@"horizontal": @(o.horizontal), @"vertical": @(o.vertical)};
}

+ (NSValue *)valueWithJsonObjectForUIOffset:(id)jsonObject {
    if (strcmp([jsonObject[@"type"] UTF8String], @encode(UIOffset)) != 0) return nil;
    CGFloat horizontal = [[jsonObject objectForKey:@"horizontal"] cgfloatValue];
    CGFloat vertical = [[jsonObject objectForKey:@"vertical"] cgfloatValue];
    return [NSValue valueWithUIOffset:UIOffsetMake(horizontal, vertical)];
}

@end

@category_implementation(NSNumber, ZUXJson)

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

@category_implementation(NSString, ZUXJson)

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

@category_implementation(NSArray, ZUXJson)

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

@category_implementation(NSDictionary, ZUXJson)

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

#endif // NS_BLOCKS_AVAILABLE
