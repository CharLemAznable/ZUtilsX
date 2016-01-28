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

ZUX_EXTERN NSString *ZUXAppEverLaunchedKey;
ZUX_EXTERN NSString *ZUXAppFirstLaunchKey;

@interface ZUXDataBox : NSObject

+ (BOOL)appEverLaunched;
+ (BOOL)appFirstLaunch;

@end // interface ZUXDataBox

@protocol ZUXDataBox <NSObject>

@required
- (void)synchronize;

@optional
+ (NSString *)defaultShareKey;
+ (NSString *)keychainShareKey;
+ (NSString *)keychainShareDomain;
+ (NSString *)restrictShareKey;
+ (NSString *)restrictShareDomain;
+ (NSString *)defaultUsersKey;
+ (NSString *)keychainUsersKey;
+ (NSString *)keychainUsersDomain;
+ (NSString *)restrictUsersKey;
+ (NSString *)restrictUsersDomain;

@end // protocol ZUXDataBox

// databox_interface
#define databox_interface(className, superClassName)                            \
singleton_interface(className, superClassName) <ZUXDataBox>

// databox_implementation
#define databox_implementation(className)                                       \
singleton_implementation(className)                                             \
ZUX_CONSTRUCTOR void construct_ZUX_DATABOX_##className() {                      \
    constructZUXDataBox(#className);                                            \
}                                                                               \
- (void)synchronize {                                                           \
    @synchronized(self) {                                                       \
        defaultShareDataSynchronize(self);                                      \
        keychainShareDataSynchronize(self);                                     \
        restrictShareDataSynchronize(self);                                     \
        defaultUsersDataSynchronize(self);                                      \
        keychainUsersDataSynchronize(self);                                     \
        restrictUsersDataSynchronize(self);                                     \
    }                                                                           \
}

// default_share
#define default_share(className, property)                                      \
synthesize_constructor(className, property,                                     \
defaultShareData(instance))

// keychain_share
#define keychain_share(className, property)                                     \
synthesize_constructor(className, property,                                     \
keychainShareData(instance))

// restrict_share
#define restrict_share(className, property)                                     \
synthesize_constructor(className, property,                                     \
restrictShareData(instance))

// default_users
#define default_users(className, property, userIdProperty)                      \
synthesize_constructor(className, property,                                     \
defaultUsersData(instance, @#userIdProperty))

// keychain_users
#define keychain_users(className, property, userIdProperty)                     \
synthesize_constructor(className, property,                                     \
keychainUsersData(instance, @#userIdProperty))

// restrict_users
#define restrict_users(className, property, userIdProperty)                     \
synthesize_constructor(className, property,                                     \
restrictUsersData(instance, @#userIdProperty))

// synthesize_constructor
#define synthesize_constructor(className, property, dataRef)                    \
dynamic property;                                                               \
ZUX_CONSTRUCTOR void synthesize_ZUX_DATABOX_##className##_##property() {        \
    synthesizeDataBox(#className, @#property, ^NSDictionary *(id instance) {   \
        return dataRef;                                                         \
    });                                                                         \
}

ZUX_EXTERN void constructZUXDataBox(const char *className);

ZUX_EXTERN void defaultShareDataSynchronize(id instance);
ZUX_EXTERN void keychainShareDataSynchronize(id instance);
ZUX_EXTERN void restrictShareDataSynchronize(id instance);
ZUX_EXTERN void defaultUsersDataSynchronize(id instance);
ZUX_EXTERN void keychainUsersDataSynchronize(id instance);
ZUX_EXTERN void restrictUsersDataSynchronize(id instance);

ZUX_EXTERN NSDictionary *defaultShareData(id instance);
ZUX_EXTERN NSDictionary *keychainShareData(id instance);
ZUX_EXTERN NSDictionary *restrictShareData(id instance);
ZUX_EXTERN NSDictionary *defaultUsersData(id instance, NSString *userIdKey);
ZUX_EXTERN NSDictionary *keychainUsersData(id instance, NSString *userIdKey);
ZUX_EXTERN NSDictionary *restrictUsersData(id instance, NSString *userIdKey);

ZUX_EXTERN void synthesizeDataBox(const char *className, NSString *propertyName, NSDictionary *(^dataRef)(id instance));

#endif /* ZUtilsX_ZUXDataBox_h */
