//
//  ZUXIvar.h
//  ZUtilsX
//
//  Created by Char Aznable on 16/1/5.
//  Copyright © 2016年 org.cuc.n3. All rights reserved.
//

#ifndef ZUtilsX_ZUXIvar_h
#define ZUtilsX_ZUXIvar_h

#import <Foundation/Foundation.h>
#import "zobjc.h"
#import <objc/runtime.h>

@interface ZUXIvar : NSObject

+ (ZUXIvar *)ivarWithObjCIvar:(Ivar)ivar;
+ (ZUXIvar *)instanceIvarWithName:(NSString *)name inClass:(Class)cls;
+ (ZUXIvar *)classIvarWithName:(NSString *)name inClass:(Class)cls;
+ (ZUXIvar *)ivarWithName:(NSString *)name typeEncoding:(NSString *)typeEncoding;
+ (ZUXIvar *)ivarWithName:(NSString *)name encode:(const char *)encodeStr;

- (ZUX_INSTANCETYPE)initWithObjCIvar:(Ivar)ivar;
- (ZUX_INSTANCETYPE)initInstanceIvarWithName:(NSString *)name inClass:(Class)cls;
- (ZUX_INSTANCETYPE)initClassIvarWithName:(NSString *)name inClass:(Class)cls;
- (ZUX_INSTANCETYPE)initWithName:(NSString *)name typeEncoding:(NSString *)typeEncoding;

- (NSString *)name;
- (NSString *)typeName;
- (NSString *)typeEncoding;
- (ptrdiff_t)offset;

@end

#endif /* ZUtilsX_ZUXIvar_h */
