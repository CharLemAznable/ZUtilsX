//
//  NSDictionary+ZUX.m
//  ZUtilsX
//
//  Created by Char Aznable on 15/11/13.
//  Copyright © 2015年 org.cuc.n3. All rights reserved.
//

#import "NSDictionary+ZUX.h"
#import "NSNull+ZUX.h"
#import "zarc.h"

ZUX_CATEGORY_M(ZUX_NSDictionary)

@implementation NSDictionary (ZUX)

- (NSDictionary *)deepCopy {
    return [[NSDictionary alloc] initWithDictionary:self copyItems:YES];
}

- (NSMutableDictionary *)deepMutableCopy {
    return [[NSMutableDictionary alloc] initWithDictionary:self copyItems:YES];
}

- (id)objectForKey:(id)key defaultValue:(id)defaultValue {
    ZUX_ENABLE_CATEGORY(ZUX_NSNull);
    return [NSNull isNull:[self objectForKey:key]] ? defaultValue : [self objectForKey:key];
}

- (NSDictionary *)subDictionaryForKeys:(NSArray *)keys {
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [self enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        if ([keys containsObject:key]) [dict setValue:obj forKey:key];
    }];
    return ZUX_AUTORELEASE([dict copy]);
}

@end
