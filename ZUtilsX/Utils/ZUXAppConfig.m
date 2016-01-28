//
//  ZUXAppConfig.m
//  ZUtilsX
//
//  Created by Char Aznable on 16/1/28.
//  Copyright © 2016年 org.cuc.n3. All rights reserved.
//

#import "ZUXAppConfig.h"
#import "NSObject+ZUX.h"
#import "NSDictionary+ZUX.h"
#import "ZUXProperty.h"
#import "zconstant.h"

ZUX_STATIC NSString *const AppConfigBundleNameKey = @"AppConfigBundleNameKey";
ZUX_STATIC NSString *const AppConfigDictionaryKey = @"AppConfigDictionaryKey";

ZUX_STATIC NSDictionary *appConfigData(id instance);

void specifyZUXAppConfigBundle(const char *className, NSString *bundleName) {
    Class cls = objc_getClass(className);
    [cls setProperty:bundleName forAssociateKey:AppConfigBundleNameKey];
}

void synthesizeAppConfig(const char *className, NSString *propertyName) {
    Class cls = objc_getClass(className);
    ZUXProperty *property = [ZUXProperty propertyWithName:propertyName inClass:cls];
    NSCAssert(property.property, @"Could not find property %s.%@", className, propertyName);
    NSCAssert(property.attributes.count != 0, @"Could not fetch property attributes for %s.%@", className, propertyName);
    NSCAssert(property.memoryManagementPolicy == ZUXPropertyMemoryManagementPolicyRetain,
              @"Does not support un-strong-reference property %s.%@", className, propertyName);
    
    id getter = ^(id self) { return [appConfigData(self) objectForKey:propertyName]; };
    id setter = ^(id self, id value) {};
    if (!class_addMethod(cls, property.getter, imp_implementationWithBlock(getter), "@@:"))
        NSCAssert(NO, @"Could not add getter %s for property %s.%@",
                  sel_getName(property.getter), className, propertyName);
    if (!property.isReadOnly) class_addMethod(cls, property.setter, imp_implementationWithBlock(setter), "v@:@");
}

ZUX_STATIC NSDictionary *appConfigData(id instance) {
    if (ZUX_EXPECT_F(![[instance class] propertyForAssociateKey:AppConfigDictionaryKey])) {
        [[instance class] setProperty:[NSDictionary dictionaryWithContentsOfUserFile:appIdentifier bundle:
                                       [[instance class] propertyForAssociateKey:AppConfigBundleNameKey]] ?: @{}
                      forAssociateKey:AppConfigDictionaryKey];
    }
    return [[instance class] propertyForAssociateKey:AppConfigDictionaryKey];
    
}
