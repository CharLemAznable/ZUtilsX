//
//  ZUXProtocol.h
//  ZUtilsX
//
//  Created by Char Aznable on 16/1/5.
//  Copyright © 2016年 org.cuc.n3. All rights reserved.
//

#ifndef ZUtilsX_ZUXProtocol_h
#define ZUtilsX_ZUXProtocol_h

#import <Foundation/Foundation.h>
#import "zobjc.h"
#import <objc/runtime.h>

@interface ZUXProtocol : NSObject

+ (NSArray *)allProtocols;

+ (ZUXProtocol *)protocolWithObjCProtocol:(Protocol *)protocol;
+ (ZUXProtocol *)protocolWithName:(NSString *)name;

- (ZUX_INSTANCETYPE)initWithObjCProtocol:(Protocol *)protocol;
- (ZUX_INSTANCETYPE)initWithName:(NSString *)name;

- (Protocol *)objCProtocol;
- (NSString *)name;
- (NSArray *)incorporatedProtocols;
- (NSArray *)methodsRequired:(BOOL)isRequiredMethod instance:(BOOL)isInstanceMethod;

@end

#endif /* ZUtilsX_ZUXProtocol_h */
