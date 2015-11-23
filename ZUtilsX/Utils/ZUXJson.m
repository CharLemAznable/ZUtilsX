//
//  ZUXJson.m
//  ZUtilsX
//
//  Created by Char Aznable on 15/11/18.
//  Copyright © 2015年 org.cuc.n3. All rights reserved.
//

#import "ZUXJson.h"
#import "NSObject+ZUXJson.h"
#import "ZUXCategory.h"
#import "zarc.h"

@implementation ZUXJson

+ (id)objectFromJsonData:(NSData *)jsonData {
    return [NSJSONSerialization
            JSONObjectWithData:jsonData
            options:NSJSONReadingAllowFragments error:NULL];
}

+ (id)objectFromJsonString:(NSString *)jsonString {
    return [self objectFromJsonData:
            [jsonString dataUsingEncoding:NSUTF8StringEncoding]];
}

+ (id)objectFromJsonData:(NSData *)jsonData asClass:(Class)clazz {
    ZUX_ENABLE_CATEGORY(ZUXJson_NSObject);
    return ZUX_AUTORELEASE([[clazz alloc] initWithJsonObject:
                            [self objectFromJsonData:jsonData]]);
}

+ (id)objectFromJsonString:(NSString *)jsonString asClass:(Class)clazz {
    ZUX_ENABLE_CATEGORY(ZUXJson_NSObject);
    return ZUX_AUTORELEASE([[clazz alloc] initWithJsonObject:
                            [self objectFromJsonString:jsonString]]);
}

+ (NSData *)jsonDataFromObject:(id)object {
    if (![NSJSONSerialization isValidJSONObject:object]) {
        ZUX_ENABLE_CATEGORY(ZUXJson_NSObject);
        id jsonObject = [object zuxJsonObject];
        if (![NSJSONSerialization isValidJSONObject:jsonObject])
            return [[jsonObject description] dataUsingEncoding:NSUTF8StringEncoding];
        return [NSJSONSerialization dataWithJSONObject:jsonObject options:0 error:NULL];
    }
    return [NSJSONSerialization dataWithJSONObject:object options:0 error:NULL];
}

+ (NSString *)jsonStringFromObject:(id)object {
    NSData *jsonData = [self jsonDataFromObject:object];
    if (!jsonData || [jsonData length] == 0) return nil;
    return ZUX_AUTORELEASE([[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding]);
}

@end
