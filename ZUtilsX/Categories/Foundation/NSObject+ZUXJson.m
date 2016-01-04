//
//  NSObject+ZUXJson.m
//  ZUtilsX
//
//  Created by Char Aznable on 15/11/20.
//  Copyright © 2015年 org.cuc.n3. All rights reserved.
//

#import "NSObject+ZUXJson.h"
#import "NSString+ZUX.h"
#import "NSNumber+ZUX.h"
#import "ZUXGeometry.h"
#import "ZUXRuntime.h"
#import "ZUXJson.h"
#import "zobjc.h"
#import "zarc.h"
#import "zconstant.h"
#import <objc/runtime.h>

ZUX_CATEGORY_M(ZUXJson_NSObject)

#if NS_BLOCKS_AVAILABLE

@implementation NSObject (ZUXJson)

static NSArray *NSObjectProperties = nil;

+ (void)load {
    static dispatch_once_t once_t;
    dispatch_once(&once_t, ^{
        NSMutableArray *properties = [NSMutableArray array];
        enumerateClassProperties([NSObject class], ^(objc_property_t property) {
            [properties addObject:ZUX_GetPropertyAttribute(property).name];
        });
        NSObjectProperties = [properties copy];
    });
}

- (id)zuxJsonObject {
    NSMutableDictionary *properties = [NSMutableDictionary dictionary];
    enumerateObjectPropertiesWithProcessor(self, ^(id object, ZUXPropertyAttribute *property) {
        if ([property isWeak] || [NSObjectProperties containsObject:property.name]) return;
        
        @try {
            id jsonObj = [[object valueForKey:property.name] zuxJsonObject];
            if (!jsonObj) return;
            [properties setObject:jsonObj forKey:property.name];
        }
        @catch (NSException *exception) {
            ZLog(@"%@", exception);
        }
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
        enumerateObjectPropertiesWithProcessor(self, ^(id object, ZUXPropertyAttribute *property) {
            if ([property isReadonly] || [property isWeak] || [NSObjectProperties containsObject:property.name]) return;
            
            id value = [jsonObject objectForKey:property.name];
            if (!value) return;
            
            Class propertyClass = property.objectClass;
            if (propertyClass == [NSValue class]) value = [NSValue valueWithJsonObject:value];
            else if (propertyClass) value = ZUX_AUTORELEASE([[propertyClass alloc] initWithJsonObject:value]);
            
            @try {
                [object setValue:value forKey:property.name];
            }
            @catch (NSException *exception) {
                ZLog(@"%@", exception);
            }
        });
    }
    return self;
}

typedef void (^ZUXJsonPropertyProcessor)(id object, ZUXPropertyAttribute *property);
ZUX_STATIC_INLINE void enumerateObjectPropertiesWithProcessor(id object, ZUXJsonPropertyProcessor processor) {
    enumerateObjectProperties(object, ^(id object, objc_property_t property) {
        processor(object, ZUX_GetPropertyAttribute(property));
    });
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

@implementation NSValue (ZUXJson)

- (id)zuxJsonObject {
    const char *objCType = [self objCType];
    NSMutableDictionary *properties = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                       @(objCType), @"type", nil];
    if (strcmp(objCType, @encode(CGPoint)) == 0) {
        CGPoint p = [self CGPointValue];
        properties[@"x"] = @(p.x);
        properties[@"y"] = @(p.y);
        
    } else if (strcmp(objCType, @encode(CGVector)) == 0) {
        CGVector v = [self CGVectorValue];
        properties[@"dx"] = @(v.dx);
        properties[@"dy"] = @(v.dy);
        
    } else if (strcmp(objCType, @encode(CGSize)) == 0) {
        CGSize s = [self CGSizeValue];
        properties[@"width"] = @(s.width);
        properties[@"height"] = @(s.height);
        
    } else if (strcmp(objCType, @encode(CGRect)) == 0) {
        CGRect r = [self CGRectValue];
        properties[@"origin"] = [[NSValue valueWithCGPoint:r.origin] zuxJsonObject];
        properties[@"size"] = [[NSValue valueWithCGSize:r.size] zuxJsonObject];
        
    } else if (strcmp(objCType, @encode(CGAffineTransform)) == 0) {
        CGAffineTransform t = [self CGAffineTransformValue];
        properties[@"a"] = @(t.a);
        properties[@"b"] = @(t.b);
        properties[@"c"] = @(t.c);
        properties[@"d"] = @(t.d);
        properties[@"tx"] = @(t.tx);
        properties[@"ty"] = @(t.ty);
        
    } else if (strcmp(objCType, @encode(UIEdgeInsets)) == 0) {
        UIEdgeInsets e = [self UIEdgeInsetsValue];
        properties[@"top"] = @(e.top);
        properties[@"left"] = @(e.left);
        properties[@"bottom"] = @(e.bottom);
        properties[@"right"] = @(e.right);
        
    } else if (strcmp(objCType, @encode(UIOffset)) == 0) {
        UIOffset o = [self UIOffsetValue];
        properties[@"horizontal"] = @(o.horizontal);
        properties[@"vertical"] = @(o.vertical);
        
    } else return [super zuxJsonObject];
    return ZUX_AUTORELEASE([properties copy]);
}

+ (NSValue *)valueWithJsonObject:(id)jsonObject {
    if (![jsonObject isKindOfClass:[NSDictionary class]]) return nil;
    
    ZUX_ENABLE_CATEGORY(ZUX_NSNumber);
    const char *objCType = [jsonObject[@"type"] UTF8String];
    if (strcmp(objCType, @encode(CGPoint)) == 0) {
        CGFloat x = [[jsonObject objectForKey:@"x"] cgfloatValue];
        CGFloat y = [[jsonObject objectForKey:@"y"] cgfloatValue];
        return [NSValue valueWithCGPoint:CGPointMake(x, y)];
        
    } else if (strcmp(objCType, @encode(CGVector)) == 0) {
        CGFloat dx = [[jsonObject objectForKey:@"dx"] cgfloatValue];
        CGFloat dy = [[jsonObject objectForKey:@"dy"] cgfloatValue];
        return [NSValue valueWithCGVector:CGVectorMake(dx, dy)];
        
    } else if (strcmp(objCType, @encode(CGSize)) == 0) {
        CGFloat width = [[jsonObject objectForKey:@"width"] cgfloatValue];
        CGFloat height = [[jsonObject objectForKey:@"height"] cgfloatValue];
        return [NSValue valueWithCGSize:CGSizeMake(width, height)];
        
    } else if (strcmp(objCType, @encode(CGRect)) == 0) {
        NSValue *origin = [NSValue valueWithJsonObject:[jsonObject objectForKey:@"origin"]];
        NSValue *size = [NSValue valueWithJsonObject:[jsonObject objectForKey:@"size"]];
        return [NSValue valueWithCGRect:ZUX_CGRectMake([origin CGPointValue], [size CGSizeValue])];
        
    } else if (strcmp(objCType, @encode(CGAffineTransform)) == 0) {
        CGFloat a = [[jsonObject objectForKey:@"a"] cgfloatValue];
        CGFloat b = [[jsonObject objectForKey:@"b"] cgfloatValue];
        CGFloat c = [[jsonObject objectForKey:@"c"] cgfloatValue];
        CGFloat d = [[jsonObject objectForKey:@"d"] cgfloatValue];
        CGFloat tx = [[jsonObject objectForKey:@"tx"] cgfloatValue];
        CGFloat ty = [[jsonObject objectForKey:@"ty"] cgfloatValue];
        return [NSValue valueWithCGAffineTransform:CGAffineTransformMake(a, b, c, d, tx, ty)];
        
    } else if (strcmp(objCType, @encode(UIEdgeInsets)) == 0) {
        CGFloat top = [[jsonObject objectForKey:@"top"] cgfloatValue];
        CGFloat left = [[jsonObject objectForKey:@"left"] cgfloatValue];
        CGFloat bottom = [[jsonObject objectForKey:@"bottom"] cgfloatValue];
        CGFloat right = [[jsonObject objectForKey:@"right"] cgfloatValue];
        return [NSValue valueWithUIEdgeInsets:UIEdgeInsetsMake(top, left, bottom, right)];
        
    } else if (strcmp(objCType, @encode(UIOffset)) == 0) {
        CGFloat horizontal = [[jsonObject objectForKey:@"horizontal"] cgfloatValue];
        CGFloat vertical = [[jsonObject objectForKey:@"vertical"] cgfloatValue];
        return [NSValue valueWithUIOffset:UIOffsetMake(horizontal, vertical)];
        
    }
    return nil;
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

#endif // NS_BLOCKS_AVAILABLE
