//
//  ZUXJson.m
//  ZUtilsX
//
//  Created by Char Aznable on 15/11/18.
//  Copyright © 2015年 org.cuc.n3. All rights reserved.
//

#import "ZUXJson.h"
#import "NSObject+ZUXJson.h"
#import "zarc.h"
#import "zadapt.h"
#import "ZUXJSONKit.h"

#if __IPHONE_OS_VERSION_MIN_REQUIRED < 50000
#define CAN_ONLY_USE_JSONKIT    1
#else
#define CAN_ONLY_USE_JSONKIT    0
#endif

#ifdef ZUX_USE_JSONKIT
#define CHOOSE_USE_JSONKIT      1
#else
#define CHOOSE_USE_JSONKIT      0
#endif

#define JSONKIT_ENABLED         CAN_ONLY_USE_JSONKIT || CHOOSE_USE_JSONKIT

@implementation ZUXJson

+ (id)objectFromJsonData:(NSData *)jsonData {
#if JSONKIT_ENABLED
    ZUX_ENABLE_CATEGORY(ZUX_JSONKit);
    return [jsonData objectFromJSONData];
#else
    return [NSJSONSerialization
            JSONObjectWithData:jsonData
            options:NSJSONReadingAllowFragments error:NULL];
#endif
}

+ (id)objectFromJsonString:(NSString *)jsonString {
#if JSONKIT_ENABLED
    ZUX_ENABLE_CATEGORY(ZUX_JSONKit);
    return [jsonString objectFromJSONString];
#else
    return [self objectFromJsonData:
            [jsonString dataUsingEncoding:NSUTF8StringEncoding]];
#endif
}

+ (id)objectFromJsonData:(NSData *)jsonData asClass:(Class)clazz {
#if JSONKIT_ENABLED
    ZUX_ENABLE_CATEGORY(ZUX_JSONKit);
    id jsonObject = [jsonData objectFromJSONData];
#else
    id jsonObject = [self objectFromJsonData:jsonData];
#endif
    ZUX_ENABLE_CATEGORY(ZUXJson_NSObject);
    return ZUX_AUTORELEASE([[clazz alloc] initWithJsonObject:jsonObject]);
}

+ (id)objectFromJsonString:(NSString *)jsonString asClass:(Class)clazz {
#if JSONKIT_ENABLED
    ZUX_ENABLE_CATEGORY(ZUX_JSONKit);
    id jsonObject = [jsonString objectFromJSONString];
#else
    id jsonObject = [self objectFromJsonString:jsonString];
#endif
    ZUX_ENABLE_CATEGORY(ZUXJson_NSObject);
    return ZUX_AUTORELEASE([[clazz alloc] initWithJsonObject:jsonObject]);
}

+ (NSData *)jsonDataFromObject:(id)object {
    if (![self isValidJSONObject:object]) {
        ZUX_ENABLE_CATEGORY(ZUXJson_NSObject);
        id jsonObject = [object zuxJsonObject];
        if (ZUX_EXPECT_F(![self isValidJSONObject:jsonObject])) {
            return [[jsonObject description] dataUsingEncoding:NSUTF8StringEncoding];
        }
#if JSONKIT_ENABLED
        return [jsonObject JSONData];
    }
    return [object JSONData];
#else
        return [NSJSONSerialization dataWithJSONObject:jsonObject options:0 error:NULL];
    }
    return [NSJSONSerialization dataWithJSONObject:object options:0 error:NULL];
#endif
}

+ (NSString *)jsonStringFromObject:(id)object {
    NSData *jsonData = [self jsonDataFromObject:object];
    if (!jsonData || [jsonData length] == 0) return nil;
    return ZUX_AUTORELEASE([[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding]);
}

+ (BOOL)isValidJSONObject:(id)object {
#if JSONKIT_ENABLED
    return [object isKindOfClass:[NSString class]]
    || [object isKindOfClass:[NSArray class]]
    || [object isKindOfClass:[NSDictionary class]];
#else
    return [NSJSONSerialization isValidJSONObject:object];
#endif
}

@end
