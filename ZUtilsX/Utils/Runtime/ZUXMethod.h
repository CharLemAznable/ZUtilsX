//
//  ZUXMethod.h
//  ZUtilsX
//
//  Created by Char Aznable on 16/1/5.
//  Copyright © 2016年 org.cuc.n3. All rights reserved.
//

#ifndef ZUtilsX_ZUXMethod_h
#define ZUtilsX_ZUXMethod_h

#import <Foundation/Foundation.h>
#import "zobjc.h"
#import <objc/runtime.h>

@interface ZUXMethod : NSObject

+ (ZUXMethod *)methodWithObjCMethod:(Method)method;
+ (ZUXMethod *)instanceMethodWithName:(NSString *)name inClass:(Class)cls;
+ (ZUXMethod *)classMethodWithName:(NSString *)name inClass:(Class)cls;
+ (ZUXMethod *)methodWithSelector:(SEL)sel implementation:(IMP)imp signature:(NSString *)signature;

- (ZUX_INSTANCETYPE)initWithObjCMethod:(Method)method;
- (ZUX_INSTANCETYPE)initInstanceMethodWithName:(NSString *)name inClass:(Class)cls;
- (ZUX_INSTANCETYPE)initClassMethodWithName:(NSString *)name inClass:(Class)cls;
- (ZUX_INSTANCETYPE)initWithSelector:(SEL)sel implementation:(IMP)imp signature:(NSString *)signature;

- (SEL)selector;
- (NSString *)selectorName;
- (IMP)implementation;
- (void)setImplementation:(IMP)imp;
- (NSString *)signature;

@end

#endif /* ZUtilsX_ZUXMethod_h */
