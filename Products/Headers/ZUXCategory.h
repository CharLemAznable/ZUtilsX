//
//  ZUXCategory.h
//  ZUtilsX
//
//  Created by Char Aznable on 15/11/13.
//  Copyright © 2015年 org.cuc.n3. All rights reserved.
//

#ifndef ZUtilsX_ZUXCategory_h
#define ZUtilsX_ZUXCategory_h

#define ZUX_CATEGORY_H(name) \
@interface ZUX_CATEGORY_##name : NSObject \
+ (void)declare; \
@end

#define ZUX_CATEGORY_M(name) \
@implementation ZUX_CATEGORY_##name \
+ (void)declare { ; } \
@end

#define ZUX_ENABLE_CATEGORY(name) [ZUX_CATEGORY_##name declare]

#endif /* ZUtilsX_ZUXCategory_h */
