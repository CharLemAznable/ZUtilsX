//
//  zconstant.h
//  ZUtilsX
//
//  Created by Char Aznable on 15/11/17.
//  Copyright © 2015年 org.cuc.n3. All rights reserved.
//

#ifndef ZUtilsX_zconstant_h
#define ZUtilsX_zconstant_h

#define appIdentifier                   [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"]
#define appVersion                      [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]

#define ZUX_ENABLE_ALL_CATEGORIES \
ZUX_ENABLE_CATEGORY(ZUX_NSObject); \
ZUX_ENABLE_CATEGORY(ZUXJson_NSObject); \
ZUX_ENABLE_CATEGORY(ZUX_NSNull); \
ZUX_ENABLE_CATEGORY(ZUX_NSNumber); \
ZUX_ENABLE_CATEGORY(ZUX_NSCoder); \
ZUX_ENABLE_CATEGORY(ZUX_NSArray); \
ZUX_ENABLE_CATEGORY(ZUX_NSDictionary); \
ZUX_ENABLE_CATEGORY(ZUX_NSData); \
ZUX_ENABLE_CATEGORY(ZUX_NSString); \
ZUX_ENABLE_CATEGORY(ZUX_NSValue); \
ZUX_ENABLE_CATEGORY(ZUX_NSExpression); \
ZUX_ENABLE_CATEGORY(ZUX_NSDate); \
ZUX_ENABLE_CATEGORY(ZUX_UIDevice); \
ZUX_ENABLE_CATEGORY(ZUX_UIView); \
ZUX_ENABLE_CATEGORY(ZUX_UIControl); \
ZUX_ENABLE_CATEGORY(ZUX_UILabel); \
ZUX_ENABLE_CATEGORY(ZUX_UIImage); \
ZUX_ENABLE_CATEGORY(ZUX_UITextField); \
ZUX_ENABLE_CATEGORY(ZUX_UITextView); \
ZUX_ENABLE_CATEGORY(ZUX_UIColor); \
ZUX_ENABLE_CATEGORY(ZUX_UITabBarItem); \
ZUX_ENABLE_CATEGORY(ZUX_UIViewController); \
ZUX_ENABLE_CATEGORY(ZUX_MBProgressHUD)

#endif /* ZUtilsX_zconstant_h */
