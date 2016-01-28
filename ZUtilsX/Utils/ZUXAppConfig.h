//
//  ZUXAppConfig.h
//  ZUtilsX
//
//  Created by Char Aznable on 16/1/28.
//  Copyright © 2016年 org.cuc.n3. All rights reserved.
//

#ifndef ZUtilsX_ZUXAppConfig_h
#define ZUtilsX_ZUXAppConfig_h

#import <Foundation/Foundation.h>
#import "ZUXSingleton.h"

// appconfig_interface
#define appconfig_interface(className, superClassName)                      \
singleton_interface(className, superClassName)

// appconfig_implementation
#define appconfig_implementation(className)                                 \
singleton_implementation(className)

// appconfig_bundle
#define appconfig_bundle(className, bundleName)                             \
ZUX_CONSTRUCTOR void init_ZUX_APPCONFIG_##className##_bundle() {            \
    specifyZUXAppConfigBundle(#className, @#bundleName);                    \
}

// appconfig
#define appconfig(className, property)                                      \
dynamic property;                                                           \
ZUX_CONSTRUCTOR void synthesize_ZUX_APPCONFIG_##className##_##property() {  \
    synthesizeAppConfig(#className, @#property);                           \
}

ZUX_EXTERN void specifyZUXAppConfigBundle(const char *className, NSString *bundleName);
ZUX_EXTERN void synthesizeAppConfig(const char *className, NSString *propertyName);

#endif /* ZUtilsX_ZUXAppConfig_h */
