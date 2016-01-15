//
//  zconstant.h
//  ZUtilsX
//
//  Created by Char Aznable on 15/11/17.
//  Copyright © 2015年 org.cuc.n3. All rights reserved.
//

#ifndef ZUtilsX_zconstant_h
#define ZUtilsX_zconstant_h

#ifdef DEBUG
# define ZLog(fmt, ...)     NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
# define ZLog(...)
#endif

#define appIdentifier       [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"]
#define appVersion          [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]

#endif /* ZUtilsX_zconstant_h */
