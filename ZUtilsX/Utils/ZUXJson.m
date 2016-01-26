//
//  ZUXJson.m
//  ZUtilsX
//
//  Created by Char Aznable on 15/11/18.
//  Copyright © 2015年 org.cuc.n3. All rights reserved.
//

#import "ZUXJson.h"
#import "NSObject+ZUXJson.h"
#import "zobjc.h"
#import "zarc.h"
#import "zadapt.h"
#import "ZUXJSONKit.h"

BOOL ZUX_USE_JSONKIT = NO;

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

+ (id)objectFromJsonString:(NSString *)jsonString {
    if (ZUX_USE_JSONKIT) {
        return [jsonString objectFromJSONString];
    } else {
        return [self objectFromJsonData:
                [jsonString dataUsingEncoding:NSUTF8StringEncoding]];
    }
}

+ (id)objectFromJsonData:(NSData *)jsonData asClass:(Class)clazz {
    return ZUX_AUTORELEASE([[clazz alloc] initWithJsonObject:[self objectFromJsonData:jsonData]]);
}

+ (id)objectFromJsonString:(NSString *)jsonString asClass:(Class)clazz {
    return ZUX_AUTORELEASE([[clazz alloc] initWithJsonObject:[self objectFromJsonString:jsonString]]);
}

+ (NSData *)jsonDataFromObject:(id)object {
    if (!object) return nil;
    if (![self isValidJSONObject:object]) {
        id jsonObject = [object zuxJsonObject];
        if (ZUX_EXPECT_F(![self isValidJSONObject:jsonObject])) {
            return [[jsonObject description] dataUsingEncoding:NSUTF8StringEncoding];
        }
        return ZUX_USE_JSONKIT ? [jsonObject JSONData] :
        [NSJSONSerialization dataWithJSONObject:jsonObject options:0 error:NULL];
    }
    return ZUX_USE_JSONKIT ? [object JSONData] :
    [NSJSONSerialization dataWithJSONObject:object options:0 error:NULL];
}

+ (NSString *)jsonStringFromObject:(id)object {
    NSData *jsonData = [self jsonDataFromObject:object];
    if (!jsonData || [jsonData length] == 0) return nil;
    return ZUX_AUTORELEASE([[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding]);
}

+ (BOOL)isValidJSONObject:(id)object {
    return ZUX_USE_JSONKIT ? [object isKindOfClass:[NSString class]]
    || [object isKindOfClass:[NSArray class]]
    || [object isKindOfClass:[NSDictionary class]] :
    [NSJSONSerialization isValidJSONObject:object];
}

@end
