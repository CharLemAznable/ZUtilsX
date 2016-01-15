//
//  ZUXKeychain.h
//  ZUtilsX
//
//  Created by Char Aznable on 15/12/14.
//  Copyright © 2015年 org.cuc.n3. All rights reserved.
//

#ifndef ZUtilsX_ZUXKeychain_h
#define ZUtilsX_ZUXKeychain_h

#import <Foundation/Foundation.h>

@interface ZUXKeychain : NSObject

+ (NSString *)passwordForUsername:(NSString *)username andService:(NSString *)service error:(NSError **)error;
+ (BOOL)storePassword:(NSString *)password forUsername:(NSString *)username andService:(NSString *)service updateExisting:(BOOL)updateExisting error:(NSError **)error;
+ (BOOL)deletePasswordForUsername:(NSString *)username andService:(NSString *)service error:(NSError **)error;

@end

#endif /* ZUtilsX_ZUXKeychain_h */
