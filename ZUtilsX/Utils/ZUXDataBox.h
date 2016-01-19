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

+ (NSString *)publicShareKey;
+ (NSString *)protectedShareKey;
+ (NSString *)protectedShareDomain;
+ (NSString *)privateShareKey;
+ (NSString *)privateShareDomain;

+ (NSString *)publicUsersKey;
+ (NSString *)protectedUsersKey;
+ (NSString *)protectedUsersDomain;
+ (NSString *)privateUsersKey;
+ (NSString *)privateUsersDomain;

@end // protocol ZUXDataBox

#pragma mark - databox_interface

#define databox_interface(className, superClassName)                                        \
singleton_interface(className, superClassName) <ZUXDataBox>                                 \
- (void)synchronize;                                                                        

#pragma mark - databox_implementation

#define databox_implementation(className)                                                   \
singleton_implementation(className)                                                         \
static NSString *_publicShare##className##Key;                                              \
static NSString *_protectedShare##className##Key;                                           \
static NSString *_protectedShare##className##Domain;                                        \
static NSString *_privateShare##className##Key;                                             \
static NSString *_privateShare##className##Domain;                                          \
                                                                                            \
static NSString *_publicUsers##className##Key;                                              \
static NSString *_protectedUsers##className##Key;                                           \
static NSString *_protectedUsers##className##Domain;                                        \
static NSString *_privateUsers##className##Key;                                             \
static NSString *_privateUsers##className##Domain;                                          \
+ (void)load {                                                                              \
    static dispatch_once_t once_t;                                                          \
    dispatch_once(&once_t, ^{                                                               \
        _publicShare##className##Key = ZUX_RETAIN(                                          \
        [self respondsToSelector:@selector(publicShareKey)] ?                               \
        [self publicShareKey] : ClassKeyFormat(className, PublicShare));                    \
                                                                                            \
        _protectedShare##className##Key = ZUX_RETAIN(                                       \
        [self respondsToSelector:@selector(protectedShareKey)] ?                            \
        [self protectedShareKey] : ClassKeyFormat(className, ProtectedShare));              \
                                                                                            \
        _protectedShare##className##Domain = ZUX_RETAIN(                                    \
        [self respondsToSelector:@selector(protectedShareDomain)] ?                         \
        [self protectedShareDomain] : ClassKeyFormat(className, ProtectedShareDomain));     \
                                                                                            \
        _privateShare##className##Key = ZUX_RETAIN(                                         \
        [self respondsToSelector:@selector(privateShareKey)] ?                              \
        [self privateShareKey] : ClassKeyFormat(className, PrivateShare));                  \
                                                                                            \
        _privateShare##className##Domain = ZUX_RETAIN(                                      \
        [self respondsToSelector:@selector(privateShareDomain)] ?                           \
        [self privateShareDomain] : ClassKeyFormat(className, PrivateShareDomain));         \
                                                                                            \
        _publicUsers##className##Key = ZUX_RETAIN(                                          \
        [self respondsToSelector:@selector(publicUsersKey)] ?                               \
        [self publicUsersKey] : ClassKeyFormat(className, PublicUsers));                    \
                                                                                            \
        _protectedUsers##className##Key = ZUX_RETAIN(                                       \
        [self respondsToSelector:@selector(protectedUsersKey)] ?                            \
        [self protectedUsersKey] : ClassKeyFormat(className, ProtectedUsers));              \
                                                                                            \
        _protectedUsers##className##Domain = ZUX_RETAIN(                                    \
        [self respondsToSelector:@selector(protectedUsersDomain)] ?                         \
        [self protectedUsersDomain] : ClassKeyFormat(className, ProtectedUsersDomain));     \
                                                                                            \
        _privateUsers##className##Key = ZUX_RETAIN(                                         \
        [self respondsToSelector:@selector(privateUsersKey)] ?                              \
        [self privateUsersKey] : ClassKeyFormat(className, PrivateUsers));                  \
                                                                                            \
        _privateUsers##className##Domain = ZUX_RETAIN(                                      \
        [self respondsToSelector:@selector(privateUsersDomain)] ?                           \
        [self privateUsersDomain] : ClassKeyFormat(className, PrivateUsersDomain));         \
    });                                                                                     \
}                                                                                           \
- (void)synchronize {                                                                       \
    @synchronized(self) {                                                                   \
        publicDataSynchronize(self, _publicShare##className##Key);                          \
        protectedDataSynchronize(self, _protectedShare##className##Key,                     \
                                 _protectedShare##className##Domain);                       \
        privateDataSynchronize(self, _privateShare##className##Key,                         \
                               _privateShare##className##Domain);                           \
        publicDataSynchronize(self, _publicUsers##className##Key);                          \
        protectedDataSynchronize(self, _protectedUsers##className##Key,                     \
                                 _protectedUsers##className##Domain);                       \
        privateDataSynchronize(self, _privateUsers##className##Key,                         \
                               _privateUsers##className##Domain);                           \
    }                                                                                       \
}

#pragma mark - share_public_synthesize

#define share_public_synthesize(className, property)                                        \
dynamic property;                                                                           \
__attribute__((constructor))                                                                \
static void synthesize_ZUX_DATABOX_##className##_##property() {                             \
    synthesizeZUXDataBoxProperty(@#className, @#property, ^NSDictionary *(id instance) {    \
        return publicData(instance, _publicShare##className##Key);                          \
    });                                                                                     \
}

#pragma mark - share_protected_synthesize

#define share_protected_synthesize(className, property)                                     \
dynamic property;                                                                           \
__attribute__((constructor))                                                                \
static void synthesize_ZUX_DATABOX_##className##_##property() {                             \
    synthesizeZUXDataBoxProperty(@#className, @#property, ^NSDictionary *(id instance) {    \
        return protectedData(instance, _protectedShare##className##Key,                     \
                             _protectedShare##className##Domain);                           \
    });                                                                                     \
}

#pragma mark - share_private_synthesize

#define share_private_synthesize(className, property)                                       \
dynamic property;                                                                           \
__attribute__((constructor))                                                                \
static void synthesize_ZUX_DATABOX_##className##_##property() {                             \
    synthesizeZUXDataBoxProperty(@#className, @#property, ^NSDictionary *(id instance) {    \
        return privateData(instance, _privateShare##className##Key,                         \
                           _privateShare##className##Domain);                               \
    });                                                                                     \
}

#pragma mark - users_public_synthesize

#define users_public_synthesize(className, property, userIdProperty)                        \
dynamic property;                                                                           \
__attribute__((constructor))                                                                \
static void synthesize_ZUX_DATABOX_##className##_##property() {                             \
    synthesizeZUXDataBoxProperty(@#className, @#property, ^NSDictionary *(id instance) {    \
        return userDataRef(publicData(instance, _publicUsers##className##Key),              \
                           [instance valueForKey:@#userIdProperty]);                        \
    });                                                                                     \
}

#pragma mark - users_protected_synthesize

#define users_protected_synthesize(className, property, userIdProperty)                     \
dynamic property;                                                                           \
__attribute__((constructor))                                                                \
static void synthesize_ZUX_DATABOX_##className##_##property() {                             \
    synthesizeZUXDataBoxProperty(@#className, @#property, ^NSDictionary *(id instance) {    \
        return userDataRef(protectedData(instance, _protectedUsers##className##Key,         \
                                         _protectedUsers##className##Domain),               \
                           [instance valueForKey:@#userIdProperty]);                        \
    });                                                                                     \
}

#pragma mark - users_private_synthesize

#define users_private_synthesize(className, property, userIdProperty)                       \
dynamic property;                                                                           \
__attribute__((constructor))                                                                \
static void synthesize_ZUX_DATABOX_##className##_##property() {                             \
    synthesizeZUXDataBoxProperty(@#className, @#property, ^NSDictionary *(id instance) {    \
        return userDataRef(privateData(instance, _privateUsers##className##Key,             \
                                       _privateUsers##className##Domain),                   \
                           [instance valueForKey:@#userIdProperty]);                        \
    });                                                                                     \
}

#pragma mark - Implementation methods

void synthesizeZUXDataBoxProperty(NSString *className, NSString *propertyName,
                                  NSDictionary *(^dataRefBlock)(id instance));
NSDictionary *userDataRef(NSDictionary *dataRef, NSString *userId);

NSDictionary *publicData(id instance, NSString *key);
NSDictionary *protectedData(id instance, NSString *key, NSString *domain);
NSDictionary *privateData(id instance, NSString *key, NSString *domain);

void publicDataSynchronize(id instance, NSString *key);
void protectedDataSynchronize(id instance, NSString *key, NSString *domain);
void privateDataSynchronize(id instance, NSString *key, NSString *domain);

#endif
