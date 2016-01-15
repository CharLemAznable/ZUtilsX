//
//  ZUXCategory.h
//  ZUtilsX
//
//  Created by Char Aznable on 15/11/13.
//  Copyright © 2015年 org.cuc.n3. All rights reserved.
//

#ifndef ZUtilsX_ZUXCategory_h
#define ZUtilsX_ZUXCategory_h

#import "zobjc.h"

#define enable_category_constructor(CLASS_NAME, CATEGORY_NAME)                  \
__attribute__((constructor))                                                    \
ZUX_STATIC void enable_ZUX_CATEGORY_##CLASS_NAME##_##CATEGORY_NAME()            \
{ [ZUX_CATEGORY_##CLASS_NAME##_##CATEGORY_NAME declare]; }

#define category_interface(CLASS_NAME, CATEGORY_NAME)                           \
interface ZUX_CATEGORY_##CLASS_NAME##_##CATEGORY_NAME : NSObject                \
+ (void)declare;                                                                \
@end                                                                            \
enable_category_constructor(CLASS_NAME, CATEGORY_NAME)                          \
@interface CLASS_NAME (CATEGORY_NAME)

#define category_interface_generic(CLASS_NAME, GENERIC_PARAM, CATEGORY_NAME)    \
interface ZUX_CATEGORY_##CLASS_NAME##_##CATEGORY_NAME : NSObject                \
+ (void)declare;                                                                \
@end                                                                            \
enable_category_constructor(CLASS_NAME, CATEGORY_NAME)                          \
@interface CLASS_NAME GENERIC_PARAM (CATEGORY_NAME)

#define category_implementation(CLASS_NAME, CATEGORY_NAME)                      \
implementation ZUX_CATEGORY_##CLASS_NAME##_##CATEGORY_NAME                      \
+ (void)declare { ; }                                                           \
@end                                                                            \
@implementation CLASS_NAME (CATEGORY_NAME)

#endif /* ZUtilsX_ZUXCategory_h */
