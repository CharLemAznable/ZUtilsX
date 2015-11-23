//
//  NSObject+ZUX.h
//  ZUtilsX
//
//  Created by Char Aznable on 15/11/13.
//  Copyright © 2015年 org.cuc.n3. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZUXCategory.h"

ZUX_CATEGORY_H(ZUX_NSObject)

@interface NSObject (ZUX)

+ (void)swizzleInstanceOriSelector:(SEL)oriSelector withNewSelector:(SEL)newSelector;
+ (void)swizzleClassOriSelector:(SEL)oriSelector withNewSelector:(SEL)newSelector;

- (void)addObserver:(NSObject *)observer forKeyPaths:(NSArray *)keyPaths options:(NSKeyValueObservingOptions)options context:(void *)context;
- (void)removeObserver:(NSObject *)observer forKeyPaths:(NSArray *)keyPaths context:(void *)context;
- (void)removeObserver:(NSObject *)observer forKeyPaths:(NSArray *)keyPaths;

@end
