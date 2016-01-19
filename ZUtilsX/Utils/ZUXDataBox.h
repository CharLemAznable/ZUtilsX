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
#define AppKeyFormat(key)               [NSString stringWithFormat:@"%@."@#key, appIdentifier]
#define ClassKeyFormat(className, key)  [NSString stringWithFormat:@"%@."@#className@"."@#key, appIdentifier]

@interface ZUXDataBox : NSObject

extern NSString *const zuxAppEverLaunchedKey;
extern NSString *const zuxAppFirstLaunchKey;

+ (BOOL)appEverLaunched;
+ (BOOL)appFirstLaunch;

@end // ZUXDataBox: app launch info.

@protocol ZUXDataBox <NSObject>

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

#define databox_interface(className, superClassName)                                            \
singleton_interface(className, superClassName) <ZUXDataBox>                                     \
- (void)synchronize; // databox_interface

#define databox_implementation(className)                                                       \
singleton_implementation(className)                                                             \
static NSString *_defaultShare##className##Key;                                                 \
static NSString *_keychainShare##className##Key;                                                \
static NSString *_keychainShare##className##Domain;                                             \
static NSString *_geisKeychainShare##className##Key;                                            \
static NSString *_geisKeychainShare##className##Domain;                                         \
static NSString *_defaultUsers##className##Key;                                                 \
static NSString *_keychainUsers##className##Key;                                                \
static NSString *_keychainUsers##className##Domain;                                             \
static NSString *_geisKeychainUsers##className##Key;                                            \
static NSString *_geisKeychainUsers##className##Domain;                                         \
+ (void)load {                                                                                  \
    static dispatch_once_t once_t;                                                              \
    dispatch_once(&once_t, ^{                                                                   \
        _defaultShare##className##Key = ZUX_RETAIN(                                             \
        [self respondsToSelector:@selector(defaultShareKey)] ?                                  \
        [self defaultShareKey] : ClassKeyFormat(className, DefaultShare));                      \
                                                                                                \
        _keychainShare##className##Key = ZUX_RETAIN(                                            \
        [self respondsToSelector:@selector(keychainShareKey)] ?                                 \
        [self keychainShareKey] : ClassKeyFormat(className, KeychainShare));                    \
                                                                                                \
        _keychainShare##className##Domain = ZUX_RETAIN(                                         \
        [self respondsToSelector:@selector(keychainShareDomain)] ?                              \
        [self keychainShareDomain] : ClassKeyFormat(className, KeychainShareDomain));           \
                                                                                                \
        _geisKeychainShare##className##Key = ZUX_RETAIN(                                        \
        [self respondsToSelector:@selector(geisKeychainShareKey)] ?                             \
        [self geisKeychainShareKey] : ClassKeyFormat(className, GeisKeychainShare));            \
                                                                                                \
        _geisKeychainShare##className##Domain = ZUX_RETAIN(                                     \
        [self respondsToSelector:@selector(geisKeychainShareDomain)] ?                          \
        [self geisKeychainShareDomain] : ClassKeyFormat(className, GeisKeychainShareDomain));   \
                                                                                                \
        _defaultUsers##className##Key = ZUX_RETAIN(                                             \
        [self respondsToSelector:@selector(defaultUsersKey)] ?                                  \
        [self defaultUsersKey] : ClassKeyFormat(className, DefaultUsers));                      \
                                                                                                \
        _keychainUsers##className##Key = ZUX_RETAIN(                                            \
        [self respondsToSelector:@selector(keychainUsersKey)] ?                                 \
        [self keychainUsersKey] : ClassKeyFormat(className, KeychainUsers));                    \
                                                                                                \
        _keychainUsers##className##Domain = ZUX_RETAIN(                                         \
        [self respondsToSelector:@selector(keychainUsersDomain)] ?                              \
        [self keychainUsersDomain] : ClassKeyFormat(className, KeychainUsersDomain));           \
                                                                                                \
        _geisKeychainUsers##className##Key = ZUX_RETAIN(                                        \
        [self respondsToSelector:@selector(geisKeychainUsersKey)] ?                             \
        [self geisKeychainUsersKey] : ClassKeyFormat(className, GeisKeychainUsers));            \
                                                                                                \
        _geisKeychainUsers##className##Domain = ZUX_RETAIN(                                     \
        [self respondsToSelector:@selector(geisKeychainUsersDomain)] ?                          \
        [self geisKeychainUsersDomain] : ClassKeyFormat(className, GeisKeychainUsersDomain));   \
    });                                                                                         \
}                                                                                               \
- (void)synchronize {                                                                           \
    @synchronized(self) {                                                                       \
        defaultDataSynchronize(self, _defaultShare##className##Key);                            \
        keychainDataSynchronize(self, _keychainShare##className##Key,                           \
                                _keychainShare##className##Domain);                             \
        geisKeychainDataSynchronize(self, _geisKeychainShare##className##Key,                   \
                                    _geisKeychainShare##className##Domain);                     \
        defaultDataSynchronize(self, _defaultUsers##className##Key);                            \
        keychainDataSynchronize(self, _keychainUsers##className##Key,                           \
                                _keychainUsers##className##Domain);                             \
        geisKeychainDataSynchronize(self, _geisKeychainUsers##className##Key,                   \
                                    _geisKeychainUsers##className##Domain);                     \
    }                                                                                           \
} // databox_implementation

#define default_share(className, property)                                                      \
synthesize_constructor(className, property) {                                                   \
    synthesizeZUXDataBoxProperty(@#className, @#property, ^NSDictionary *(id instance) {        \
        return defaultData(instance, _defaultShare##className##Key);                            \
    });                                                                                         \
} // default_share

#define keychain_share(className, property)                                                     \
synthesize_constructor(className, property) {                                                   \
    synthesizeZUXDataBoxProperty(@#className, @#property, ^NSDictionary *(id instance) {        \
        return keychainData(instance, _keychainShare##className##Key,                           \
                            _keychainShare##className##Domain);                                 \
    });                                                                                         \
} // keychain_share

#define geis_keychain_share(className, property)                                                \
synthesize_constructor(className, property) {                                                   \
    synthesizeZUXDataBoxProperty(@#className, @#property, ^NSDictionary *(id instance) {        \
        return geisKeychainData(instance, _geisKeychainShare##className##Key,                   \
                                _geisKeychainShare##className##Domain);                         \
    });                                                                                         \
} // geis_keychain_share

#define default_users(className, property, userIdProperty)                                      \
synthesize_constructor(className, property) {                                                   \
    synthesizeZUXDataBoxProperty(@#className, @#property, ^NSDictionary *(id instance) {        \
        return userDataRef(defaultData(instance, _defaultUsers##className##Key),                \
                           [instance valueForKey:@#userIdProperty]);                            \
    });                                                                                         \
} // default_users

#define keychain_users(className, property, userIdProperty)                                     \
synthesize_constructor(className, property) {                                                   \
    synthesizeZUXDataBoxProperty(@#className, @#property, ^NSDictionary *(id instance) {        \
        return userDataRef(keychainData(instance, _keychainUsers##className##Key,               \
                                        _keychainUsers##className##Domain),                     \
                           [instance valueForKey:@#userIdProperty]);                            \
    });                                                                                         \
} // keychain_users

#define geis_keychain_users(className, property, userIdProperty)                                \
synthesize_constructor(className, property) {                                                   \
    synthesizeZUXDataBoxProperty(@#className, @#property, ^NSDictionary *(id instance) {        \
        return userDataRef(geisKeychainData(instance, _geisKeychainUsers##className##Key,       \
                                            _geisKeychainUsers##className##Domain),             \
                           [instance valueForKey:@#userIdProperty]);                            \
    });                                                                                         \
} // geis_keychain_users

#define synthesize_constructor(className, property)                                             \
dynamic property;                                                                               \
ZUX_CONSTRUCTOR void synthesize_ZUX_DATABOX_##className##_##property() // synthesize_constructor

#pragma mark - Implementation methods

void synthesizeZUXDataBoxProperty(NSString *className, NSString *propertyName,
                                  NSDictionary *(^dataRefBlock)(id instance));
NSDictionary *userDataRef(NSDictionary *dataRef, NSString *userId);

NSDictionary *defaultData(id instance, NSString *key);
NSDictionary *keychainData(id instance, NSString *key, NSString *domain);
NSDictionary *geisKeychainData(id instance, NSString *key, NSString *domain);

void defaultDataSynchronize(id instance, NSString *key);
void keychainDataSynchronize(id instance, NSString *key, NSString *domain);
void geisKeychainDataSynchronize(id instance, NSString *key, NSString *domain);

#endif
