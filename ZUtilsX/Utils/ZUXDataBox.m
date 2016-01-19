//
//  ZUXDataBox.m
//  ZUtilsX
//
//  Created by Char Aznable on 16/1/15.
//  Copyright © 2016年 org.cuc.n3. All rights reserved.
//

#import "ZUXDataBox.h"
#import "NSObject+ZUX.h"
#import "ZUXProperty.h"
#import "ZUXKeychain.h"
#import "ZUXJson.h"

@implementation ZUXDataBox 

static NSString *appEverLaunchedKey;
static NSString *appFirstLaunchKey;

+ (void)load {
    static dispatch_once_t once_t;
    dispatch_once(&once_t, ^{
        appEverLaunchedKey =
#ifdef zuxAppEverLaunchedKey
        zuxAppEverLaunchedKey ?:
#endif
        ZUX_RETAIN(AppKeyFormat(AppEverLaunched));
        appFirstLaunchKey =
#ifdef zuxAppFirstLaunchKey
        zuxAppFirstLaunchKey ?:
#endif
        ZUX_RETAIN(AppKeyFormat(AppFirstLaunch));
        
        NSUserDefaults *userDefault = ShareUserDefaults;
        if (![userDefault boolForKey:appEverLaunchedKey]) {
            [userDefault setBool:YES forKey:appEverLaunchedKey];
            [userDefault setBool:YES forKey:appFirstLaunchKey];
        } else [userDefault setBool:NO forKey:appFirstLaunchKey];
        [userDefault synchronize];
    });
}

+ (BOOL)appEverLaunched {
    return [ShareUserDefaults boolForKey:appEverLaunchedKey];
}

+ (BOOL)appFirstLaunch {
    return [ShareUserDefaults boolForKey:appFirstLaunchKey];
}

@end

void synthesizeZUXDataBoxProperty(NSString *className, NSString *propertyName,
                                  NSDictionary *(^dataRefBlock)(id instance)) {
    Class cls = objc_getClass(className.UTF8String);
    ZUXProperty *property = [ZUXProperty propertyWithName:propertyName inClass:cls];
    NSCAssert(property.property, @"Could not find property %@.%@", className, propertyName);
    NSCAssert(property.attributes.count != 0, @"Could not fetch property attributes for %@.%@", className, propertyName);
    NSCAssert(!property.isWeakReference, @"Does not support weak-reference property %@.%@", className, propertyName);
    
    id getter = ^(id self) { return [dataRefBlock(self) objectForKey:propertyName]; };
    id setter = ^(id self, id value) { [(NSMutableDictionary *)dataRefBlock(self) setObject:value forKey:propertyName]; };
    if (!class_addMethod(cls, property.getter, imp_implementationWithBlock(getter), "@@:"))
        NSCAssert(NO, @"Could not add getter %s for property %@.%@",
                  sel_getName(property.getter), className, propertyName);
    if (!property.isReadOnly)
        if (!class_addMethod(cls, property.setter, imp_implementationWithBlock(setter), "v@:@"))
            NSCAssert(NO, @"Could not add setter %s for property %@.%@",
                      sel_getName(property.setter), className, propertyName);
}

NSDictionary *userDataRef(NSDictionary *dataRef, NSString *userId) {
    if (![[dataRef objectForKey:userId] isKindOfClass:NSClassFromString(@"__NSDictionaryM")])
        [(NSMutableDictionary *)dataRef setObject:[NSMutableDictionary dictionaryWithDictionary:
                                                   [dataRef objectForKey:userId]] forKey:userId];
    return [dataRef objectForKey:userId];
}

NSDictionary *publicData(id instance, NSString *key) {
    if (ZUX_EXPECT_F(![instance propertyForAssociateKey:key]))
        [instance setProperty:[NSMutableDictionary dictionaryWithDictionary:
                               [ShareUserDefaults objectForKey:key]]
              forAssociateKey:key];
    return [instance propertyForAssociateKey:key];
}

NSDictionary *protectedData(id instance, NSString *key, NSString *domain) {
    if (ZUX_EXPECT_F(![instance propertyForAssociateKey:key])) {
        NSError *error = nil;
        NSString *dataStr = [ZUXKeychain passwordForUsername:key andService:domain error:&error] ?: @"{}";
        if (error) ZLog(@"Keychain Error: %@", error);
        [instance setProperty:[NSMutableDictionary dictionaryWithDictionary:
                               [ZUXJson objectFromJsonString:dataStr]]
              forAssociateKey:key];
    }
    return [instance propertyForAssociateKey:key];
}

NSDictionary *privateData(id instance, NSString *key, NSString *domain) {
    if (ZUX_EXPECT_F(![instance propertyForAssociateKey:key])) {
        if ([ZUXDataBox appFirstLaunch]) {
            [ZUXKeychain deletePasswordForUsername:key andService:domain error:NULL];
            [instance setProperty:[NSMutableDictionary dictionary] forAssociateKey:key];
        }
    }
    return protectedData(instance, key, domain);
}

void publicDataSynchronize(id instance, NSString *key) {
    [ShareUserDefaults setObject:publicData(instance, key) forKey:key];
    [ShareUserDefaults synchronize];
}

void protectedDataSynchronize(id instance, NSString *key, NSString *domain) {
    NSString *dataStr = [ZUXJson jsonStringFromObject:protectedData(instance, key, domain)];
    if (!dataStr) return;
    NSError *error = nil;
    [ZUXKeychain storePassword:dataStr forUsername:key andService:domain updateExisting:YES error:&error];
    if (error) ZLog(@"Keychain Synchronize Error: %@", error);
}

void privateDataSynchronize(id instance, NSString *key, NSString *domain) {
    NSString *dataStr = [ZUXJson jsonStringFromObject:privateData(instance, key, domain)];
    if (!dataStr) return;
    NSError *error = nil;
    [ZUXKeychain storePassword:dataStr forUsername:key andService:domain updateExisting:YES error:&error];
    if (error) ZLog(@"Keychain Synchronize Error: %@", error);
}
