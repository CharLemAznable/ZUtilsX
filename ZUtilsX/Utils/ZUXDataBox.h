//
//  ZUXDataBox.h
//  ZUtilsX
//
//  Created by Char Aznable on 16/1/15.
//  Copyright © 2016年 org.cuc.n3. All rights reserved.
//

#ifndef ZUtilsX_ZUXDataBox_h
#define ZUtilsX_ZUXDataBox_h

#import <Foundation/Foundation.h>
#import "ZUXSingleton.h"
#import "zconstant.h"

#define ShareUserDefaults               [NSUserDefaults standardUserDefaults]

ZUX_EXTERN NSString *ZUXAppEverLaunchedKey;
ZUX_EXTERN NSString *ZUXAppFirstLaunchKey;

ZUX_EXTERN void constructZUXDataBox(const char *className);
ZUX_EXTERN void synchronizeAppLaunchData();

ZUX_EXTERN void defaultShareDataSynchronize(id instance);
ZUX_EXTERN void keychainShareDataSynchronize(id instance);
ZUX_EXTERN void geisKeychainShareDataSynchronize(id instance);
ZUX_EXTERN void defaultUsersDataSynchronize(id instance);
ZUX_EXTERN void keychainUsersDataSynchronize(id instance);
ZUX_EXTERN void geisKeychainUsersDataSynchronize(id instance);

ZUX_EXTERN NSDictionary *defaultShareData(id instance);
ZUX_EXTERN NSDictionary *keychainShareData(id instance);
ZUX_EXTERN NSDictionary *geisKeychainShareData(id instance);
ZUX_EXTERN NSDictionary *defaultUsersData(id instance, NSString *userIdKey);
ZUX_EXTERN NSDictionary *keychainUsersData(id instance, NSString *userIdKey);
ZUX_EXTERN NSDictionary *geisKeychainUsersData(id instance, NSString *userIdKey);

ZUX_EXTERN void synthesizeProperty(NSString *className, NSString *propertyName, NSDictionary *(^dataRef)(id instance));

@protocol ZUXDataBox <NSObject>

@required

- (BOOL)appEverLaunched;
- (BOOL)appFirstLaunch;
- (void)synchronize;

@optional

+ (NSString *)defaultShareKey;
+ (NSString *)keychainShareKey;
+ (NSString *)keychainShareDomain;
+ (NSString *)geisKeychainShareKey;
+ (NSString *)geisKeychainShareDomain;

+ (NSString *)defaultUsersKey;
+ (NSString *)keychainUsersKey;
+ (NSString *)keychainUsersDomain;
+ (NSString *)geisKeychainUsersKey;
+ (NSString *)geisKeychainUsersDomain;

@end // protocol ZUXDataBox

#define databox_interface(className, superClassName)                            \
singleton_interface(className, superClassName) <ZUXDataBox> // databox_interface

#define databox_implementation(className)                                       \
singleton_implementation(className)                                             \
ZUX_CONSTRUCTOR void construct_ZUX_DATABOX_##className() {                      \
    constructZUXDataBox(#className);                                            \
}                                                                               \
- (BOOL)appEverLaunched {                                                       \
    synchronizeAppLaunchData();                                                 \
    return [ShareUserDefaults boolForKey:ZUXAppEverLaunchedKey];                \
}                                                                               \
- (BOOL)appFirstLaunch {                                                        \
    synchronizeAppLaunchData();                                                 \
    return [ShareUserDefaults boolForKey:ZUXAppFirstLaunchKey];                 \
}                                                                               \
- (void)synchronize {                                                           \
    @synchronized(self) {                                                       \
        defaultShareDataSynchronize(self);                                      \
        keychainShareDataSynchronize(self);                                     \
        geisKeychainShareDataSynchronize(self);                                 \
        defaultUsersDataSynchronize(self);                                      \
        keychainUsersDataSynchronize(self);                                     \
        geisKeychainUsersDataSynchronize(self);                                 \
    }                                                                           \
} // databox_implementation

#define default_share(className, property)                                      \
synthesize_constructor(className, property) {                                   \
    synthesizeProperty(@#className, @#property, ^NSDictionary *(id instance) {  \
        return defaultShareData(instance);                                      \
    });                                                                         \
} // default_share

#define keychain_share(className, property)                                     \
synthesize_constructor(className, property) {                                   \
    synthesizeProperty(@#className, @#property, ^NSDictionary *(id instance) {  \
        return keychainShareData(instance);                                     \
    });                                                                         \
} // keychain_share

#define geis_keychain_share(className, property)                                \
synthesize_constructor(className, property) {                                   \
    synthesizeProperty(@#className, @#property, ^NSDictionary *(id instance) {  \
        return geisKeychainShareData(instance);                                 \
    });                                                                         \
} // geis_keychain_share

#define default_users(className, property, userIdProperty)                      \
synthesize_constructor(className, property) {                                   \
    synthesizeProperty(@#className, @#property, ^NSDictionary *(id instance) {  \
        return defaultUsersData(instance, @#userIdProperty);                    \
    });                                                                         \
} // default_users

#define keychain_users(className, property, userIdProperty)                     \
synthesize_constructor(className, property) {                                   \
    synthesizeProperty(@#className, @#property, ^NSDictionary *(id instance) {  \
        return keychainUsersData(instance, @#userIdProperty);                   \
    });                                                                         \
} // keychain_users

#define geis_keychain_users(className, property, userIdProperty)                \
synthesize_constructor(className, property) {                                   \
    synthesizeProperty(@#className, @#property, ^NSDictionary *(id instance) {  \
        return geisKeychainUsersData(instance, @#userIdProperty);               \
    });                                                                         \
} // geis_keychain_users

#define synthesize_constructor(className, property)                             \
dynamic property;                                                               \
ZUX_CONSTRUCTOR void synthesize_ZUX_DATABOX_##className##_##property() // synthesize_constructor

#endif
