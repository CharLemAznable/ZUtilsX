//
//  ZUXKeychain.m
//  ZUtilsX
//
//  Created by Char Aznable on 15/12/14.
//  Copyright © 2015年 org.cuc.n3. All rights reserved.
//

#import "ZUXKeychain.h"
#import <Security/Security.h>
#import "zobjc.h"
#import "zarc.h"

#define ZUXKeychainErrorExpect(condition, errorCondition, error, errorCode, errorReturn) \
if (ZUX_EXPECT_F(condition)) { \
    if (errorCondition) \
        *(error) = [NSError errorWithDomain:@"ZUXKeychainErrorDomain" code:(errorCode) userInfo:nil]; \
    return (errorReturn); \
}

#define ZUXKeychainErrorExpectDefault(condition, error, errorCode, errorReturn) \
ZUXKeychainErrorExpect(condition, (error) != nil, error, errorCode, errorReturn)

@implementation ZUXKeychain

+ (NSString *)passwordForUsername:(NSString *)username andService:(NSString *)service error:(NSError **)error {
    ZUXKeychainErrorExpectDefault(!username || !service, error, -2000, nil)
    
    if (error != nil) *error = nil;
    NSDictionary *query = @{(NSString *)kSecClass : (NSString *)kSecClassGenericPassword,
                            (NSString *)kSecAttrAccount : username,
                            (NSString *)kSecAttrService : service};
    NSMutableDictionary *attributeQuery = [query mutableCopy];
    [attributeQuery setObject:(id)kCFBooleanTrue forKey:(id)kSecReturnAttributes];
    CFTypeRef attributeResultRef = NULL;
    OSStatus status = SecItemCopyMatching((CFDictionaryRef)attributeQuery, &attributeResultRef);
    ZUX_RELEASE((ZUX_BRIDGE_TRANSFER id)attributeResultRef);
    ZUX_RELEASE(attributeQuery);
    ZUXKeychainErrorExpect(status != noErr, (error) != nil && status != errSecItemNotFound, error, status, nil)
    
    NSMutableDictionary *passwordQuery = [query mutableCopy];
    [passwordQuery setObject:(id)kCFBooleanTrue forKey:(id)kSecReturnData];
    CFTypeRef resultDataRef = NULL;
    status = SecItemCopyMatching((CFDictionaryRef)passwordQuery, &resultDataRef);
    NSData *resultData = ZUX_AUTORELEASE((ZUX_BRIDGE_TRANSFER NSData *)resultDataRef);
    ZUX_RELEASE(passwordQuery);
    ZUXKeychainErrorExpectDefault(status != noErr, error, status == errSecItemNotFound ? -1999 : status, nil)
    ZUXKeychainErrorExpectDefault(!resultData, error, -1999, nil)
    
    return ZUX_AUTORELEASE([[NSString alloc] initWithData:resultData encoding:NSUTF8StringEncoding]);
}

+ (BOOL)storePassword:(NSString *)password forUsername:(NSString *)username andService:(NSString *)service updateExisting:(BOOL)updateExisting error:(NSError **)error {
    ZUXKeychainErrorExpectDefault(!password || !username || !service, error, -2000, NO)
    
    NSError *existingError = nil;
    NSString *existingPassword = [self passwordForUsername:username andService:service error:&existingError];
    if (existingError.code == -1999) {
        existingError = nil;
        [self deletePasswordForUsername:username andService:service error:&existingError];
        if (existingError.code != noErr) {
            if (error != nil) *error = existingError;
            return NO;
        }
    } else if ([existingError code] != noErr) {
        if (error != nil) *error = existingError;
        return NO;
    }
    
    if (error != nil) *error = nil;
    OSStatus status = noErr;
    if (existingPassword) {
        if (![existingPassword isEqualToString:password] && updateExisting) {
            NSDictionary *query = @{(NSString *)kSecClass : (NSString *)kSecClassGenericPassword,
                                    (NSString *)kSecAttrService : service,
                                    (NSString *)kSecAttrLabel : service,
                                    (NSString *)kSecAttrAccount : username};
            NSDictionary *sec = @{(NSString *)kSecValueData : [password dataUsingEncoding:NSUTF8StringEncoding]};
            status = SecItemUpdate((CFDictionaryRef)query, (CFDictionaryRef)sec);
        }
    } else {
        NSDictionary *query = @{(NSString *)kSecClass : (NSString *)kSecClassGenericPassword,
                                (NSString *)kSecAttrService : service,
                                (NSString *)kSecAttrLabel : service,
                                (NSString *)kSecAttrAccount : username,
                                (NSString *)kSecValueData : [password dataUsingEncoding:NSUTF8StringEncoding]};
        status = SecItemAdd((CFDictionaryRef)query, NULL);
    }
    
    ZUXKeychainErrorExpectDefault(status != noErr, error, status, NO)
    return YES;
}

+ (BOOL)deletePasswordForUsername:(NSString *)username andService:(NSString *)service error:(NSError **)error {
    ZUXKeychainErrorExpectDefault(!username || !service, error, -2000, NO)
    
    if (error != nil) *error = nil;
    NSDictionary *query = @{(NSString *)kSecClass : (NSString *)kSecClassGenericPassword,
                            (NSString *)kSecAttrAccount : username,
                            (NSString *)kSecAttrService : service,
                            (NSString *)kSecReturnAttributes : (id)kCFBooleanTrue};
    OSStatus status = SecItemDelete((CFDictionaryRef)query);
    ZUXKeychainErrorExpectDefault(status != noErr, error, status, NO)
    return YES;
}

@end
