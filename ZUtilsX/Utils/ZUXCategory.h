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

#define enable_category_constructor(className, categoryName)                    \
__attribute__((constructor))                                                    \
ZUX_STATIC void enable_ZUX_CATEGORY_##className##_##categoryName()              \
{ [ZUX_CATEGORY_##className##_##categoryName declare]; }

#define category_interface(className, categoryName)                             \
interface ZUX_CATEGORY_##className##_##categoryName : NSObject                  \
+ (void)declare;                                                                \
@end                                                                            \
enable_category_constructor(className, categoryName)                            \
@interface className (categoryName)

#define category_interface_generic(className, genericParam, categoryName)       \
interface ZUX_CATEGORY_##className##_##categoryName : NSObject                  \
+ (void)declare;                                                                \
@end                                                                            \
enable_category_constructor(className, categoryName)                            \
@interface className genericParam (categoryName)

#define category_implementation(className, categoryName)                        \
implementation ZUX_CATEGORY_##className##_##categoryName                        \
+ (void)declare { ; }                                                           \
@end                                                                            \
@implementation className (categoryName)

#endif /* ZUtilsX_ZUXCategory_h */
